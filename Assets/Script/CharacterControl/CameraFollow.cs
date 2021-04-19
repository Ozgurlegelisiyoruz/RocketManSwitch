using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CameraFollow : MonoBehaviour
{
   public Transform Player;
    private Vector3 _cameraoffset;
   // [Range(.1f, 1f)]
    private float Smooth =10f;
    public float height_y,height_z;
    private void Start()
    {
        _cameraoffset = transform.position - Player.transform.position;
    }
    private void LateUpdate()
    {
        Vector3 Pos = (Player.transform.position + new Vector3(0, height_y, 0)) + (_cameraoffset);
        transform.position = Vector3.Slerp(this.transform.position, new Vector3(Pos.x, Pos.y, Pos.z - height_z), Smooth * Time.fixedDeltaTime);

    }
}
    