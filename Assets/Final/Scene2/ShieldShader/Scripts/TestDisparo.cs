using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestDisparo : MonoBehaviour
{
    [SerializeField] private WeaponEnergy arma;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            arma.EmpezarCarga();
        }
    }
}
