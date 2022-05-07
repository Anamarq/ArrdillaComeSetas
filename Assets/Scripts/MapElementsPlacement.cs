using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MapElementsPlacement : MonoBehaviour
{

    public GameObject mushrom;
    public GameObject badMushrom;
    public GameObject home;
    public GameObject acorn;
    //public GameObject squirrel;

    private float maxX = 5f;
    private float minX = -5f;
    private float maxZ = 5f;
    private float minZ = -5f;

    private Vector3 homePos;
    private Vector3 squirrelPos;


    private int numMushrooms = 6;
    private int numBadMushrooms = 4;

    // Start is called before the first frame update
    void Awake()
    {
        PlaceThings();
    }

    private void PlaceThings()
    {
        squirrelPos = new Vector3(0f, 0.370000005f, -3.07999992f);

        placeHome();        
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

        Instantiate(mushrom, new Vector3(randX, -0.3061871f, randZ), new Quaternion(0.707106829f, 0, 0, 0.707106829f));

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

        Instantiate(badMushrom, new Vector3(randX, -0.3061871f, randZ), new Quaternion(0.707106829f, 0, 0, 0.707106829f));

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

    private void placeHome()
    {
        homePos.y = 0.7325617f;

        bool validPos = false;
        do
        {
            homePos.x = Random.Range(minX, maxX);
            if (homePos.x <= (squirrelPos.x + 2) || homePos.x >= (squirrelPos.x - 2))
            {
                validPos = true;
            }
        } while (!validPos);
        do
        {
            homePos.z = Random.Range(0, maxZ);
            if (homePos.z <= (squirrelPos.z + 2) || homePos.z >= (squirrelPos.z - 2))
            {
                validPos = true;
            }
        } while (!validPos);

        Instantiate(home, homePos, new Quaternion(-0.5f, -0.5f, -0.5f, 0.5f));

    }
}
