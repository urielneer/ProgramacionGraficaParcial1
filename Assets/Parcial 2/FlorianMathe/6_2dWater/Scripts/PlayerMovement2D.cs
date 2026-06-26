using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
public class PlayerMovement2D : MonoBehaviour
{
    public float moveSpeed = 6f;
    public float jumpForce = 12f;

    Rigidbody2D rb;
    float moveX;
    bool grounded;

    void Awake(){ rb = GetComponent<Rigidbody2D>(); }

    void Update(){
        moveX = 0f;
        if (Input.GetKey(KeyCode.A)) moveX = -1f;
        if (Input.GetKey(KeyCode.D)) moveX =  1f;

        if (Input.GetKeyDown(KeyCode.Space) && grounded){
            rb.velocity = new Vector2(rb.velocity.x, jumpForce);
            grounded = false;
        }
    }

    void FixedUpdate(){
        rb.velocity = new Vector2(moveX * moveSpeed, rb.velocity.y); // X controlado, Y libre
        grounded = false; // se re-activa en OnCollisionStay2D si hay piso debajo
    }

    // Detecta piso por colisión: si algún contacto apunta hacia arriba, estás parado en algo.
    void OnCollisionStay2D(Collision2D col){
        foreach (var contact in col.contacts){
            if (contact.normal.y > 0.5f){ grounded = true; return; }
        }
    }
}
