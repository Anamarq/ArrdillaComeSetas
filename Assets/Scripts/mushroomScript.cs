using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class mushroomScript : MonoBehaviour
{
    public PointsControl score;


    private void Start()
    {
        score = FindObjectOfType<PointsControl>();
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.tag.Equals("Player"))
        {
            if (this.tag.Equals("Mushroom"))
            {
                transform.gameObject.SetActive(false);
                Debug.Log("Contacto");
                score.AddPoints(10);
            }
            else if (this.tag.Equals("BadMushroom"))
            {
                transform.gameObject.SetActive(false);
                Debug.Log("Contacto");
                score.AddPoints(-10);
            }
        }
    }
}
