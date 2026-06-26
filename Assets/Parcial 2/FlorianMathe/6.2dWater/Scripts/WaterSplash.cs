using UnityEngine;

[RequireComponent(typeof(SpriteRenderer))]
public class WaterSplash : MonoBehaviour
{
    public Material waterMat;
    public float target = 2.5f;      // pico del splash al entrar / salir
    public float attack = 18f;       // velocidad de subida hasta el pico (rapida pero progresiva)
    public float idleInside = 0.1f;  // minimo mientras sigue dentro del agua
    public float decay = 6f;         // que tan rapido cae el pico

    SpriteRenderer sr;   
    float strength;
    float peak;          // objetivo de la subida (se setea al entrar/salir)
    bool rising;         // true = en fase de subida; false = decayendo
    bool inside;
    Transform player;

    void Start()
    {
        sr = GetComponent<SpriteRenderer>();
        waterMat = sr.material;       
    }

    void OnTriggerEnter2D(Collider2D c)
    {
        if (c.CompareTag("Player")) { inside = true; player = c.transform; peak = target; rising = true; } 
    }

    void OnTriggerExit2D(Collider2D c)
    {
        if (c.CompareTag("Player")) { inside = false; peak = target; rising = true; } 
    }

    void Update()
    {
        float floor = inside ? idleInside : 0f;
        if (rising)
        {
            // subida rapida pero interpolada hasta el pico
            strength = Mathf.MoveTowards(strength, peak, attack * Time.deltaTime);
            if (strength >= peak - 0.001f) rising = false;
        }
        else
        {
            // decae suave y se asienta en el minimo
            strength = Mathf.Lerp(strength, floor, 1f - Mathf.Exp(-decay * Time.deltaTime));
        }
        waterMat.SetFloat("_SplashStrength", strength);

        if (inside && player)
        {
            float left  = sr.bounds.min.x;  
            float right = sr.bounds.max.x;   
            float x = Mathf.InverseLerp(left, right, player.position.x); // 0-1
            waterMat.SetFloat("_SplashPosX", x);
        }
    }
}
