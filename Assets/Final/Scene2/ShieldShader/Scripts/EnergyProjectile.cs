using System.Collections;
using UnityEngine;

// Láser de energía disparado por WeaponEnergy. NO viaja: en el instante del
// disparo se estira y orienta (usando tu mesh, ej. la cápsula con el aro en
// espiral) para ir de "inicio" a "fin", y después se desvanece.
[RequireComponent(typeof(Renderer))]
public class EnergyProjectile : MonoBehaviour
{
    [SerializeField] private float duracionDesvanecido = 0.15f;

    // Si el eje "largo" de tu mesh es el Z (forward), dejalo en true.
    // Si en vez de estirarse para el lado correcto se estira "de costado",
    // probá destildar esto (para meshes cuyo largo está en el eje Y).
    [SerializeField] private bool largoEnEjeZ = true;

    // Si el pivote de tu mesh está en un extremo (no en el centro), tildá esto
    // para que se posicione desde "inicio" en vez de desde el punto medio.
    [SerializeField] private bool pivoteEnUnExtremo = false;

    // Nombres de las propiedades expuestas en el Blackboard de SH_EnergyProjectile
    private static readonly int PowerID = Shader.PropertyToID("_Power");
    private static readonly int FadeID = Shader.PropertyToID("_Fade"); // 1 = visible, 0 = invisible

    private Material materialInstancia;

    // Lo llama WeaponEnergy en el instante del disparo, ya con el punto de impacto calculado.
    public void Disparar(Vector3 inicio, Vector3 fin, float cargaAlDisparar)
    {
        Vector3 direccion = fin - inicio;
        float distancia = direccion.magnitude;

        transform.rotation = Quaternion.LookRotation(direccion.normalized);
        transform.position = pivoteEnUnExtremo ? inicio : inicio + direccion * 0.5f;

        Vector3 escala = transform.localScale;
        if (largoEnEjeZ) escala.z = distancia;
        else escala.y = distancia;
        transform.localScale = escala;

        materialInstancia = GetComponent<Renderer>().material;
        materialInstancia.SetFloat(PowerID, cargaAlDisparar); // brillo fijo según qué tan cargado salió
        materialInstancia.SetFloat(FadeID, 1f);

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
        Destroy(gameObject);
    }
}