using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RainManager : MonoBehaviour
{
    [Header("Assets")]
    public Mesh rainMesh;           
    public Material rainMaterial;     

    [Header("Camara (para billboard)")]
    public Camera targetCamera;        

    [Header("Area de spawn")]
    public Transform followTarget;
    public Vector3 areaCenter = Vector3.zero;
    public Vector3 areaSize = new Vector3(20f, 1f, 20f);
    public float groundY = 0f;

    [Header("Cantidad y movimiento")]
    public int dropCount = 500;
    public Vector2 fallSpeedRange = new Vector2(8f, 14f);
    public Vector2 lengthRange = new Vector2(0.4f, 1.2f); 
    public float width = 0.03f;
    public Vector2 wind = new Vector2(1.5f, 0f);         

    private struct RainDrop
    {
        public Vector3 position;
        public float speed;
        public float length;
        public float randomSeed;
    }

    private List<RainDrop> drops = new List<RainDrop>();
    private MaterialPropertyBlock mpb;
    private static readonly int RandomSeedID = Shader.PropertyToID("_RandomSeed");

    void Start()
    {
        if (targetCamera == null) targetCamera = Camera.main;
        mpb = new MaterialPropertyBlock();
        GenerateDrops();
    }

    void GenerateDrops()
    {
        drops.Clear();
        for (int i = 0; i < dropCount; i++)
        {
            drops.Add(new RainDrop
            {
                position = RandomPositionInArea(Random.Range(0f, areaSize.y)),
                speed = Random.Range(fallSpeedRange.x, fallSpeedRange.y),
                length = Random.Range(lengthRange.x, lengthRange.y),
                randomSeed = Random.value
            });
        }
    }

    Vector3 RandomPositionInArea(float yOffset)
    {
        Vector3 center = followTarget != null ? followTarget.position + areaCenter : areaCenter;
        float x = center.x + Random.Range(-areaSize.x * 0.5f, areaSize.x * 0.5f);
        float z = center.z + Random.Range(-areaSize.z * 0.5f, areaSize.z * 0.5f);
        float y = center.y + areaSize.y - yOffset;
        return new Vector3(x, y, z);
    }

    void Update()
    {
        if (rainMesh == null || rainMaterial == null || targetCamera == null) return;

        Vector3 velocity = new Vector3(wind.x, 0f, wind.y);
        float dt = Time.deltaTime;

        for (int i = 0; i < drops.Count; i++)
        {
            RainDrop d = drops[i];

            Vector3 fallVelocity = new Vector3(wind.x, -d.speed, wind.y);
            d.position += fallVelocity * dt;

            if (d.position.y <= groundY)
            {
                d.position = RandomPositionInArea(0f);
            }

            drops[i] = d;

            Vector3 dropDir = fallVelocity.normalized;
            Vector3 toCamera = (targetCamera.transform.position - d.position).normalized;
            Quaternion rotation = Quaternion.LookRotation(toCamera, -dropDir);

            Vector3 scale = new Vector3(width, d.length, 1f);
            Matrix4x4 matrix = Matrix4x4.TRS(d.position, rotation, scale);

            mpb.SetFloat(RandomSeedID, d.randomSeed);
            Graphics.DrawMesh(rainMesh, matrix, rainMaterial, 0, targetCamera, 0, mpb);
        }
    }

    void OnDrawGizmosSelected()
    {
        Vector3 center = followTarget != null ? followTarget.position + areaCenter : areaCenter;
        Gizmos.color = new Color(0.3f, 0.6f, 1f, 0.5f);
        Gizmos.DrawWireCube(center + Vector3.up * areaSize.y * 0.5f, areaSize);
    }
}
