using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CountdownTimer : MonoBehaviour
{
    private float currentTime =  0 ;
    public float startingTime = 10;
    public Text countdownText;

    private void Start()
    {
        currentTime = startingTime;
    }
    private void Update()
    {
        currentTime -= Time.deltaTime;
        countdownText.text = currentTime.ToString("0");
        if (currentTime <= 0)
        {
            ///Fin del tiempo
            currentTime = 0;
        }
    }
}
