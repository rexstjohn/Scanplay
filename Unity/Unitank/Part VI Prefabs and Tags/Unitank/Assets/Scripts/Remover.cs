using UnityEngine;
using System.Collections;

public class Remover : MonoBehaviour {


	// Use this for initialization
	void Start () {  
	}
	
	// Update is called once per frame
	void Update () {
		transform.rigidbody.constraints =  RigidbodyConstraints.FreezeAll;
	}

	void OnTriggerEnter2D(Collider2D col)
	{
		// If the alien hits the trigger...
		if(col.gameObject.tag == "Alien")
		{
			Destroy (col.gameObject);
		}
	}
}
