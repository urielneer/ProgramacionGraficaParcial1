using UnityEngine;
using System;

namespace TVControlRoom.Managers
{
    public class InputManager : MonoBehaviour
    {
        public static InputManager Instance { get; private set; }

        public event Action OnChannelUp;
        public event Action OnChannelDown;

        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(gameObject);
                return;
            }
            Instance = this;
        }

        private void Update()
        {
            if (Input.GetKeyDown(KeyCode.E))
            {
                OnChannelUp?.Invoke();
            }
            if (Input.GetKeyDown(KeyCode.Q))
            {
                OnChannelDown?.Invoke();
            }
        }
    }
}