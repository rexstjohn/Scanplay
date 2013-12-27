using UnityEngine;
using System.Collections;

public class AlienController : MonoBehaviour {

	public float alienSpeed = .02f;
	private ScoreController score;
	
	// Use this for initialization
	void Start () { 
		score = GameObject.Find("Score").GetComponent<ScoreController>();
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

			if(score.score >= 100)
				score.score -= 100;
			else if(score.score > 0)
				score.score = 0;

		} else if (col.gameObject.tag == "Terrain") {
			score.score += 100;
			Destroy (gameObject);
		}else if (col.gameObject.tag == "Pew") {
			score.score += 100;
			Destroy (gameObject);
		}
	}

}
