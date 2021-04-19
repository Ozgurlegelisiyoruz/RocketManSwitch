using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class Controller : MonoBehaviour, IEventListener
{
    public GameObject failPanel;
    public GameObject startPanel;
    public GameObject barProgress;
    public Image WarningPanel;
    public List<SelectBonusXList> selectBonus;
    public int BonusCounter;
    public Material selectMat;
    public GameObject winPanel;
    public GameObject cameraIconObject;
    void Awake()
    {
        EventManager.Register(Channel.Game, this);
        Application.targetFrameRate = 60;
        Screen.sleepTimeout = SleepTimeout.NeverSleep;
    }
    public void StartGameButton() {
        EventManager.PublishEvent(Channel.Game, EventName.StartGame);
        startPanel.SetActive(false);
    }
    Coroutine courtine;
    public Text winCoinText;
    public void EventHappened(EventName eventName, params object[] args)
    {
        if (eventName == EventName.FinishGame) {
            failPanel.SetActive(true);
            LeanTween.scale(failPanel, new Vector3(1, 1, 1), 0.4f).setEaseInOutBack();
        }
        if (eventName == EventName.StartWarningAnim) {
            LeanTween.value(0, 0.5f, 0.3f).setOnUpdate((float val) =>
            {
                WarningPanel.color = new Color(WarningPanel.color.r, WarningPanel.color.g, WarningPanel.color.b, val);
            }).setOnComplete(() => {
                LeanTween.value(0.5f, 0, 0.3f).setOnUpdate((float vals) =>
                {
                    WarningPanel.color = new Color(WarningPanel.color.r, WarningPanel.color.g, WarningPanel.color.b, vals);
                });
            });
        }
        if (eventName == EventName.StartGame) {
            cameraIconObject.SetActive(false);
        }
        if (eventName == EventName.SelectBonus) {
            Destroy(selectBonus[BonusCounter].SelectedTransparent);
            ChangeMat(selectBonus[BonusCounter].mesh);
            BonusCounter++;
        }
        if (eventName == EventName.Win) {
            StartCoroutine(waitAndOpenWinPanel());
        }
    }
    public GameObject targetOneCam, targetTwoCam;
    public GameObject CameraObject;
    public bool MoveCam;
    public void ChangeCameraPosition(float duraciton) {

        if (!MoveCam) {
            LeanTween.cancel(CameraObject);
            LeanTween.move(CameraObject, targetTwoCam.transform.position, duraciton);
            LeanTween.rotate(CameraObject, targetTwoCam.transform.eulerAngles, duraciton);
            MoveCam = true;
        }
        else {
            LeanTween.cancel(CameraObject);
            LeanTween.move(CameraObject, targetOneCam.transform.position, duraciton);
            LeanTween.rotate(CameraObject, targetOneCam.transform.eulerAngles, duraciton);
            MoveCam = false;
        }
    }
    public GameObject settingsPanelObje;
    public FlexibleColorPicker colorone, colortwo, colorthree;
    public Material colorMatOne, colorMatTwo, colorMatThree;
    public Material colorMatOneT, colorMatTwoT, colorMatThreeT;
    public void OpenSettingsPanel() {
        settingsPanelObje.SetActive(true);
    }
    public void OffSettingsPanel() {
        colorMatOne.color = colorone.color;
        colorMatTwo.color = colortwo.color;
        colorMatThree.color = colorthree.color;
        colorMatOneT.color = new Color(colorone.color.r, colorone.color.g, colorone.color.b,0.85f);
        colorMatTwoT.color = new Color(colortwo.color.r, colortwo.color.g, colortwo.color.b, 0.85f);
        colorMatThreeT.color = new Color(colorthree.color.r, colorthree.color.g, colorthree.color.b, 0.85f);
        settingsPanelObje.SetActive(false);
    }
    IEnumerator waitAndOpenWinPanel() {
        yield return new WaitForSeconds(1);
        winPanel.SetActive(true);
        LeanTween.scale(winPanel, new Vector3(0.75f, 0.75f, 0.75f), 0.3f).setEaseInExpo();
        winCoinText.text = "You have won: " + GetComponent<CoinManager>().CoinThisRound.ToString() + " * x" + selectBonus[BonusCounter - 1].Bonus.ToString()  + " coins.";
        GetComponent<CoinManager>().Coin = GetComponent<CoinManager>().Coin - GetComponent<CoinManager>().CoinThisRound;
        GetComponent<CoinManager>().CoinThisRound = GetComponent<CoinManager>().CoinThisRound * selectBonus[BonusCounter].Bonus;
        GetComponent<CoinManager>().Coin += GetComponent<CoinManager>().CoinThisRound;
        GetComponent<CoinManager>().SaveCoin();
    }
    public void ChangeMat(MeshRenderer mesh) {
        Material startMat = mesh.material;
        if (courtine != null)
        {
            StopCoroutine(courtine);
            TimeColorPlatformSwitch = 0;
        }
        courtine = StartCoroutine(changeColorMeshPlatform(startMat, mesh));
    }
    int TimeColorPlatformSwitch;
    public IEnumerator changeColorMeshPlatform(Material startMat,MeshRenderer mesh) {
        mesh.material = selectMat;
        yield return new WaitForSeconds(0.1f);
        mesh.material = startMat;
        yield return new WaitForSeconds(0.1f);
        if (TimeColorPlatformSwitch > 3)
        {
            courtine = null;
            TimeColorPlatformSwitch = 0;
        }
        else {
            StartCoroutine(changeColorMeshPlatform(startMat, mesh));
            TimeColorPlatformSwitch++;
        }
    }
    public void RestartGame() {
        EventManager.Clean();
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }
}
[SerializeField]
public static class Vibrator {
#if UNITY_ANDROID && !UNITY_EDITOR
    public static AndroidJavaClass unityPlayer = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
    public static AndroidJavaObject currentActivity = unityPlayer.GetStatic<AndroidJavaObject>("currentActivity");
    public static AndroidJavaObject vibrator = currentActivity.Call<AndroidJavaObject>("getSystemService", "vibrator");
#else
    public static AndroidJavaClass unityPlayer;
    public static AndroidJavaObject currentActivity;
    public static AndroidJavaObject vibrator;
#endif

    public static void Vibrate()
    {
        if (isAndroid())
            vibrator.Call("vibrate");
        else
            Handheld.Vibrate();
    }


    public static void Vibrate(long milliseconds)
    {
        if (isAndroid())
            vibrator.Call("vibrate", milliseconds);
        else
            Handheld.Vibrate();
    }

    public static void Vibrate(long[] pattern, int repeat)
    {
        if (isAndroid())
            vibrator.Call("vibrate", pattern, repeat);
        else
            Handheld.Vibrate();
    }

    public static bool HasVibrator()
    {
        return isAndroid();
    }

    public static void Cancel()
    {
        if (isAndroid())
            vibrator.Call("cancel");
    }

    private static bool isAndroid()
    {
#if UNITY_ANDROID && !UNITY_EDITOR
	return true;
#else
        return false;
#endif
    }
}
[System.Serializable]
public class SelectBonusXList {
    public GameObject SelectedTransparent;
    public MeshRenderer mesh;
    public int Bonus;
    public SelectBonusXList(GameObject selectedTransparent, MeshRenderer mesh,int bonus)
    {
        SelectedTransparent = selectedTransparent;
        this.mesh = mesh;
        Bonus = bonus;
    }
}
