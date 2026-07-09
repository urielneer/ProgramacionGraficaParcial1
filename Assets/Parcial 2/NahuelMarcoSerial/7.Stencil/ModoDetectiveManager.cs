using UnityEngine;

public class ModoDetectiveManager : MonoBehaviour
{
    [Header("Configuracion de Enemigos")]
    public Material materialNormalEnemigo;
    public Material materialDetectiveEnemigo;
    private GameObject[] enemigos;

    [Header("Configuracion del Radar")]
    public GameObject objetoEsferaRadar; 
    public float radioMaximo = 25f;
    public float velocidadExpansion = 15f;

    private bool modoDetectiveActivo = false;
    private bool expandiendoRadar = false;
    private float radioActual = 0f;

    void Start()
    {
        enemigos = GameObject.FindGameObjectsWithTag("Enemy");
        if (objetoEsferaRadar != null) objetoEsferaRadar.SetActive(false);
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.V))
        {
            modoDetectiveActivo = !modoDetectiveActivo;
            AlternarVisionEnemigos(modoDetectiveActivo);

            if (modoDetectiveActivo)
            {
                DispararPulsoRadar();
            }
            else
            {
                expandiendoRadar = false;
                if (objetoEsferaRadar != null) objetoEsferaRadar.SetActive(false);
            }
        }

        if (expandiendoRadar && objetoEsferaRadar != null)
        {
            radioActual += velocidadExpansion * Time.deltaTime;
            objetoEsferaRadar.transform.localScale = new Vector3(radioActual, radioActual, radioActual);

            if (radioActual >= radioMaximo)
            {
                expandiendoRadar = false;
                objetoEsferaRadar.SetActive(false); // Se apaga al llegar al limite
            }
        }
    }

    void DispararPulsoRadar()
    {
        radioActual = 0f;
        expandiendoRadar = true;
        if (objetoEsferaRadar != null)
        {
            objetoEsferaRadar.SetActive(true);
            objetoEsferaRadar.transform.localScale = Vector3.zero;
            objetoEsferaRadar.transform.position = GameObject.FindGameObjectWithTag("Player").transform.position;
        }
    }

    void AlternarVisionEnemigos(bool activar)
    {
        foreach (GameObject enemigo in enemigos)
        {
            Renderer rend = enemigo.GetComponent<Renderer>();
            if (rend != null)
            {
                rend.materials = activar ?
                    new Material[] { materialNormalEnemigo, materialDetectiveEnemigo } :
                    new Material[] { materialNormalEnemigo };

            }
        }
        RenderSettings.ambientLight = activar ? new Color(0f, 0.2f, 0.5f) : Color.white;
    }
}