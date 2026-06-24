using UnityEngine;

public class PatrullaEnemigo : MonoBehaviour
{
    [Header("Ruta de Patrullaje")]
    public Transform[] puntosPatrulla;
    public float velocidad = 1.5f; 
    public float distanciaMinima = 0.3f;

    private int indiceActual = 0;
    private Animator animator;

    void Start()
    {
        animator = GetComponentInChildren<Animator>();
    }

    void Update()
    {
        if (puntosPatrulla == null || puntosPatrulla.Length == 0)
        {
            if (animator != null) animator.SetFloat("Speed", 0f);
            return;
        }

        Vector3 puntoObjetivo = puntosPatrulla[indiceActual].position;
        puntoObjetivo.y = transform.position.y;

        Vector3 direccion = puntoObjetivo - transform.position;

        if (direccion != Vector3.zero)
        {
            transform.forward = Vector3.Lerp(transform.forward, direccion.normalized, 10f * Time.deltaTime);

            if (animator != null) animator.SetFloat("Speed", velocidad);
        }

        transform.position = Vector3.MoveTowards(transform.position, puntoObjetivo, velocidad * Time.deltaTime);

        if (Vector3.Distance(transform.position, puntoObjetivo) < distanciaMinima)
        {
            indiceActual = (indiceActual + 1) % puntosPatrulla.Length;
        }
    }
}