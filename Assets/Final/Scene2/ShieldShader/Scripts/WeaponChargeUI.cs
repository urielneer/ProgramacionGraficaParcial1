using UnityEngine;
using UnityEngine.UI;

// UI/Sprite "extra" del arma: una barra de carga que se suma al brillo diegético
// del núcleo del arma. Se suscribe a WeaponEnergy.OnCargaCambiada y actualiza
// el material SH_UI_ChargeBar asignado al Image.
public class WeaponChargeUI : MonoBehaviour
{
    [SerializeField] private WeaponEnergy arma;
    [SerializeField] private Image barraDeCarga; // Image con material SH_UI_ChargeBar

    private static readonly int ChargeID = Shader.PropertyToID("_Charge");
    private Material materialInstancia;

    private void Awake()
    {
        materialInstancia = barraDeCarga.material;
    }

    private void OnEnable()
    {
        arma.OnCargaCambiada += ActualizarBarra;
    }

    private void OnDisable()
    {
        arma.OnCargaCambiada -= ActualizarBarra;
    }

    private void ActualizarBarra(float carga)
    {
        materialInstancia.SetFloat(ChargeID, carga);
    }
}
