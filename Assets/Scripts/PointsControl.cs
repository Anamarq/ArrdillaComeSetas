using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PointsControl : MonoBehaviour
{

    public Text pointsText;
    public int points;

    public ScorePanel scorePanel;

    // Start is called before the first frame update
    void Start()
    {
        scorePanel = FindObjectOfType<ScorePanel>();

        points = 0;
        SetTextPoints();
        scorePanel.points = points;
    }

    // Update is called once per frame
    void Update()
    {
    }

    private void SetTextPoints()
    {
        pointsText.text = points.ToString();
    }

    public void AddPoints(int p)
    {
        points += p;
        SetTextPoints();
        scorePanel.points = points;
    }


}
