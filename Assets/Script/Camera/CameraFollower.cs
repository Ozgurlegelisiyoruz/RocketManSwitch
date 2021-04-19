using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollower : MonoBehaviour
{
    [SerializeField] private float moveHardness;

    public Transform offset;
    public Transform target;
    void LateUpdate()
    {

        transform.position = Vector3.Lerp(this.transform.position, offset.transform.position, moveHardness);
        transform.LookAt(target);
    }
}
