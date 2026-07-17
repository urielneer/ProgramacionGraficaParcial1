using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SecuenciaDeCombate : MonoBehaviour
{
    [SerializeField] private WeaponEnergy arma;
    [SerializeField] private GameObject pj; // el objeto del jugador que "muere" en el segundo disparo

    [Header("Tiempos (hardcodeados)")]
    [SerializeField] private float delayInicial = 1.5f;
    [SerializeField] private float delayEntreDisparos = 1.5f; // tiempo entre el 1er y el 2do disparo

    private int disparosHechos = 0;

    private void OnEnable()
    {
        arma.OnDisparo += ManejarDisparo;
    }

    private void OnDisable()
    {
        arma.OnDisparo -= ManejarDisparo;
    }

    private IEnumerator Start()
    {
        yield return new WaitForSeconds(delayInicial);
        arma.EmpezarCarga(); // 1er disparo: le pega al escudo y lo rompe
    }

    private void ManejarDisparo()
    {
        disparosHechos++;

        if (disparosHechos == 1)
        {
            // escudo ya roto (ShieldEnergy.RecibirImpacto se dispara solo por el raycast del arma)
            StartCoroutine(DispararDeNuevo());
        }
        else if (disparosHechos == 2)
        {
            // sin escudo en el medio, el raycast le pega directo al PJ
            MatarPJ();
        }
    }

    private IEnumerator DispararDeNuevo()
    {
        yield return new WaitForSeconds(delayEntreDisparos);
        arma.EmpezarCarga(); // 2do disparo: mata al PJ
    }

    private void MatarPJ()
    {
        if (pj == null) return;
        pj.SetActive(false); // "muerte" hardcodeada y simple
    }
}
