using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CoinManager : MonoBehaviour,IEventListener
{
    public Text CoinText;
    public int Coin;
    public int CoinThisRound;
    void Start()
    {
        EventManager.Register(Channel.Game, this);
        Coin = GetCoin();
        WriteTextCoin();
    }
    public int GetCoin() {
        return PlayerPrefs.GetInt("Coin");
    }
    public void SaveCoin() {
        PlayerPrefs.SetInt("Coin",Coin);
        WriteTextCoin();
    }
    public void WriteTextCoin() {
        CoinText.text = Coin.ToString();
    }
    public void EventHappened(EventName eventName, params object[] args)
    {
        if (eventName == EventName.Coin) {
            Coin++;
            CoinThisRound++;
            SaveCoin();

        }
    }
}
