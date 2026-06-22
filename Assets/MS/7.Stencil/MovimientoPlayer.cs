using UnityEngine;

public class MovimientoPlayer : MonoBehaviour
{
    public float velocidad = 8f;

    void Update()
    {
        float moverHorizontal = Input.GetAxis("Horizontal");
        float moverVertical = Input.GetAxis("Vertical");

        Vector3 direccion = new Vector3(moverHorizontal, 0f, moverVertical);

        transform.Translate(direccion * velocidad * Time.deltaTime, Space.World);

        if (direccion != Vector3.zero)
        {
            transform.forward = direccion;
        }
    }
}