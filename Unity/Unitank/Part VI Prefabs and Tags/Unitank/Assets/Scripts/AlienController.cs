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
}
