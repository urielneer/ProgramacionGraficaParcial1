using UnityEngine;

public class RotatiionController : MonoBehaviour
{
    [SerializeField] private float rotationSpeed = 100f;

    void Update()
    {
        // Get input from A/D or Left/Right arrow keys (-1 to 1)
        float input = Input.GetAxis("Horizontal");

        // Calculate rotation amount per frame
        // Negative input rotates right (D), positive rotates left (A)
        float rotationAmount = input * rotationSpeed * Time.deltaTime;

        // Apply rotation around the Z axis
        transform.Rotate(0, rotationAmount, 0);
    }
}