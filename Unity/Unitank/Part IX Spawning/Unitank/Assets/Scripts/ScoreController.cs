using UnityEngine;
using System.Collections;

public class ScoreController : MonoBehaviour {

	public int score = 0;					// The player's score. 
	private int previousScore = 0;			// The score in the previous frame.
	
	void Awake ()
	{
	}
	
	void Update ()
	{
		// Set the score text.
		guiText.text = "Score: " + score;
		
		// Set the previous score to this frame's score.
		previousScore = score;
	}
}
