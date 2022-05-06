using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MapElementsPlacement : MonoBehaviour
{

    public GameObject mushrom;
    public GameObject badMushrom;
    public GameObject home;
    public GameObject acorn;

    private float maxX = 5.5f;
    private float minX = -5.5f;
    private float maxZ = 5.5f;
    private float minZ = -5.2f;

    private Vector3 homePos;

    private int numMushrooms = 6;
    private int numBadMushrooms = 4;

    // Start is called before the first frame update
    void Awake()
    {
        PlaceThings();
    }

    private void PlaceThings()
    {
        homePos.x = Random.Range(minX, maxX);
        homePos.z = Random.Range(minZ, maxZ);
        homePos.y = -0.35f;

        Instantiate(home, homePos, Quaternion.identity);
        
        placeAcorn();

        for (int i=0;i < numMushrooms; i++)
        {
            placeMushroom();
        }

        for (int i = 0; i < numBadMushrooms; i++)
        {
            placeBadMushroom();
        }
    }

    private void placeMushroom()
    {
        float randX;
        float randZ;

        bool validPos = false;
        do
        {
            randX = Random.Range(minX, maxX);
            if(randX <= (homePos.x + 2) || randX >= (homePos.x - 2))
            {
                validPos = true;
            }
        } while (!validPos);
        do
        {
            randZ = Random.Range(minZ, maxZ);
            if (randZ <= (homePos.z + 2) || randZ >= (homePos.z - 2))
            {
                validPos = true;
            }
        } while (!validPos);

        Instantiate(mushrom, new Vector3(randX, 0.2f, randZ), new Quaternion(0.707106829f, 0, 0, 0.707106829f));

    }

    private void placeBadMushroom()
    {
        float randX;
        float randZ;

        bool validPos = false;
        do
        {
            randX = Random.Range(minX, maxX);
            if (randX <= (homePos.x + 2) || randX >= (homePos.x - 2))
            {
                validPos = true;
            }
        } while (!validPos);
        do
        {
            randZ = Random.Range(minZ, maxZ);
            if (randZ <= (homePos.z + 2) || randZ >= (homePos.z - 2))
            {
                validPos = true;
            }
        } while (!validPos);

        Instantiate(badMushrom, new Vector3(randX, 0.2f, randZ), new Quaternion(0.707106829f, 0, 0, 0.707106829f));

    }

    private void placeAcorn()
    {
        float randX;
        float randZ;

        bool validPos = false;
        do
        {
            randX = Random.Range(minX, maxX);
            if (randX <= (homePos.x + 2) || randX >= (homePos.x - 2))
            {
                validPos = true;
            }
        } while (!validPos);
        do
        {
            randZ = Random.Range(minZ, maxZ);
            if (randZ <= (homePos.z + 2) || randZ >= (homePos.z - 2))
            {
                validPos = true;
            }
        } while (!validPos);

        Instantiate(acorn, new Vector3(randX, 0.2f, randZ), Quaternion.identity);

    }
}
