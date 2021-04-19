using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColorChangerSelectColor : MonoBehaviour, IEventListener
{
    [HideInInspector] public List<color.ColorTypeInfo> colorTypeSwitch;
    public color.ColorTypeInfo nowColor;
    int randomSwitch;

    public void Awake()
    {
        EventManager.Register(Channel.Game, this);
        randomSwitch = Random.Range(0, 3);
    }
    public void EventHappened(EventName eventName, params object[] args)
    {
        if (eventName == EventName.GetColorList) {
            colorTypeSwitch = (List<color.ColorTypeInfo>)args[0];
            nowColor = colorTypeSwitch[randomSwitch];
            this.transform.transform.Find("ColorSwitch").transform.Find("ColorSwitchChild").GetComponent<MeshRenderer>().material = nowColor.ColorTrans;
        }
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player") {
            other.transform.parent.gameObject.GetComponent<IdleController>().nowColor = nowColor;
            //for (int i = 0; i < 4; i++)
            //{
            //    other.gameObject.transform.Find("DScooter").transform.Find(i.ToString()).GetComponent<MeshRenderer>().material = nowColor.ColorMaterial;
            //}
            Destroy(this.gameObject, 6f);
            other.transform.parent.gameObject.transform.Find("Cube.003").GetComponent<SkinnedMeshRenderer>().material = nowColor.ColorMaterial;
        }   
    }
}
