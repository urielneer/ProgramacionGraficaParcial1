using UnityEngine;

public class SeguimientoCamara : MonoBehaviour
{
    public Transform objetivo;
    public Vector3 offset = new Vector3(0f, 8f, -8f);
    public float suavizado = 5f;

    [Header("Configuracion de Rotacion (Flechas)")]
    public float velocidadRotacion = 100f;

    public float limiteMinimoX = 10f;
    public float limiteMaximoX = 80f;

    private float rotacionY = 0f; 
    private float rotacionX = 0f; 
    private float distanciaBase;

    void Start()
    {
        distanciaBase = offset.magnitude;

        Vector3 rotacionInicial = transform.eulerAngles;
        rotacionY = rotacionInicial.y;
        rotacionX = rotacionInicial.x;
    }

    void LateUpdate()
    {
        if (objetivo == null) return;

        if (Input.GetKey(KeyCode.LeftArrow))
        {
            rotacionY -= velocidadRotacion * Time.deltaTime;
        }
        if (Input.GetKey(KeyCode.RightArrow))
        {
            rotacionY += velocidadRotacion * Time.deltaTime;
        }

        if (Input.GetKey(KeyCode.UpArrow))
        {
            rotacionX += velocidadRotacion * Time.deltaTime; 
        }
        if (Input.GetKey(KeyCode.DownArrow))
        {
            rotacionX -= velocidadRotacion * Time.deltaTime; 
        }

        rotacionX = Mathf.Clamp(rotacionX, limiteMinimoX, limiteMaximoX);

        Quaternion rotacionActual = Quaternion.Euler(rotacionX, rotacionY, 0f);

        Vector3 posicionLocal = new Vector3(0f, 0f, -distanciaBase);
        Vector3 posicionDeseada = objetivo.position + (rotacionActual * posicionLocal);

        transform.position = Vector3.Lerp(transform.position, posicionDeseada, suavizado * Time.deltaTime);

        transform.LookAt(objetivo.position + Vector3.up);
    }
}