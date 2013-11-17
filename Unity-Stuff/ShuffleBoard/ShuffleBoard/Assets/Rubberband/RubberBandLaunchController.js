var spring = 50.0;
var damper = 5.0;
var drag = 90.0;
var angularDrag = 5.0;
var attachToCenterOfMass = false;
var player : GameObject;
var groundBody : GameObject;
var startPoint:Vector3;

var force;
var distance;
var angle;
var puckReleased:boolean = true;

private var springJoint : SpringJoint;

function Start() 
{
	startPoint = player.rigidbody.position;
}
function Update ()
{
    Debug.DrawLine ( player.transform.position, startPoint, Color.green ); 
    
    var mouseDown:boolean = Input.GetMouseButton (0);
    
    if(mouseDown == false && puckReleased == false)
    {
    	LaunchPuck();
    }
    else
		StartCoroutine ("DragObject");
}

function DragObject ()
{
	while (Input.GetMouseButton (0))
	{
		var hit : RaycastHit;
		if (!Physics.Raycast(FindCamera().ScreenPointToRay(Input.mousePosition),  hit, 1000))
			return;
			
		if(hit.collider.gameObject.tag != "GroundBody")
			return;
			
		puckReleased = false;
		hit.point.y = 6.9;//force the selected object to be off the ground
		hit.point.z += 2;
		player.transform.position = hit.point;
	 	player.rigidbody.velocity = Vector3.zero;
	 	Debug.Log("execute");
		yield;
	}
}
function OnMouseUp()
{
	LaunchPuck();
}

function LaunchPuck()
{
	 player.rigidbody.velocity = Vector3.zero;
	 angle = Vector3.Angle(startPoint, player.transform.position) * Mathf.Deg2Rad;	
	 distance = Vector3.Distance(startPoint, player.transform.position);
	 force = distance * distance;
	 var dx = startPoint.x - player.transform.position.x;
	 var dz = startPoint.z - player.transform.position.z;
	 angle = Mathf.Atan2(dz,dx);
	 player.rigidbody.AddForce(new Vector3(Mathf.Cos(angle) * force,0, Mathf.Sin(angle) *force), ForceMode.Impulse);
	 Debug.Log(angle);
	 Debug.Log(force);
	 puckReleased = true;
}

function FindCamera ()
{
	if (camera)
		return camera;
	else
		return Camera.main;
}