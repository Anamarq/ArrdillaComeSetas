using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CountdownTimer : MonoBehaviour
{
    private float currentTime =  0 ;
    public float startingTime = 30;
    public Text countdownText;
    public ScorePanel scorePanel;
    public bool running;

    private void Start()
    {
        currentTime = startingTime;
        scorePanel = FindObjectOfType<ScorePanel>();
        running = false;
    }
    private void Update()
    {
        if (running)
        {
            currentTime -= Time.deltaTime;
            countdownText.text = currentTime.ToString("0");
            if (currentTime <= 0)
            {
                ///Fin del tiempo
                currentTime = 0;
                scorePanel.EndGame(false);
            }
        }
    }
}
