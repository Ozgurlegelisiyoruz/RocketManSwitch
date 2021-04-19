using Dreamteck.Splines;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class IdleController : MonoBehaviour, IEventListener
{
    public SplineFollower spline;
    public float speedSplineFollower;
    public float MaxSpeed;
    public GameObject WheelScooter;
    public float Energy;
    [HideInInspector] public List<color.ColorTypeInfo> colorTypeSwitch;
    public color.ColorTypeInfo nowColor;
    [HideInInspector] public bool ForwardGetX;
    public GameObject instantiateCoinAnim;
    void Awake()
    {
        EventManager.Register(Channel.Game, this);
    }
    public virtual void EventHappened(EventName eventName, params object[] args)
    {
        if (eventName == EventName.StartGame) {
            spline.motion.offset = new Vector2(0, 0.38f);
            spline.follow = true;
        }
        if (eventName == EventName.GetColorList)
        {
            colorTypeSwitch = (List<color.ColorTypeInfo>)args[0];
            nowColor = colorTypeSwitch[0];
        }
    }
    public virtual void Move(float Direction) {
        if (Direction < 0)
        {
            if (spline.motion.offset.x >= -0.9260001f)
            {
                spline.motion.offset = Vector2.Lerp(new Vector2(spline.motion.offset.x, spline.motion.offset.y), new Vector2(spline.motion.offset.x + Direction, spline.motion.offset.y), 0.8f);
            }
        }
        else {
            if (spline.motion.offset.x <= 0.9260001f)
            {
                spline.motion.offset = Vector2.Lerp(new Vector2(spline.motion.offset.x, spline.motion.offset.y), new Vector2(spline.motion.offset.x + Direction, spline.motion.offset.y), 0.8f);
            }
        }
    }
    public Transform animTargetTransform;
    public void OntriggerGetChild(Collider other)
    {
        Debug.Log(other.tag);
        if (other.tag == "Red" || other.tag == "Green" || other.tag == "Yellow") {

            if (SlowCheck(other.tag.ToString()))
            {
                GameObject items = Instantiate(instantiateCoinAnim);
                items.transform.parent = GameObject.Find("Canvas").transform;
                items.GetComponent<RectTransform>().position = new Vector3(540, 960, 0);
                LeanTween.move(items, animTargetTransform.position, 0.3f);
                LeanTween.value(items, 255, 0, 0.3f).setOnUpdate((float val) => {
                    items.GetComponent<Image>().color = new Color(255, 255, 255, val);
                });
                Destroy(items, 0.5f);
                Energy += 1f;
            }
            else {
                Slow();
            }
            Destroy(other.gameObject);
        }
        if (other.tag == "Boost") {
            Boost();
        }
        if (other.tag == "SpeedBost")
        {
            SpeedBost();
        }
        if (other.tag == "TransparentSelect") {
            EventManager.PublishEvent(Channel.Game, EventName.SelectBonus);
        }
        if (other.tag == "Engel") {
            FinishFollow();
            EventManager.PublishEvent(Channel.Game, EventName.FinishGame);
        }
        if (other.tag == "Coin")
        {
            EventManager.PublishEvent(Channel.Game, EventName.Coin);
            Destroy(other.gameObject);
        }
        if (other.tag == "BonusCube") {
            GetComponent<Rigidbody>().velocity = Vector3.zero;
            GetComponent<Rigidbody>().isKinematic = true;
        }
    }
    public void SpeedBost() {
        float startSpeed = spline.followSpeed;
        spline.followSpeed = 12;
        StartCoroutine(goStartSpeed(startSpeed));
    }
    IEnumerator goStartSpeed(float speedStart) {
        yield return new WaitForSeconds(1);
        spline.followSpeed = speedStart;

    }
    public void Boost() {
        FinishFollow();
        GetComponent<Rigidbody>().constraints = RigidbodyConstraints.FreezeRotation;
        GetComponent<Rigidbody>().AddForce(Vector3.forward * 650 + Vector3.up * 300);
        StartCoroutine(startCameraAnim());
    }
    public void FinishFollow() {
        GetComponent<Rigidbody>().velocity = Vector3.zero;
        spline.follow = false;
    }
    IEnumerator startCameraAnim() {
        yield return new WaitForSeconds(1.75f);
        ForwardGetX = true;
        LeanTween.move(Camera.main.gameObject, transform.Find("BirdView"), 0.8f);
        LeanTween.rotate(Camera.main.gameObject, new Vector3(24f,0,0), 0.8f);

    }
    public void Slow() {
        speedSplineFollower = 0.05f;
        Energy -= 12;
        EventManager.PublishEvent(Channel.Game, EventName.StartWarningAnim);
    }
    public bool SlowCheck(string tagEnergy)
    {
        bool Check = false;
        for (int i = 0; i < colorTypeSwitch.Count; i++)
        {
            if (nowColor.ColorName.ToString() == tagEnergy)
            {
                Check = true;
                Vibrator.Vibrate(15);
            }
        }
        return Check;
    }
}

