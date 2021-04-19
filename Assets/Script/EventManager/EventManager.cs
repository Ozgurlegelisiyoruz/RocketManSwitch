using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EventManager : MonoBehaviour
{
    private static Dictionary<Channel, List<IEventListener>>
         listeners = new Dictionary<Channel, List<IEventListener>>();

    public static void Clean()
    {
        listeners.Clear();
    }

    public static void PublishEvent(Channel channel, EventName eventName, params object[] args)
    {
        if (eventName == EventName.NULL)
        {
            return;
        }

        if (listeners.ContainsKey(channel))
        {
            listeners[channel].ForEach(listener => listener.EventHappened(eventName, args));
        }
    }
    public static void Register(Channel channel, IEventListener listener)
    {
        if (!listeners.ContainsKey(channel))
        {
            listeners.Add(channel, new List<IEventListener>());
        }

        if (!listeners[channel].Contains(listener))
        {
            listeners[channel].Add(listener);
        }
    }
    public static void UnRegister(Channel channel, IEventListener listener)
    {
        if (listeners.ContainsKey(channel) && listeners[channel].Contains(listener))
        {
            listeners[channel].Remove(listener);
        }
    }
}
public interface IEventListener
{
    void EventHappened(EventName eventName, params object[] args);
}
