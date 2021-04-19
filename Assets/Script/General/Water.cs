using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Water : MonoBehaviour
{
    public float speed;
    public int direction = 1;
    private void LateUpdate()
    {
        speed += 0.1f * Time.deltaTime;
        this.GetComponent<MeshRenderer>().material.SetTextureOffset("_BaseMap", new Vector2(0, (direction * speed)));
    }
}
