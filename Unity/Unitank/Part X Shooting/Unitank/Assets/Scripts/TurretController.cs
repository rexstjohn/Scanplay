using UnityEngine;
using System.Collections;

public class TurretController : MonoBehaviour {

	private Vector3 mouse_pos;
	private Vector3 object_pos;
	private float angle;
	private float bulletSpeed = 500;
	public GameObject[] ammo;		// Array of enemy prefabs.

	// Use this for initialization
	void Start () {
	}

	void Update(){ 
	}

	void FixedUpdate () {    
		// Point the cannon at the mouse.
		mouse_pos = Input.mousePosition;
		mouse_pos.z = 0.0f; 
		object_pos = Camera.main.WorldToScreenPoint(transform.position);
		mouse_pos.x = mouse_pos.x - object_pos.x;
		mouse_pos.y = mouse_pos.y - object_pos.y;
		angle = Mathf.Atan2(mouse_pos.y, mouse_pos.x) * Mathf.Rad2Deg - 90;
		Vector3 rotationVector = new Vector3 (0, 0, angle);
		transform.rotation = Quaternion.Euler(rotationVector);

		// Fire a bullet.
		if(Input.GetMouseButtonDown(0)){
			int ammoIndex = 0; 
			GameObject bullet = (GameObject)Instantiate(ammo[ammoIndex], transform.position, transform.rotation);
			bullet.transform.LookAt(mouse_pos);
			bullet.rigidbody2D.AddForce(bullet.transform.forward * bulletSpeed);
		}
	}
}
