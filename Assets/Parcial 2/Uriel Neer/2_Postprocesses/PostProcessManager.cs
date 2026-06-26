using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class PostProcessManager : MonoBehaviour
{
    [SerializeField] private bool IsFlashBanged = false;
    [SerializeField] private float[] FlashBangCountdowns;
    private bool HasFlashBangStarted = true;
    private int FlashBangIndex = -1;
    private float FlashBangElapsedTime = 0;

    [SerializeField] private bool IsDamaged = false;
    [SerializeField] private float[] DamageCountdowns;
    private bool HasDamageStarted = true;
    private int DamageIndex = -1;
    private float DamageElapsedTime = 0;

    [SerializeField] private bool IsHealing = false;
    [SerializeField] private float[] HealCountdowns;
    private bool HasHealStarted = true;
    private int HealIndex = -1;
    private float HealElapsedTime = 0;

    [SerializeField] private bool IsWakingUp = false;
    [SerializeField] private float[] WakeUpCountdowns;
    private bool HasWakeUpStarted = true;
    private int WakeUpIndex = -1;
    private float WakeUpElapsedTime = 0;

    [SerializeField] private bool IsUsingCamera = false;
    [SerializeField] private float[] UsingCameraCountdowns;
    private bool HasUsingCameraStarted = true;
    private int UsingCameraIndex = -1;
    private float UsingCameraElapsedTime = 0;

    [SerializeField] private bool IsDrunk = false;
    [SerializeField] private float[] DrunkCountdowns;
    private bool HasDrunkStarted = true;
    private int DrunkIndex = -1;
    private float DrunkElapsedTime = 0;

    [SerializeField] private Material material;

    void Awake()
    {
        material.SetColor(Shader.PropertyToID("_FlashBangAction1"),   new Color(0, 0, 0, 0));
        material.SetColor(Shader.PropertyToID("_DamageAction1"),      new Color(0, 0, 0, 0));
        material.SetColor(Shader.PropertyToID("_HealAction1"),        new Color(0, 0, 0, 0));
        material.SetColor(Shader.PropertyToID("_WakeUpAction1"),      new Color(0, 0, 0, 0));
        material.SetColor(Shader.PropertyToID("_UsingCameraAction1"), new Color(0, 0, 0, 0));
        material.SetColor(Shader.PropertyToID("_DrunkAction1"),       new Color(0, 0, 0, 0));

        FlashBangElapsedTime = 0;
        DamageElapsedTime = 0;
        HealElapsedTime = 0;
        WakeUpElapsedTime = 0;
        UsingCameraElapsedTime = 0;
        DrunkElapsedTime = 0;
    }
    void Update()
    {
        // Input //
            // Check if the user typed any characters this frame
            string input = Input.inputString;

            if (!string.IsNullOrEmpty(input))
            {
                // Take the first character typed
                char keyChar = input[0];

                // Switch based on characters '1' through '6'
                switch (keyChar)
                {
                    case '1':
                        IsFlashBanged = true;
                        break;
                    case '2':
                        IsDamaged = true;
                        break;
                    case '3':
                        IsHealing = true;
                        break;
                    case '4':
                        IsWakingUp = true;
                        break;
                    case '5':
                         IsUsingCamera = true;
                        break;
                    case '6':
                        IsDrunk = true;
                        break;
                }
            }
        // Store Colors //
            Color FBColor1 = material.GetColor(Shader.PropertyToID("_FlashBangAction1"));
            Color FBColor2 = material.GetColor(Shader.PropertyToID("_FlashBangAction2"));
            Color DaColor1 = material.GetColor(Shader.PropertyToID("_DamageAction1"));
            Color DaColor2 = material.GetColor(Shader.PropertyToID("_DamageAction2"));
            Color HColor1 = material.GetColor(Shader.PropertyToID("_HealAction1"));
            Color HColor2 = material.GetColor(Shader.PropertyToID("_HealAction2"));
            Color WColor1 = material.GetColor(Shader.PropertyToID("_WakeUpAction1"));
            Color WColor2 = material.GetColor(Shader.PropertyToID("_WakeUpAction2"));
            Color UCColor1 = material.GetColor(Shader.PropertyToID("_UseCameraAction1"));
            Color UCColor2 = material.GetColor(Shader.PropertyToID("_UseCameraAction2"));
            Color DrColor1 = material.GetColor(Shader.PropertyToID("_DrunkAction1"));
            Color DrColor2 = material.GetColor(Shader.PropertyToID("_DrunkAction2"));
        // "Start", "Cycle through" and "End" Post Process //
            if ( IsFlashBanged || (FlashBangIndex == FlashBangCountdowns.Length)     || ((FlashBangIndex < 4)   && (FBColor1 != new Color(0,0,0,0))) || ((FlashBangIndex > 3)   && (FBColor2 != new Color(0,0,0,0))) ) 
                { FlashBang(); }
            if ( IsDamaged     || (DamageIndex == DamageCountdowns.Length)           || ((DamageIndex < 4)      && (DaColor1 != new Color(0,0,0,0))) || ((DamageIndex > 3)      && (DaColor2 != new Color(0,0,0,0))) ) 
                { Damage(); }
            if ( IsHealing     || (HealIndex == HealCountdowns.Length)               || ((HealIndex < 4)        && (HColor1 !=  new Color(0,0,0,0))) || ((HealIndex > 3)        && (HColor2 !=  new Color(0,0,0,0))) ) 
                { Heal(); }
            if ( IsWakingUp    || (WakeUpIndex == WakeUpCountdowns.Length)           || ((WakeUpIndex < 4)      && (WColor1 !=  new Color(0,0,0,0))) || ((WakeUpIndex > 3)      && (WColor2 !=  new Color(0,0,0,0))) ) 
                { WakeUp(); } 
            if ( IsUsingCamera || (UsingCameraIndex == UsingCameraCountdowns.Length) || ((UsingCameraIndex < 4) && (UCColor1 != new Color(0,0,0,0))) || ((UsingCameraIndex > 3) && (UCColor2 != new Color(0,0,0,0))) ) 
                { UseCamera(); }
            if ( IsDrunk       || (DrunkIndex == DrunkCountdowns.Length)             || ((DrunkIndex < 4)       && (DrColor1 != new Color(0,0,0,0))) || ((DrunkIndex > 3)       && (DrColor2 != new Color(0,0,0,0))) ) 
                { Drunk(); }
        // Post Process "Fade In" / "Fade Out" effect //
            // FlashBang //
                if (((FlashBangIndex == 0) || (FlashBangIndex == FlashBangCountdowns.Length-1)) && (FlashBangElapsedTime < 1f))
                { 
                    Debug.Log("+-FB: "+ FlashBangElapsedTime);
                    FlashBangElapsedTime = Mathf.Min(FlashBangElapsedTime+(Time.deltaTime/FlashBangCountdowns[FlashBangIndex]), 1f); 
                    if (FlashBangIndex == 0)
                    { material.SetFloat(Shader.PropertyToID("_FlashBang_Alpha"), FlashBangElapsedTime); }
                    else
                    { material.SetFloat(Shader.PropertyToID("_FlashBang_Alpha"), (1f-FlashBangElapsedTime)); }
                }
            // Damage //
                if (((DamageIndex == 0) || (DamageIndex == DamageCountdowns.Length-1)) && (DamageElapsedTime < 1f))
                { 
                    Debug.Log("+-Da: "+ DamageElapsedTime);
                    DamageElapsedTime = Mathf.Min(DamageElapsedTime+(Time.deltaTime/DamageCountdowns[DamageIndex]), 1f); 
                    if (DamageIndex == 0)
                    { material.SetFloat(Shader.PropertyToID("_Damage_Alpha"), DamageElapsedTime); }
                    else
                    { material.SetFloat(Shader.PropertyToID("_Damage_Alpha"), (1f-DamageElapsedTime)); }
                }
            // Heal //
                if (((HealIndex == 0) || (HealIndex == HealCountdowns.Length-1)) && (HealElapsedTime < 1f))
                { 
                    Debug.Log("+-H: "+ HealElapsedTime);
                    HealElapsedTime = Mathf.Min(HealElapsedTime+(Time.deltaTime/HealCountdowns[HealIndex]), 1f); 
                    if (HealIndex == 0)
                    { material.SetFloat(Shader.PropertyToID("_Heal_Alpha"), HealElapsedTime); }
                    else
                    { material.SetFloat(Shader.PropertyToID("_Heal_Alpha"), (1f-HealElapsedTime)); }
                }
            // Drunk //
                if (((DrunkIndex == 0) || (DrunkIndex == DrunkCountdowns.Length-1)) && (DrunkElapsedTime < 1f))
                { 
                    Debug.Log("+-Dr: "+ DrunkElapsedTime);
                    DrunkElapsedTime = Mathf.Min(DrunkElapsedTime+(Time.deltaTime/DrunkCountdowns[DrunkIndex]), 1f); 
                    if (DrunkIndex == 0)
                    { material.SetFloat(Shader.PropertyToID("_Drunk_Alpha"), DrunkElapsedTime); }
                    else
                    { material.SetFloat(Shader.PropertyToID("_Drunk_Alpha"), (1f-DrunkElapsedTime)); }
                }
            // Using Camera //
                if (((UsingCameraIndex == 0) || (UsingCameraIndex == UsingCameraCountdowns.Length-1)) && (UsingCameraElapsedTime < 1f))
                { 
                    Debug.Log("+-UC: "+ UsingCameraElapsedTime);
                    UsingCameraElapsedTime = Mathf.Min(UsingCameraElapsedTime+(Time.deltaTime/UsingCameraCountdowns[UsingCameraIndex]), 1f); 
                    if (UsingCameraIndex == 0)
                    { material.SetFloat(Shader.PropertyToID("_UseCamera_Alpha"), UsingCameraElapsedTime); }
                    else
                    { material.SetFloat(Shader.PropertyToID("_UseCamera_Alpha"), (1f-UsingCameraElapsedTime)); }
                }
            // Wake Up //
                if (((WakeUpIndex == 0) || (WakeUpIndex == WakeUpCountdowns.Length-1)) && (WakeUpElapsedTime < 1f))
                { 
                    Debug.Log("+-WU: "+ WakeUpElapsedTime);
                    WakeUpElapsedTime = Mathf.Min(WakeUpElapsedTime+(Time.deltaTime/WakeUpCountdowns[WakeUpIndex]), 1f); 
                    if (WakeUpIndex == 0)
                    { material.SetFloat(Shader.PropertyToID("_WakeUp_Alpha"), WakeUpElapsedTime); }
                    else
                    { material.SetFloat(Shader.PropertyToID("_WakeUp_Alpha"), (1f-WakeUpElapsedTime)); }
                }
    }
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);
    }

    IEnumerator WaitAndAct(float Flt_WaitTime, int Int_Index)
    {
        switch (Int_Index)
        {
            case 0:
                HasFlashBangStarted = false;
            break;
            case 1:
                HasDamageStarted = false;
            break;
            case 2:
                HasHealStarted = false;
            break;
            case 3:
                HasWakeUpStarted = false;
            break;
            case 4:
                HasUsingCameraStarted = false;
            break;
            case 5:
                HasDrunkStarted = false;
            break;
        }
        yield return new WaitForSeconds(Flt_WaitTime);
        switch (Int_Index)
        {
            case 0:
                Debug.Log("T: FB || I: "+FlashBangIndex+"/"+FlashBangCountdowns.Length);
                if (FlashBangIndex < FlashBangCountdowns.Length) { HasFlashBangStarted = true; FlashBang(); FlashBangElapsedTime = 0; }
            break;
            case 1:
                Debug.Log("T: Da || I: " + DamageIndex + "/" + DamageCountdowns.Length);
                if (DamageIndex < DamageCountdowns.Length) { HasDamageStarted = true; Damage(); DamageElapsedTime = 0; }
            break;
            case 2:
                Debug.Log("T: H || I: " + HealIndex + "/" + HealCountdowns.Length);
                if (HealIndex < HealCountdowns.Length) { HasHealStarted = true; Heal(); HealElapsedTime = 0; }
            break;
            case 3:
                Debug.Log("T: W || I: " + WakeUpIndex + "/" + WakeUpCountdowns.Length);
                if (WakeUpIndex < WakeUpCountdowns.Length) { HasWakeUpStarted = true; WakeUp(); WakeUpElapsedTime = 0; }
                break;
            case 4:
                Debug.Log("T: C || I: " + UsingCameraIndex + "/" + UsingCameraCountdowns.Length);
                if (UsingCameraIndex < UsingCameraCountdowns.Length) { HasUsingCameraStarted = true; UseCamera(); UsingCameraElapsedTime = 0; }
            break;
            case 5:
                Debug.Log("T: Dr || I: " + DrunkIndex + "/" + DrunkCountdowns.Length);
                if (DrunkIndex < DrunkCountdowns.Length) { HasDrunkStarted = true; Drunk(); DrunkElapsedTime = 0; }
            break;
        }
    }

    private void FlashBang()
    {
        if (HasFlashBangStarted)
        {
            FlashBangIndex++;
            if (FlashBangIndex < FlashBangCountdowns.Length)
            {
                HasFlashBangStarted = true;
                material.SetFloat(Shader.PropertyToID("_IsFlashBanged"), 1);
                switch (FlashBangIndex)
                {
                    case 0: material.SetColor(Shader.PropertyToID("_FlashBangAction1"), new Color(1, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_FlashBangAction2"), new Color(0, 0, 0, 0)); break;
                    case 1: material.SetColor(Shader.PropertyToID("_FlashBangAction1"), new Color(0, 1, 0, 0)); material.SetColor(Shader.PropertyToID("_FlashBangAction2"), new Color(0, 0, 0, 0)); break;
                    case 2: material.SetColor(Shader.PropertyToID("_FlashBangAction1"), new Color(0, 0, 1, 0)); material.SetColor(Shader.PropertyToID("_FlashBangAction2"), new Color(0, 0, 0, 0)); break;
                    case 3: material.SetColor(Shader.PropertyToID("_FlashBangAction1"), new Color(0, 0, 0, 1)); material.SetColor(Shader.PropertyToID("_FlashBangAction2"), new Color(0, 0, 0, 0)); break;

                    case 4: material.SetColor(Shader.PropertyToID("_FlashBangAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_FlashBangAction2"), new Color(1, 0, 0, 0)); break;
                    case 5: material.SetColor(Shader.PropertyToID("_FlashBangAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_FlashBangAction2"), new Color(0, 1, 0, 0)); break;
                    case 6: material.SetColor(Shader.PropertyToID("_FlashBangAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_FlashBangAction2"), new Color(0, 0, 1, 0)); break;
                    case 7: material.SetColor(Shader.PropertyToID("_FlashBangAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_FlashBangAction2"), new Color(0, 0, 0, 1)); break;
                }
                StartCoroutine(WaitAndAct(FlashBangCountdowns[FlashBangIndex], 0));
            }
            else
            {
                Debug.Log("A");
                material.SetFloat(Shader.PropertyToID("_IsFlashBanged"), 0);
                material.SetColor(Shader.PropertyToID("_FlashBangAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_FlashBangAction2"), new Color(0, 0, 0, 0));
                FlashBangIndex = -1; IsFlashBanged = false;
            }
        }
    }
    private void Damage()
    {
        if (HasDamageStarted)
        {
            DamageIndex++;
            if (DamageIndex < DamageCountdowns.Length)
            {
                HasDamageStarted = true;
                material.SetFloat(Shader.PropertyToID("_IsDamaged"), 1);
                switch (DamageIndex)
                {
                    case 0: material.SetColor(Shader.PropertyToID("_DamageAction1"), new Color(1, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DamageAction2"), new Color(0, 0, 0, 0)); break;
                    case 1: material.SetColor(Shader.PropertyToID("_DamageAction1"), new Color(0, 1, 0, 0)); material.SetColor(Shader.PropertyToID("_DamageAction2"), new Color(0, 0, 0, 0)); break;
                    case 2: material.SetColor(Shader.PropertyToID("_DamageAction1"), new Color(0, 0, 1, 0)); material.SetColor(Shader.PropertyToID("_DamageAction2"), new Color(0, 0, 0, 0)); break;
                    case 3: material.SetColor(Shader.PropertyToID("_DamageAction1"), new Color(0, 0, 0, 1)); material.SetColor(Shader.PropertyToID("_DamageAction2"), new Color(0, 0, 0, 0)); break;

                    case 4: material.SetColor(Shader.PropertyToID("_DamageAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DamageAction2"), new Color(1, 0, 0, 0)); break;
                    case 5: material.SetColor(Shader.PropertyToID("_DamageAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DamageAction2"), new Color(0, 1, 0, 0)); break;
                    case 6: material.SetColor(Shader.PropertyToID("_DamageAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DamageAction2"), new Color(0, 0, 1, 0)); break;
                    case 7: material.SetColor(Shader.PropertyToID("_DamageAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DamageAction2"), new Color(0, 0, 0, 1)); break;
                }
                StartCoroutine(WaitAndAct(DamageCountdowns[DamageIndex], 1));
            }
            else
            {
                material.SetFloat(Shader.PropertyToID("_IsDamaged"), 0);
                material.SetColor(Shader.PropertyToID("_DamageAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DamageAction2"), new Color(0, 0, 0, 0));
                DamageIndex = -1; IsDamaged = false;
            }
        }
    }
    private void Heal()
    {
        if (HasHealStarted)
        {
            HealIndex++;
            if (HealIndex < HealCountdowns.Length)
            {
                HasHealStarted = true;
                material.SetFloat(Shader.PropertyToID("_IsHealing"), 1);
                switch (HealIndex)
                {
                    case 0: material.SetColor(Shader.PropertyToID("_HealAction1"), new Color(1, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_HealAction2"), new Color(0, 0, 0, 0)); break;
                    case 1: material.SetColor(Shader.PropertyToID("_HealAction1"), new Color(0, 1, 0, 0)); material.SetColor(Shader.PropertyToID("_HealAction2"), new Color(0, 0, 0, 0)); break;
                    case 2: material.SetColor(Shader.PropertyToID("_HealAction1"), new Color(0, 0, 1, 0)); material.SetColor(Shader.PropertyToID("_HealAction2"), new Color(0, 0, 0, 0)); break;
                    case 3: material.SetColor(Shader.PropertyToID("_HealAction1"), new Color(0, 0, 0, 1)); material.SetColor(Shader.PropertyToID("_HealAction2"), new Color(0, 0, 0, 0)); break;

                    case 4: material.SetColor(Shader.PropertyToID("_HealAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_HealAction2"), new Color(1, 0, 0, 0)); break;
                    case 5: material.SetColor(Shader.PropertyToID("_HealAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_HealAction2"), new Color(0, 1, 0, 0)); break;
                    case 6: material.SetColor(Shader.PropertyToID("_HealAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_HealAction2"), new Color(0, 0, 1, 0)); break;
                    case 7: material.SetColor(Shader.PropertyToID("_HealAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_HealAction2"), new Color(0, 0, 0, 1)); break;
                }
                StartCoroutine(WaitAndAct(HealCountdowns[HealIndex], 2));
            }
            else
            {
                material.SetFloat(Shader.PropertyToID("_IsHealing"), 0);
                material.SetColor(Shader.PropertyToID("_HealAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_HealAction2"), new Color(0, 0, 0, 0));
                HealIndex = -1; IsHealing = false;
            }
        }
    }
    private void WakeUp()
    {
        if (HasWakeUpStarted)
        {
            WakeUpIndex++;
            if (WakeUpIndex < WakeUpCountdowns.Length)
            {
                HasWakeUpStarted = true;
                material.SetFloat(Shader.PropertyToID("_IsWakingUp"), 1);
                switch (WakeUpIndex)
                {
                    case 0: material.SetColor(Shader.PropertyToID("_WakeUpAction1"), new Color(1, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_WakeUpAction2"), new Color(0, 0, 0, 0)); break;
                    case 1: material.SetColor(Shader.PropertyToID("_WakeUpAction1"), new Color(0, 1, 0, 0)); material.SetColor(Shader.PropertyToID("_WakeUpAction2"), new Color(0, 0, 0, 0)); break;
                    case 2: material.SetColor(Shader.PropertyToID("_WakeUpAction1"), new Color(0, 0, 1, 0)); material.SetColor(Shader.PropertyToID("_WakeUpAction2"), new Color(0, 0, 0, 0)); break;
                    case 3: material.SetColor(Shader.PropertyToID("_WakeUpAction1"), new Color(0, 0, 0, 1)); material.SetColor(Shader.PropertyToID("_WakeUpAction2"), new Color(0, 0, 0, 0)); break;

                    case 4: material.SetColor(Shader.PropertyToID("_WakeUpAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_WakeUpAction2"), new Color(1, 0, 0, 0)); break;
                    case 5: material.SetColor(Shader.PropertyToID("_WakeUpAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_WakeUpAction2"), new Color(0, 1, 0, 0)); break;
                    case 6: material.SetColor(Shader.PropertyToID("_WakeUpAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_WakeUpAction2"), new Color(0, 0, 1, 0)); break;
                    case 7: material.SetColor(Shader.PropertyToID("_WakeUpAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_WakeUpAction2"), new Color(0, 0, 0, 1)); break;
                }
                StartCoroutine(WaitAndAct(WakeUpCountdowns[WakeUpIndex], 3));
                material.SetFloat(Shader.PropertyToID("_WakeUp_Time"), WakeUpCountdowns[WakeUpIndex]);
            }
            else
            {
                material.SetFloat(Shader.PropertyToID("_IsWakingUp"), 0);
                material.SetColor(Shader.PropertyToID("_WakeUpAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_WakeUpAction2"), new Color(0, 0, 0, 0));
                WakeUpIndex = -1;
                IsWakingUp = false;
            }
        }
    }
    private void UseCamera()
    {
        if (HasUsingCameraStarted)
        {
            UsingCameraIndex++;
            if (UsingCameraIndex < UsingCameraCountdowns.Length)
            {
                HasUsingCameraStarted = true;
                material.SetFloat(Shader.PropertyToID("_IsUsingCamera"), 1);
                switch (UsingCameraIndex)
                {
                    case 0: material.SetColor(Shader.PropertyToID("_UseCameraAction1"), new Color(1, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_UseCameraAction2"), new Color(0, 0, 0, 0)); break;
                    case 1: material.SetColor(Shader.PropertyToID("_UseCameraAction1"), new Color(0, 1, 0, 0)); material.SetColor(Shader.PropertyToID("_UseCameraAction2"), new Color(0, 0, 0, 0)); break;
                    case 2: material.SetColor(Shader.PropertyToID("_UseCameraAction1"), new Color(0, 0, 1, 0)); material.SetColor(Shader.PropertyToID("_UseCameraAction2"), new Color(0, 0, 0, 0)); break;
                    case 3: material.SetColor(Shader.PropertyToID("_UseCameraAction1"), new Color(0, 0, 0, 1)); material.SetColor(Shader.PropertyToID("_UseCameraAction2"), new Color(0, 0, 0, 0)); break;

                    case 4: material.SetColor(Shader.PropertyToID("_UseCameraAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_UseCameraAction2"), new Color(1, 0, 0, 0)); break;
                    case 5: material.SetColor(Shader.PropertyToID("_UseCameraAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_UseCameraAction2"), new Color(0, 1, 0, 0)); break;
                    case 6: material.SetColor(Shader.PropertyToID("_UseCameraAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_UseCameraAction2"), new Color(0, 0, 1, 0)); break;
                    case 7: material.SetColor(Shader.PropertyToID("_UseCameraAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_UseCameraAction2"), new Color(0, 0, 0, 1)); break;
                }
                StartCoroutine(WaitAndAct(UsingCameraCountdowns[UsingCameraIndex], 4));
            }
            else
            {
                material.SetFloat(Shader.PropertyToID("_IsUsingCamera"), 0);
                material.SetColor(Shader.PropertyToID("_UseCameraAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_UseCameraAction2"), new Color(0, 0, 0, 0));
                UsingCameraIndex = -1;
                IsUsingCamera = false;
            }
        }
    }
    private void Drunk()
    {
        if (HasDrunkStarted)
        {
            DrunkIndex++;
            if (DrunkIndex < DrunkCountdowns.Length)
            {
                HasDrunkStarted = true;
                material.SetFloat(Shader.PropertyToID("_IsDrunk"), 1);
                switch (DrunkIndex)
                {
                    case 0: material.SetColor(Shader.PropertyToID("_DrunkAction1"), new Color(1, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DrunkAction2"), new Color(0, 0, 0, 0)); break;
                    case 1: material.SetColor(Shader.PropertyToID("_DrunkAction1"), new Color(0, 1, 0, 0)); material.SetColor(Shader.PropertyToID("_DrunkAction2"), new Color(0, 0, 0, 0)); break;
                    case 2: material.SetColor(Shader.PropertyToID("_DrunkAction1"), new Color(0, 0, 1, 0)); material.SetColor(Shader.PropertyToID("_DrunkAction2"), new Color(0, 0, 0, 0)); break;
                    case 3: material.SetColor(Shader.PropertyToID("_DrunkAction1"), new Color(0, 0, 0, 1)); material.SetColor(Shader.PropertyToID("_DrunkAction2"), new Color(0, 0, 0, 0)); break;

                    case 4: material.SetColor(Shader.PropertyToID("_DrunkAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DrunkAction2"), new Color(1, 0, 0, 0)); break;
                    case 5: material.SetColor(Shader.PropertyToID("_DrunkAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DrunkAction2"), new Color(0, 1, 0, 0)); break;
                    case 6: material.SetColor(Shader.PropertyToID("_DrunkAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DrunkAction2"), new Color(0, 0, 1, 0)); break;
                    case 7: material.SetColor(Shader.PropertyToID("_DrunkAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DrunkAction2"), new Color(0, 0, 0, 1)); break;
                }
                StartCoroutine(WaitAndAct(DrunkCountdowns[DrunkIndex], 5));
            }
            else
            {
                material.SetFloat(Shader.PropertyToID("_IsDrunk"), -0);
                material.SetColor(Shader.PropertyToID("_DrunkAction1"), new Color(0, 0, 0, 0)); material.SetColor(Shader.PropertyToID("_DrunkAction2"), new Color(0, 0, 0, 0));
                DrunkIndex = -1; IsDrunk = false;
            }
        }
    }
}
