using System.Collections;
using UnityEngine;

// Escudo de energía del NPC defensor (Escena 2 - Sci-Fi).
// Versión simplificada de la secuencia: al recibir el impacto del proyectil,
// el escudo se desvanece (anima _Fade de 1 a 0 en el material SH_Shield) y desaparece.
[RequireComponent(typeof(Renderer))]
public class ShieldEnergy : MonoBehaviour
{
    [SerializeField] private float duracionDesvanecido = 0.5f;
    [SerializeField] private Collider colliderDelEscudo;

    // Nombre de la propiedad expuesta en el Blackboard de SH_Shield: 1 = visible, 0 = invisible
    private static readonly int FadeID = Shader.PropertyToID("_Fade");

    private Material materialInstancia;
    private bool yaImpactado;

    private void Awake()
    {
        materialInstancia = GetComponent<Renderer>().material;
        materialInstancia.SetFloat(FadeID, 1f);
    }

    // La llama EnergyProjectile cuando detecta que le pegó al escudo.
    public void RecibirImpacto()
    {
        if (yaImpactado) return;
        yaImpactado = true;

        if (colliderDelEscudo != null) colliderDelEscudo.enabled = false;
        StartCoroutine(Desvanecer());
    }

    private IEnumerator Desvanecer()
    {
        float t = 0f;
        while (t < duracionDesvanecido)
        {
            t += Time.deltaTime;
            materialInstancia.SetFloat(FadeID, Mathf.Lerp(1f, 0f, t / duracionDesvanecido));
            yield return null;
        }
        materialInstancia.SetFloat(FadeID, 0f);
        gameObject.SetActive(false);
    }
}