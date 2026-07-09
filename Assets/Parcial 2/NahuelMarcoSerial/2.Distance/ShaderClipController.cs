using UnityEngine;

public class ShaderClipController : MonoBehaviour
{
    public Transform playerTransform; // Arrastrá al Player acá
    public float heightOffset = 1.0f; // Altura para centrar el círculo
    private Camera cam;

    void Start()
    {
        cam = GetComponent<Camera>();
    }

    void Update()
    {
        if (playerTransform != null)
        {
            // 1. Calculamos la posición del Player con altura corregida
            Vector3 worldPos = playerTransform.position + Vector3.up * heightOffset;

            // 2. Lo pasamos a coordenadas de pantalla (0 a 1)
            Vector3 screenPos = cam.WorldToViewportPoint(worldPos);

            // 3. SE LO MANDAMOS AL SHADER (Usa el mismo nombre que en el Property Name de Amplify)
            Shader.SetGlobalVector("_PlayerScreenPos", new Vector4(screenPos.x, screenPos.y, 0, 0));
        }
    }
}