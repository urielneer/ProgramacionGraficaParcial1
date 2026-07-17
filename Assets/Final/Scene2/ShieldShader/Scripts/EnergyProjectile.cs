using UnityEngine;

// Proyectil de energía disparado por WeaponEnergy. Viaja en línea recta y
// dispara un VFX de impacto al chocar. Su brillo/tamaño reflejan cuánta carga
// tenía el arma al momento del disparo (un tiro a medio cargar se ve más débil).
[RequireComponent(typeof(Renderer))]
public class EnergyProjectile : MonoBehaviour
{
    [SerializeField] private float vidaMaxima = 5f;
    [SerializeField] private GameObject vfxImpacto;
    [SerializeField] private LayerMask capasDeImpacto;

    private static readonly int PowerID = Shader.PropertyToID("_Power");

    private Vector3 velocidad;
    private Material materialInstancia;

    public void Lanzar(Vector3 velocidadInicial, float cargaAlDisparar)
    {
        velocidad = velocidadInicial;

        materialInstancia = GetComponent<Renderer>().material;
        materialInstancia.SetFloat(PowerID, cargaAlDisparar);

        // Un disparo más cargado se ve (y pega) más grande
        transform.localScale *= Mathf.Lerp(0.6f, 1.3f, cargaAlDisparar);

        Destroy(gameObject, vidaMaxima);
    }

    private void Update()
    {
        transform.position += velocidad * Time.deltaTime;
    }

    private void OnTriggerEnter(Collider other)
    {
        if ((capasDeImpacto.value & (1 << other.gameObject.layer)) == 0) return;

        if (vfxImpacto != null)
        {
            Instantiate(vfxImpacto, transform.position, Quaternion.identity);
        }

        Destroy(gameObject);
    }
}
