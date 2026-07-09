using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FloatingBoat : MonoBehaviour
{
    [System.Serializable]
    public struct Wave
    {
        public Vector2 direction; // se normaliza automáticamente
        public float amplitude;
        public float frequency;
        public float speed;
    }

    public Wave[] waves = new Wave[]
    {
        new Wave { direction = new Vector2(1f, 0.3f),   amplitude = 0.4f,  frequency = 0.25f, speed = 1.0f },
        new Wave { direction = new Vector2(0.6f, -1f),  amplitude = 0.25f, frequency = 0.4f,  speed = 1.3f },
        new Wave { direction = new Vector2(-0.4f, 0.8f),amplitude = 0.15f, frequency = 0.6f,  speed = 0.8f },
    };

    [Header("Comportamiento del barco")]
    public float heightOffset = 0.5f;      // para que no se hunda por completo
    public float rotationSmooth = 2f;      // suavizado de la inclinación
    public float sampleDistance = 1.5f;    // distancia para estimar la normal (inclinación)

    [Header("Sincronización automática con el material del agua")]
    public Renderer waterRenderer;         // el Renderer del plano/mesh de agua
    public bool liveUpdateInEditor = true; // si está activo, relee el material todo el tiempo (útil para ajustar en Play Mode)

    Rigidbody rb;
    Material waterMaterial;

    void Awake()
    {
        rb = GetComponent<Rigidbody>();

        if (waterRenderer != null)
        {
            waterMaterial = waterRenderer.sharedMaterial;
            RefreshWavesFromMaterial();
        }
    }

    void FixedUpdate()
    {
        if (liveUpdateInEditor && waterMaterial != null)
            RefreshWavesFromMaterial();

        Vector3 pos = transform.position;

        // Altura del agua en el centro del barco
        float centerHeight = GetWaveHeight(pos.x, pos.z);

        // Alturas cercanas para estimar la inclinación (normal aproximada de la superficie)
        float heightRight = GetWaveHeight(pos.x + sampleDistance, pos.z);
        float heightForward = GetWaveHeight(pos.x, pos.z + sampleDistance);

        Vector3 tangentX = new Vector3(sampleDistance, heightRight - centerHeight, 0f).normalized;
        Vector3 tangentZ = new Vector3(0f, heightForward - centerHeight, sampleDistance).normalized;
        Vector3 normal = Vector3.Cross(tangentZ, tangentX).normalized;

        // Posición objetivo (altura del agua + offset)
        Vector3 targetPos = pos;
        targetPos.y = centerHeight + heightOffset;

        // Rotación objetivo alineada con la normal de la ola
        Quaternion targetRot = Quaternion.FromToRotation(transform.up, normal) * transform.rotation;

        if (rb != null)
        {
            rb.MovePosition(targetPos);
            rb.MoveRotation(Quaternion.Slerp(transform.rotation, targetRot, Time.fixedDeltaTime * rotationSmooth));
        }
        else
        {
            transform.position = targetPos;
            transform.rotation = Quaternion.Slerp(transform.rotation, targetRot, Time.fixedDeltaTime * rotationSmooth);
        }
    }

    // Lee _Wave0Dir/_Wave0Amp/_Wave0Freq/_Wave0Speed, _Wave1Dir..., etc. desde el material.
    // Los nombres deben coincidir con los "Reference name" que pusiste en los nodos Property de ASE.
    void RefreshWavesFromMaterial()
    {
        for (int i = 0; i < waves.Length; i++)
        {
            string prefix = "_Wave" + i;

            if (waterMaterial.HasProperty(prefix + "Dir"))
            {
                Vector4 d = waterMaterial.GetVector(prefix + "Dir");
                waves[i].direction = new Vector2(d.x, d.y);
            }
            if (waterMaterial.HasProperty(prefix + "Amp"))
                waves[i].amplitude = waterMaterial.GetFloat(prefix + "Amp");

            if (waterMaterial.HasProperty(prefix + "Freq"))
                waves[i].frequency = waterMaterial.GetFloat(prefix + "Freq");

            if (waterMaterial.HasProperty(prefix + "Speed"))
                waves[i].speed = waterMaterial.GetFloat(prefix + "Speed");
        }
    }

    // Misma fórmula que en el grafo de Amplify Shader Editor
    float GetWaveHeight(float x, float z)
    {
        float height = 0f;
        foreach (var w in waves)
        {
            Vector2 dir = w.direction.normalized;
            float phase = (dir.x * x + dir.y * z) * w.frequency + Time.time * w.speed;
            height += Mathf.Sin(phase) * w.amplitude;
        }
        return height;
    }
}
