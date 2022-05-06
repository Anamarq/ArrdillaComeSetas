using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using System;

public class squirrelController : MonoBehaviour
{
    public float rotSpeed = 5f;
    public float speed = 0.2f;

    private Vector2 _movement;
    // Start is called before the first frame update
    void Start()
    {

    }

    
    private void FixedUpdate()
    {
        Transform playerTransform = transform;
        playerTransform.Rotate(Vector3.up * _movement.x * rotSpeed);
        playerTransform.Translate(Vector3.forward * _movement.y * speed);
    }

    public void OnMove(InputAction.CallbackContext context)
    {
        _movement = context.action.ReadValue<Vector2>();
    }


}
