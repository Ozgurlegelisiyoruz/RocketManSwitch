using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColorSwitcher : MonoBehaviour
{
    public List<color.ColorTypeInfo> colorTypeSwitch;
    void Start()
    {
        EventManager.PublishEvent(Channel.Game, EventName.GetColorList, colorTypeSwitch);
    }
}
