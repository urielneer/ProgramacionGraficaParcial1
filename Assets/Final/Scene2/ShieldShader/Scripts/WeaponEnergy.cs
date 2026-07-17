using System;
using System.Collections;
using UnityEngine;

// Arma de energía del NPC atacante (Escena 2 - Sci-Fi).
// Ciclo: Idle -> Cargando (mientras se mantiene el gatillo) -> Disparando -> vuelta a Idle.
// La carga anima _ChargeAmount en el material del núcleo (SH_WeaponCharge) y dispara
// un EnergyProjectile con la potencia acumulada al momento del disparo.
public class WeaponEnergy : MonoBehaviour
{
    public enum EstadoArma { Idle, Cargando, Disparando }

    [Header("Carga")]
    [SerializeField] private float duracionCargaCompleta = 1.5f;
    [SerializeField] private Transform cañon;
    [SerializeField] private Renderer nucleoEnergia; // mesh con material SH_WeaponCharge
    [SerializeField] private ParticleSystem particulasDeCarga;

    [Header("Disparo")]
    [SerializeField] private EnergyProjectile prefabProyectil;
    [SerializeField] private ParticleSystem particulasDeDisparo; // muzzle flash
    [SerializeField] private float velocidadProyectil = 40f;

    private static readonly int ChargeAmountID = Shader.PropertyToID("_ChargeAmount");

    private Material materialInstancia;
    private Coroutine rutinaCarga;
    private float cargaActual;

    public EstadoArma Estado { get; private set; } = EstadoArma.Idle;

    // La UI (WeaponChargeUI) y cualquier otro sistema pueden suscribirse a esto
    public event Action<float> OnCargaCambiada;
    public event Action OnDisparo;

    private void Awake()
    {
        materialInstancia = nucleoEnergia.material;
        SetCarga(0f);
    }

    public void EmpezarCarga()
    {
        if (Estado != EstadoArma.Idle) return;

        Estado = EstadoArma.Cargando;
        if (particulasDeCarga != null) particulasDeCarga.Play();
        rutinaCarga = StartCoroutine(Cargar());
    }

    // Si se corta la carga antes de llegar al máximo, igual dispara con la carga parcial acumulada.
    public void SoltarYDisparar()
    {
        if (Estado != EstadoArma.Cargando) return;
        if (rutinaCarga != null) StopCoroutine(rutinaCarga);
        Disparar();
    }

    private IEnumerator Cargar()
    {
        float t = 0f;
        while (t < duracionCargaCompleta)
        {
            t += Time.deltaTime;
            SetCarga(Mathf.Clamp01(t / duracionCargaCompleta));
            yield return null;
        }
        SetCarga(1f);
        Disparar(); // carga completa dispara automáticamente
    }

    private void Disparar()
    {
        Estado = EstadoArma.Disparando;

        if (particulasDeCarga != null) particulasDeCarga.Stop();
        if (particulasDeDisparo != null) particulasDeDisparo.Play();

        if (prefabProyectil != null && cañon != null)
        {
            EnergyProjectile proyectil = Instantiate(prefabProyectil, cañon.position, cañon.rotation);
            proyectil.Lanzar(cañon.forward * velocidadProyectil, cargaActual);
        }

        OnDisparo?.Invoke();
        SetCarga(0f);
        Estado = EstadoArma.Idle;
    }

    private void SetCarga(float valor)
    {
        cargaActual = valor;
        materialInstancia.SetFloat(ChargeAmountID, valor);
        OnCargaCambiada?.Invoke(valor);
    }
}
