using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartAgainPanel : MonoBehaviour
{
    public List<GameObject> objeTimeText;
    public GameObject noThanksUI;
    private void OnEnable()
    {
        StartCoroutine(startTimer());
    }
    private int Count;
    IEnumerator startTimer() {
        yield return new WaitForSeconds(1);
        Count++;
        foreach (GameObject item in objeTimeText)
        {
            item.SetActive(false);
        }
        if (Count < 3)
        {
            objeTimeText[Count].SetActive(true);
            StartCoroutine(startTimer());
        }
        else {
            LeanTween.scale(noThanksUI, new Vector3(1, 1, 1), 1).setEaseInCubic();
        }
    }
}
