using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectSpawner : MonoBehaviour
{
    [Header("Assets")]
    public Mesh[] meshes;
    public Material[] mats;

    [Header("Spawn Settings")]
    public int objectCount = 20;
    public Vector2 spawnRangeX = new Vector2(-8f, 8f);
    public Vector2 spawnRangeY = new Vector2(-4f, 4f);
    public Vector2 scaleRange = new Vector2(-0.5f, 1.8f);
    public float rotSpeed = 45f;

    private int specialMeshIndex = 0;
    private int specialMatIndex = 0;

    public (Mesh mesh, Material mat) GetTargetInfo()
    => (meshes[specialMeshIndex], mats[specialMatIndex]);

    public int GetObjectCount() => sceneObjects.Count;
    public Vector3 GetObjectPosition(int index) => sceneObjects[index].position;
    public Vector3 GetObjectScale(int index) => sceneObjects[index].scale;
    public bool IsTarget(int index) => sceneObjects[index].isTarget;
    public Mesh GetObjectMesh(int index) => sceneObjects[index].mesh;

    private struct SceneObject
    {
        public Mesh mesh;
        public Material mat;
        public Vector3 position;
        public Vector3 scale;
        public Vector3 rotationAxis;
        public float rotationSpeed;
        public float currentAngle;
        public bool isTarget;
    }

    private List<SceneObject> sceneObjects = new List<SceneObject>();

    void Start()
    {
        GenerateObjects();
        Debug.Log($"Total objetos generados: {sceneObjects.Count}");
    }

    void Update()
    {
        for (int i = 0; i < sceneObjects.Count; i++)
        {
            SceneObject obj = sceneObjects[i];

            obj.currentAngle += obj.rotationSpeed * Time.deltaTime;
            sceneObjects[i] = obj;

            Quaternion rotation = Quaternion.AngleAxis(obj.currentAngle, obj.rotationAxis);
            Matrix4x4 matrix = Matrix4x4.TRS(obj.position, rotation, obj.scale);

            Graphics.DrawMesh(obj.mesh, matrix, obj.mat, 0);
        }
    }

    public void GenerateObjects()
    {
        sceneObjects.Clear();

        specialMeshIndex = Random.Range(0, meshes.Length);
        specialMatIndex= Random.Range(0, mats.Length);

        int targetIndex = Random.Range(0, objectCount);

        for (int i = 0; i < objectCount; i++)
        {
            bool isTarget = (i == targetIndex);

            Mesh mesh;
            Material mat;

            if (isTarget)
            {
                mesh = meshes[specialMeshIndex];
                mat = mats[specialMatIndex];
            }
            else
            {
                int mIdx, matIdx;

                do
                {
                    mIdx = Random.Range(0, meshes.Length);
                    matIdx = Random.Range(0, mats.Length);
                } while (mIdx == specialMeshIndex && matIdx == specialMatIndex);

                mesh = meshes[mIdx];
                mat = mats[matIdx];
            }

            SceneObject obj = new SceneObject
            {
                mesh = mesh,
                mat = mat,
                position = new Vector3(Random.Range(spawnRangeX.x, spawnRangeX.y), Random.Range(spawnRangeY.x, spawnRangeY.y), 0f),
                scale = Vector3.one * Random.Range(scaleRange.x, scaleRange.y),
                rotationAxis = Random.onUnitSphere,
                rotationSpeed = Random.Range(-rotSpeed, rotSpeed),
                currentAngle = Random.Range(0f, 360),
                isTarget = isTarget
            };

            sceneObjects.Add(obj);

            int targetCount = sceneObjects.FindAll(o => o.isTarget).Count;
        }
        Debug.Log($"Objetos generados: {sceneObjects.Count} | Targets: {targetIndex} | Target Data: {specialMeshIndex},{specialMatIndex}");
    }

    public void Repopulate()
    {
        GenerateObjects();
    }
}
