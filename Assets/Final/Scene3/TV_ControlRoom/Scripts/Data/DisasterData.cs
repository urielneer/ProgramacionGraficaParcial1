using UnityEngine;

namespace TVControlRoom.Data
{
    [CreateAssetMenu(fileName = "NewDisasterData", menuName = "TV Control Room/Disaster Data")]
    public class DisasterData : ScriptableObject
    {
        [Header("General Info")]
        [SerializeField] private string disasterName;
        [SerializeField] private GameObject disasterPrefab;
        [SerializeField] private float duration = 15f;

        [Header("Visuals & Shaders")]
        [Tooltip("El material especifico del clima que usara el WeatherManager en la zona.")]
        [SerializeField] private Material weatherMaterial;
        [SerializeField] private float targetIntensity = 1f;

        [Header("Audio")]
        [SerializeField] private AudioClip disasterAmbientAudio;

        [Header("Balancing")]
        [Range(0f, 1f)][SerializeField] private float spawnProbability = 0.5f;

        public string DisasterName => disasterName;
        public GameObject DisasterPrefab => disasterPrefab;
        public float Duration => duration;
        public Material WeatherMaterial => weatherMaterial;
        public float TargetIntensity => targetIntensity;
        public AudioClip DisasterAmbientAudio => disasterAmbientAudio;
        public float SpawnProbability => spawnProbability;
    }
}