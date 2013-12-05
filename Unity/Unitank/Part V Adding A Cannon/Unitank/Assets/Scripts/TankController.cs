using UnityEngine;
using System.Collections;

public class TankController : MonoBehaviour {

	[HideInInspector]
	public bool jump = false;				// Condition for whether the player should jump.

	public float moveForce = 10f;			// Amount of force added to move the player left and right.
	public float maxSpeed = 0.5f;				// The fastest the player can travel in the x axis.
	public float jumpForce = 50000f;			// Amount of force added when the player jumps.

	private Transform groundDetector;		// A position marking where to check if the player is grounded.
	private Transform shell;
	private Transform tank;
	private bool grounded = false;			// Whether or not the player is grounded.
	
	void Awake()
	{
		// Setting up references.
		groundDetector = transform.Find("GroundDetector");
		shell = transform.Find ("/Tank/Shell");
		tank = transform.Find ("/Tank");
	}

	void Update()
	{
		// The player is grounded if a linecast to the groundcheck position hits anything on the ground layer.
		grounded = Physics2D.Linecast(transform.position, groundDetector.position, 1 << LayerMask.NameToLayer("Terrain"));  

		// If the jump button is pressed and the player is grounded then the player should jump.
		if(Input.GetButtonDown("Jump") && grounded)
			jump = true;
	}
	
	void FixedUpdate ()
	{

		// Cache the horizontal input.
		float h = Input.GetAxis("Horizontal");
		
		// If the player is changing direction (h has a different sign to velocity.x) or hasn't reached maxSpeed yet...
		if(h * rigidbody2D.velocity.x < maxSpeed)
			// ... add a force to the player.
			rigidbody2D.AddForce(Vector2.right * h * moveForce);
		
		// If the player's horizontal velocity is greater than the maxSpeed...
		if(Mathf.Abs(rigidbody2D.velocity.x) > maxSpeed)
			// ... set the player's velocity to the maxSpeed in the x axis.
			rigidbody2D.velocity = new Vector2(Mathf.Sign(rigidbody2D.velocity.x) * maxSpeed, rigidbody2D.velocity.y);
		
		// If the player should jump...
		if(jump)
		{	
			// Add a vertical force to the player.
			rigidbody2D.AddForce(new Vector2(0f, jumpForce));
			
			// Make sure the player can't jump again until the jump conditions from Update are satisfied.
			jump = false;
		}
	}
}
