using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class AICharacterController : IdleController
{
//    public float speedModifier;
//    public bool StartGame;
//    void Update()
//    {
//        if (StartGame && !Deadh)
//        {
//#if !UNITY_EDITOR
//        if (Input.touchCount > 0)
//        {
//            touch = Input.GetTouch(0);
//            if (touch.phase == TouchPhase.Moved)
//            {
//                Move(2);
//            }
//            else{
//               GetComponent<Animator>().SetBool("Start", true);
//            }
//        }
//        //transform.Translate(transform.forward * 30f * Time.deltaTime, Space.World);
//#endif

//            if (speedSplineFollower < MaxSpeed)
//            {
//                speedSplineFollower += 10 * Time.deltaTime;
//                spline.followSpeed = speedSplineFollower;
//            }
//            else
//            {
//                GetComponent<Animator>().SetFloat("Speed", 1.7f);
//            }
//            if (Energy > 0)
//            {
//                Energy -= 2.5f * Time.deltaTime;
//            }
//            else
//            {

//            }
//        }
//    }
//    RaycastHit hit;
//    void FixedUpdate()
//    {
//        if (Physics.Raycast(this.transform.position, -this.transform.forward, out hit, 10f))
//        {
//            if (hit.transform.tag == "Engel")
//            {
//                if (spline.motion.offset.x > 0)
//                {
//                    Move(-0.1f);
//                }
//                else
//                {
//                    Move(0.1f);
//                }
//            }
//        }
//        if(hit.transform == null && StartGame && !Deadh) {
//            GetComponent<Animator>().SetBool("Start", true);

//        }
//    }
//    public void OnTriggerEnter(Collider other)
//    {
//        if (other.tag == "Engel")
//        {
//            DeadhCharacterAI();
//        }
//    }
//    public override void DeadhCharacterAI()
//    {
//        base.DeadhCharacterAI();
//    }
//    public override void Move(float Direction)
//    {
//        base.Move(Direction);
//    }
//    public override void EventHappened(EventName eventName, params object[] args)
//    {
//        if (eventName == EventName.StartGame)
//        {
//            StartGame = true;
//        }
//        base.EventHappened(eventName, args);
//    }
}
