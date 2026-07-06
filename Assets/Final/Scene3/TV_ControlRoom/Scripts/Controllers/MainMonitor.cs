using UnityEngine;
using TVControlRoom.Managers;

namespace TVControlRoom.Controllers
{
    [RequireComponent(typeof(ScreenEffectController))]
    public class MainMonitor : MonoBehaviour
    {
        private ScreenEffectController effectController;
        private int currentChannelIndex = 0;

        private void Awake()
        {
            effectController = GetComponent<ScreenEffectController>();
        }

        private void Start()
        {
            if (InputManager.Instance != null)
            {
                InputManager.Instance.OnChannelUp += NextChannel;
                InputManager.Instance.OnChannelDown += PreviousChannel;
            }

            RefreshMonitor();
        }

        private void NextChannel()
        {
            int total = ChannelManager.Instance.TotalChannels;
            if (total == 0) return;

            currentChannelIndex = (currentChannelIndex + 1) % total;
            RefreshMonitor();
        }

        private void PreviousChannel()
        {
            int total = ChannelManager.Instance.TotalChannels;
            if (total == 0) return;

            currentChannelIndex--;
            if (currentChannelIndex < 0) currentChannelIndex = total - 1;

            RefreshMonitor();
        }

        private void RefreshMonitor()
        {
            var channel = ChannelManager.Instance.GetChannelAt(currentChannelIndex);
            if (channel != null)
            {
                effectController.TransitionToChannel(channel.RenderTexture);
            }
        }

        private void OnDestroy()
        {
            // Desuscripción obligatoria para evitar Memory Leaks
            if (InputManager.Instance != null)
            {
                InputManager.Instance.OnChannelUp -= NextChannel;
                InputManager.Instance.OnChannelDown -= PreviousChannel;
            }
        }
    }
}