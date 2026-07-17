using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SecuenciaDeCombate : MonoBehaviour
{
    [SerializeField] private WeaponEnergy arma;

    private IEnumerator Start()
    {
        yield return new WaitForSeconds(1.5f);
        arma.EmpezarCarga(); // al llegar a carga completa, WeaponEnergy dispara solo
    }
}
