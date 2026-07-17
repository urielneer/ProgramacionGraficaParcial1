using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SideCameraController : MonoBehaviour
{
    [Header("Camera Limits")]
    [SerializeField] private Transform startPoint;
    [SerializeField] private Transform endPoint;

    [Header("Movement")]
    [SerializeField] private float moveSpeed = 0.6f;
    [SerializeField, Range(0f, 1f)] private float currentPosition = 0f;

    private void Start()
    {
        ApplyCameraTransform();
    }

    private void Update()
    {
        float input = GetHorizontalInput();

        if (Mathf.Abs(input) <= 0f)
            return;

        currentPosition += input * moveSpeed * Time.deltaTime;
        currentPosition = Mathf.Clamp01(currentPosition);

        ApplyCameraTransform();
    }

    private float GetHorizontalInput()
    {
        float input = 0f;

        if (Input.GetKey(KeyCode.A) || Input.GetKey(KeyCode.LeftArrow))
            input -= 1f;

        if (Input.GetKey(KeyCode.D) || Input.GetKey(KeyCode.RightArrow))
            input += 1f;

        return input;
    }

    private void ApplyCameraTransform()
    {
        if (startPoint == null || endPoint == null)
            return;

        transform.position = Vector3.Lerp(
            startPoint.position,
            endPoint.position,
            currentPosition
        );

        transform.rotation = Quaternion.Slerp(
            startPoint.rotation,
            endPoint.rotation,
            currentPosition
        );
    }
}