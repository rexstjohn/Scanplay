using UnityEngine;
using System.Collections;

public class AlienController : MonoBehaviour {

	public float alienSpeed = .02f;
	
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () { 
		transform.position += new Vector3(0, -alienSpeed, 0);
	}
	
	void OnTriggerEnter2D(Collider2D col)
	{
		// If the alien hits the trigger...
		if (col.gameObject.tag == "Player") {
			Destroy (gameObject);
		} else if (col.gameObject.tag == "Terrain") {
			Destroy (gameObject);
		}
	}

}
