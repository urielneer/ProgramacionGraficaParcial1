using UnityEngine;

public class MovimientoPlayer : MonoBehaviour
{
    public float velocidad = 8f;

    private Animator animator; 

    void Start()
    {
        animator = GetComponentInChildren<Animator>();

    }

    void Update()
    {
        float moverHorizontal = 0f;
        float moverVertical = 0f;

        if (Input.GetKey(KeyCode.W)) moverVertical = 1f;
        if (Input.GetKey(KeyCode.S)) moverVertical = -1f;
        if (Input.GetKey(KeyCode.A)) moverHorizontal = -1f;
        if (Input.GetKey(KeyCode.D)) moverHorizontal = 1f;

        Vector3 direccion = new Vector3(moverHorizontal, 0f, moverVertical).normalized;

        transform.Translate(direccion * velocidad * Time.deltaTime, Space.World);

        if (direccion != Vector3.zero)
        {
            transform.forward = direccion;

            if (animator != null)
            {
                animator.SetBool("IsSprinting", true);
            }
        }
        else
        {
            if (animator != null)
            {
                animator.SetBool("IsSprinting", false);
            }
        }
    }
}