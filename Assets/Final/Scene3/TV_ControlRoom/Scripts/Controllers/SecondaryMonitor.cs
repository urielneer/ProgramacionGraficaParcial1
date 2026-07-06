using UnityEngine;
using System.Collections;
using TVControlRoom.Managers;
using TVControlRoom.Core;

namespace TVControlRoom.Controllers
{
    [RequireComponent(typeof(ScreenEffectController))]
    public class SecondaryMonitor : MonoBehaviour
    {
        [Header("Timer Configuration")]
        [SerializeField] private float minChangeInterval = 5f;
        [SerializeField] private float maxChangeInterval = 12f;

        private ScreenEffectController effectController;
        private ChannelInstance currentChannel;

        private void Awake()
        {
            effectController = GetComponent<ScreenEffectController>();
        }

        private void Start()
        {
            StartCoroutine(AutomaticChannelRoutine());
        }

        private IEnumerator AutomaticChannelRoutine()
        {
            yield return new WaitForSeconds(Random.Range(0.5f, 3f));

            while (true)
            {
                if (ChannelManager.Instance != null && ChannelManager.Instance.TotalChannels > 0)
                {
                    currentChannel = ChannelManager.Instance.GetRandomChannel(currentChannel);
                    if (currentChannel != null)
                    {
                        effectController.TransitionToChannel(currentChannel.RenderTexture);
                    }
                }

                float waitTime = Random.Range(minChangeInterval, maxChangeInterval);
                yield return new WaitForSeconds(waitTime);
            }
        }
    }
}