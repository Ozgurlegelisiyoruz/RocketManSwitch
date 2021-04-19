using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CharacterController : IdleController
{
    private Touch touch;
    public float speedModifier;
    //public Image slideBar;
    public bool StartGame;
    public Image slideBar,sliderBarEnergy;
    private void Start()
    {
        
    }
#if !UNITY_EDITOR
 void Update()
    {
        if (StartGame) {
        if (Input.touchCount > 0)
        {
            touch = Input.GetTouch(0);
            if (touch.phase == TouchPhase.Moved)
            {
                Move(touch.deltaPosition.x * speedModifier);
            }
        }
        //transform.Translate(transform.forward * 30f * Time.deltaTime, Space.World);

           GetUpdate();
        }
    }
#endif
#if UNITY_EDITOR
    void Update()
    {
        if (StartGame)
        {
            if (Input.GetKey(KeyCode.Mouse0))
            {
                Move(Input.GetAxis("Mouse X") * 0.05f);
            }
            GetUpdate();
        }
    }
#endif
    [HideInInspector] public bool SendOneWinEvent;
    [HideInInspector] public bool SendOneFailEvent;
    public GameObject effectOne, effectTwo;
    public void GetUpdate() {
        slideBar.fillAmount = (float)spline.result.percent;
        if (speedSplineFollower < MaxSpeed)
        {
            speedSplineFollower += 10 * Time.deltaTime;
            spline.followSpeed = speedSplineFollower;
        }
        if (Energy >= 0 && Energy < 101)
        {
            Energy -= 4 * Time.deltaTime;
        }
        if (Energy > 100) {
            Energy = 100;
        }
        if (Energy < 0) {
            if (!ForwardGetX) {
                if (!SendOneFailEvent) {
                    FinishFollow();
                    EventManager.PublishEvent(Channel.Game, EventName.FinishGame);
                    SendOneFailEvent = true;
                }
            }
            Energy = 0;
        }
        if (ForwardGetX)
        {
            if (Energy > 0)
            {
                transform.Translate(Vector3.forward * 6 * Time.fixedDeltaTime, Space.World);
            }
            else {
                if (!SendOneWinEvent) {
                    EventManager.PublishEvent(Channel.Game, EventName.Win);
                    SendOneWinEvent = true;
                }
            }
        }
        sliderBarEnergy.fillAmount = Energy / 100;
    }

    public override void Move(float Direction)
    {
        base.Move(Direction);
    }
    public override void EventHappened(EventName eventName, params object[] args)
    {
        if (eventName == EventName.StartGame) {
            effectOne.SetActive(true);
            effectTwo.SetActive(true);
            StartGame = true;
        }
        base.EventHappened(eventName, args);
    }
}
