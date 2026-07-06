using UnityEngine;
using System.Collections;

namespace TVControlRoom.Controllers
{
    [RequireComponent(typeof(Renderer))]
    public class ScreenEffectController : MonoBehaviour
    {
        [Header("Material Settings")]
        [Tooltip("Índice del material de la pantalla en el Mesh Renderer (0 para el primero, 1 para el segundo, etc.)")]
        [SerializeField] private int screenMaterialIndex = 1;

        private Material targetMaterial;
        private Coroutine transitionCoroutine;

        private static readonly int StaticAmountID = Shader.PropertyToID("_StaticAmount");
        private static readonly int MainTexID = Shader.PropertyToID("_MainTex");

        private void Awake()
        {
            Renderer meshRenderer = GetComponent<Renderer>();

            if (meshRenderer != null && meshRenderer.materials.Length > screenMaterialIndex)
            {
                //asignamos el material de ese slot específico
                targetMaterial = meshRenderer.materials[screenMaterialIndex];
            }
            else
            {
                Debug.LogError($"[ScreenEffectController] No se encontró un material en el índice {screenMaterialIndex} en {gameObject.name}. ¿Está bien configurado el Mesh Renderer?");
            }
        }

        public void TransitionToChannel(Texture newRenderTexture, float staticDuration = 0.3f)
        {
            if (targetMaterial == null) return;

            if (transitionCoroutine != null)
                StopCoroutine(transitionCoroutine);

            transitionCoroutine = StartCoroutine(ChannelSwitchRoutine(newRenderTexture, staticDuration));
        }

        private IEnumerator ChannelSwitchRoutine(Texture newTex, float duration)
        {
            float halfDuration = duration * 0.5f;
            float time = 0f;

            //Subir la estática
            while (time < halfDuration)
            {
                time += Time.deltaTime;
                float t = Mathf.Clamp01(time / halfDuration);
                targetMaterial.SetFloat(StaticAmountID, t);
                yield return null;
            }
            targetMaterial.SetFloat(StaticAmountID, 1f);

            //Cambiar RenderTexture
            targetMaterial.SetTexture(MainTexID, newTex);

            yield return new WaitForSeconds(0.05f);

            //Bajar la estática
            time = 0f;
            while (time < halfDuration)
            {
                time += Time.deltaTime;
                float t = Mathf.Clamp01(time / halfDuration);
                targetMaterial.SetFloat(StaticAmountID, 1f - t);
                yield return null;
            }
            targetMaterial.SetFloat(StaticAmountID, 0f);
            transitionCoroutine = null;
        }

        private void OnDestroy()
        {
            if (targetMaterial != null)
                Destroy(targetMaterial);
        }
    }
}