using UnityEngine;
using TVControlRoom.Data;

namespace TVControlRoom.Core
{
    public class ChannelInstance : MonoBehaviour
    {
        [SerializeField] private ChannelData channelData;
        [SerializeField] private Camera regionCamera;

        private RenderTexture channelRt;

        public ChannelData Data => channelData;
        public RenderTexture RenderTexture => channelRt;

        public void InitializeChannel(int width, int height)
        {
            // Creamos una RenderTexture dinámica con la resolución deseada para este canal
            channelRt = new RenderTexture(width, height, 16, RenderTextureFormat.ARGB32);
            channelRt.Create();

            if (regionCamera != null)
            {
                regionCamera.targetTexture = channelRt;
            }
            else
            {
                Debug.LogError($"[ChannelInstance] Falta asignar la cámara en la región: {gameObject.name}");
            }
        }

        private void OnDestroy()
        {
            if (channelRt != null)
            {
                channelRt.Release();
                Destroy(channelRt);
            }
        }
    }
}