using UnityEngine;
using System.Collections.Generic;
using TVControlRoom.Core;

namespace TVControlRoom.Managers
{
    public class ChannelManager : MonoBehaviour
    {
        public static ChannelManager Instance { get; private set; }

        [Header("Resolution Settings")]
        [SerializeField] private int rtWidth = 512;
        [SerializeField] private int rtHeight = 512;

        [Header("Scene Channels")]
        [SerializeField] private List<ChannelInstance> activeChannels = new List<ChannelInstance>();

        public int TotalChannels => activeChannels.Count;

        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(gameObject);
                return;
            }
            Instance = this;

            // Inicializar las RenderTextures de todas las regiones configuradas
            foreach (var channel in activeChannels)
            {
                channel.InitializeChannel(rtWidth, rtHeight);
            }
        }

        public ChannelInstance GetChannelAt(int index)
        {
            if (index >= 0 && index < activeChannels.Count)
                return activeChannels[index];
            return null;
        }

        public ChannelInstance GetRandomChannel(ChannelInstance excludeChannel = null)
        {
            if (activeChannels.Count <= 1) return activeChannels[0];

            ChannelInstance selected;
            do
            {
                int randomIndex = Random.Range(0, activeChannels.Count);
                selected = activeChannels[randomIndex];
            } while (selected == excludeChannel); // Evita repetir el mismo canal consecutivamente

            return selected;
        }
    }
}