using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HandAnim : MonoBehaviour
{
    public Transform left, right;
    void Start()
    {
        StartAnim(left.transform.position, right.transform.position);
    }
    public void StartAnim(Vector3 start, Vector3 end)
    {
        this.transform.position = start;
        LeanTween.move(this.gameObject, end, 1).setLoopPingPong().setOnComplete(() => {
            this.transform.position = start;
        });
    }
}
