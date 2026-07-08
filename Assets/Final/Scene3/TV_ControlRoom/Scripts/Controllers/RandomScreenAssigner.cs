using UnityEngine;

public class RandomScreenAssigner : MonoBehaviour
{
    [Header("Lista de efectos de pantalla")]
    [SerializeField] private Material[] availableScreenMaterials;

    void Awake()
    {
        MeshRenderer meshRenderer = GetComponent<MeshRenderer>();

        if (meshRenderer != null && availableScreenMaterials.Length > 0 && meshRenderer.materials.Length > 1)
        {
            int randomIndex = Random.Range(0, availableScreenMaterials.Length);
            Material selectedMaterial = availableScreenMaterials[randomIndex];
            Material[] tvMaterials = meshRenderer.materials;
            tvMaterials[1] = selectedMaterial;
            meshRenderer.materials = tvMaterials;
        }
    }
}