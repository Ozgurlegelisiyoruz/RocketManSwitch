using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GoldAnimation : MonoBehaviour
{
    [HideInInspector] public float StartPos;
    void Start()
    {
        Anim();
        RotateAnim();
    }
    void Anim()
    {
        StartPos = this.transform.position.y;
        LeanTween.moveY(this.gameObject, StartPos - 0.25f, 1f).setOnComplete(() =>
        {
            LeanTween.moveY(this.gameObject, StartPos, 1f).setOnComplete(() => {
                Anim();
            });
        });
    }
    void RotateAnim()
    {
        LeanTween.rotateY(this.gameObject, 180, 3).setOnComplete(() => {
            LeanTween.rotateY(this.gameObject, 0, 3).setOnComplete(() => {
                RotateAnim();
            });
        });
    }
}
