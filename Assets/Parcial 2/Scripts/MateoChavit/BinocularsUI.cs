using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BinocularsUI : MonoBehaviour
{
    [Header("References")]
    [SerializeField] private RawImage binoculars;
    [SerializeField] private Shader shader;

    [Header("Binoculars")]
    [SerializeField] private float separation;
    [SerializeField] private float radius;
    [SerializeField] private float softEdge;

    [Header("Movement")]
    [SerializeField] private float mouseSense;
    [SerializeField] private bool clampToScreen = true;

    private Material material;

    private static readonly int PropCenter1 = Shader.PropertyToID("_Center1");
    private static readonly int PropCenter2 = Shader.PropertyToID("_Center2");
    private static readonly int PropMin = Shader.PropertyToID("_Min");
    private static readonly int PropMax = Shader.PropertyToID("_Max");

    void Awake()
    {
        material = new Material(shader);
        binoculars.material = material;
    }


    void Update()
    {
        Vector2 mouseNorm = new Vector2 (Input.mousePosition.x / Screen.width, Input.mousePosition.y / Screen.height);

        if (clampToScreen)
        {
            float margin = radius + softEdge;
            mouseNorm.x = Mathf.Clamp(mouseNorm.x, margin, 1f - margin);
            mouseNorm.y = Mathf.Clamp(mouseNorm.y, margin, 1f - margin);
        }

        Vector2 center1 = mouseNorm + new Vector2(-separation * 0.5f, 0f);
        Vector2 center2 = mouseNorm + new Vector2(separation * 0.5f, 0f);

        material.SetVector(PropCenter1, center1);
        material.SetVector(PropCenter2, center2);
        material.SetFloat(PropMin, radius);
        material.SetFloat(PropMax, radius + softEdge);
    }
}
