using UnityEngine;
using System.Collections.Generic;

namespace TVControlRoom.Data
{
    [CreateAssetMenu(fileName = "NewChannelData", menuName = "TV Control Room/Channel Data")]
    public class ChannelData : ScriptableObject
    {
        [Header("Identification")]
        [SerializeField] private string channelName;
        [TextArea(2, 5)][SerializeField] private string description;

        [Header("Environment Settings")]
        [Tooltip("Audio ambiente por defecto de la región (sin desastre).")]
        [SerializeField] private AudioClip defaultAmbientAudio;

        [Header("Available Catastrophes")]
        [SerializeField] private List<DisasterData> possibleDisasters;

        [Header("UI & Screen Style")]
        [Tooltip("Efecto de pantalla específico por defecto si este canal requiere un look único.")]
        [SerializeField] private Material customMonitorMaterial;

        public string ChannelName => channelName;
        public string Description => description;
        public AudioClip DefaultAmbientAudio => defaultAmbientAudio;
        public List<DisasterData> PossibleDisasters => possibleDisasters;
        public Material CustomMonitorMaterial => customMonitorMaterial;
    }
}