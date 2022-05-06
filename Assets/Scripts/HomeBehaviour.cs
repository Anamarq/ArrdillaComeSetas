using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HomeBehaviour : MonoBehaviour
{
    public ScorePanel scorePanel;

    private void Start()
    {
        scorePanel = FindObjectOfType<ScorePanel>();

    }
    private void OnTriggerEnter(Collider other)
    {
        scorePanel.points += 100;
        if (other.tag.Equals("Acorn"))
        {
            Debug.Log("Bellota en casa");
            scorePanel.EndGame(true);
        }
    }

}
