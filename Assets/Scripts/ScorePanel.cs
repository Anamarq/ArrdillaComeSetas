using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class ScorePanel : MonoBehaviour
{
    public GameObject panelEnd;
    public GameObject panelStart;

    public Text pointsText;
    public Text causeText;
    public CountdownTimer timer;

    public int points;

    // Start is called before the first frame update
    void Start()
    {
        panelEnd.SetActive(false);
        panelStart.SetActive(true);
        timer = FindObjectOfType<CountdownTimer>();
    }

    public void EndGame(bool win)
    {
        panelEnd.SetActive(true);

        timer.running = false;

        pointsText.text = "Has conseguido...\n" + "Puntos: " + points.ToString();
        if (win)
        {
            causeText.text = "¡Enhorabuena, disfruta del festín!";
        }
        else
        {
            causeText.text = "Se te ha acabado el tiempo,\nha llegado el invierno";
        }
    }

    public void restartGame()
    {
        Debug.Log("RestartGame");
        //timer.running = true;
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

    public void StartGame()
    {
        Debug.Log("StartGame");
        timer.running = true;
        panelStart.SetActive(false);
    }

}
