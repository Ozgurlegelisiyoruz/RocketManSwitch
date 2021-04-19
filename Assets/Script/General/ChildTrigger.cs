using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChildTrigger : MonoBehaviour
{
    
    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "BonusCube")
        {
            GetComponent<Rigidbody>().velocity = Vector3.zero;
            GetComponent<Rigidbody>().isKinematic = true;
        }
        this.transform.parent.GetComponent<CharacterController>().OntriggerGetChild(other);
     
    }
}
