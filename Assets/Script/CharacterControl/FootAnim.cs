using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FootAnim : MonoBehaviour, IEventListener
{
    void Start()
    {
        EventManager.Register(Channel.Game, this);
    }
    public void StartAnim() {
        LeanTween.rotateX(this.gameObject, 25.5f, 0.23f).setOnComplete(() => {
            LeanTween.rotateX(this.gameObject, -25.5f, 0.23f).setOnComplete(() => {
                StartAnim();
            });
        });
    }

    public void EventHappened(EventName eventName, params object[] args)
    {
        if (eventName == EventName.StartGame) {
            StartAnim();
        }
    }
}
