using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TargetDetector : MonoBehaviour
{
    [Header("References")]
    [SerializeField] private ObjectSpawner spawner;
    [SerializeField] private Camera mainCam;

    [Header("Detection")]
    [SerializeField] private float clickRadius = 0.3f;

    [Header("Capture")]
    [SerializeField] private RenderTexture captureRT;
    [SerializeField] private RawImage dispImage;
    [SerializeField] private GameObject display;
    [SerializeField] private float captureSize = 300f;

    private bool pendingCapture = false;
    void Start()
    {
        display.SetActive(false);
        if(captureRT == null)
        {
            captureRT = new RenderTexture(Screen.width, Screen.height, 0);
        }
    }

    void Update()
    {
        if(Input.GetMouseButton(0))
        {
            CheckClick();

            if(pendingCapture)
            {
                pendingCapture = false;
                TakeCapture();
            }
        }
    }

    private void CheckClick()
    {
        if (pendingCapture) return;

        Vector3 mouseWorld = mainCam.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, Mathf.Abs(mainCam.transform.position.z)));

        for(int i = 0; i < spawner.GetObjectCount(); i++) 
        {
            float dist = Vector2.Distance(mouseWorld, spawner.GetObjectPosition(i));
            float radius = clickRadius * spawner.GetObjectScale(i).x;

            if(dist < radius)
            {
                if (spawner.IsTarget(i))
                {
                    Debug.Log($"TARGET encontrado en #{i}");
                    pendingCapture = true;
                }
                else
                {
                    Debug.Log("Wrong target!");
                }
                break;
            }
        }
    }

    private void TakeCapture()
    {
        StartCoroutine(CaptureRoutine());
    }

    private IEnumerator CaptureRoutine()
    {
        display.SetActive(false);

        yield return new WaitForEndOfFrame();

        Vector2 mousePos = Input.mousePosition;

        float halfSize = captureSize / 2f;
        float x = Mathf.Clamp(mousePos.x - halfSize, 0, Screen.width - captureSize);
        float y = Mathf.Clamp(mousePos.y - halfSize, 0, Screen.height - captureSize);

        Rect captureRect = new Rect(x, y, captureSize, captureSize);

        Texture2D screenTex = new Texture2D((int)captureSize, (int)captureSize, TextureFormat.RGB24, false);
        screenTex.ReadPixels(captureRect, 0, 0);
        screenTex.Apply();

        if (captureRT.width != (int)captureSize)
        {
            captureRT.Release();
            captureRT = new RenderTexture((int)captureSize, (int)captureSize, 0);
        }

        Graphics.Blit(screenTex, captureRT);
        Destroy(screenTex);

        dispImage.texture = captureRT;
        display.SetActive(true);

        spawner.Repopulate();

        Debug.Log("Target Found!!!");
    }
}
