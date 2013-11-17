var distance:float;
var player:GameObject;

function Update ()
{
	var mainCamera = FindCamera();
		
	// We need to actually hit an object
	var hit : RaycastHit;
	if (!Physics.Raycast(mainCamera.ScreenPointToRay(Input.mousePosition),  hit, 10000))
		return;
		
		
	// We need to hit a rigidbody that is not kinematic
	if (!hit.rigidbody || hit.rigidbody.isKinematic)
		return;
	
	
	//find the angle
    
    var tx = hit.point.x;
    var tz = hit.point.z;
	var px:float = player.transform.position.x;
	var py:float = player.transform.position.y;
	var pz:float = player.transform.position.z;
	
    var dx = tx - px;
    var dz = tz - pz;
    
    var angle = Mathf.Atan2(dz,dx);
    
    Debug.DrawLine ( player.transform.position, new Vector3(px,0,tz), Color.red ); 
    Debug.DrawLine ( player.transform.position, new Vector3(tx,0,pz), Color.yellow ); 
    Debug.DrawLine ( player.transform.position, new Vector3(tx,0,tz), Color.green ); 
    
    var force:Vector3 = new Vector3(3*Mathf.Cos(angle),0,3*Mathf.Sin(angle));
    
    if(Input.GetMouseButtonDown(0)){
    	player.rigidbody.AddForce(force,ForceMode.Impulse);
	}
}

function FindCamera ()
{
	if (camera)
		return camera;
	else
		return Camera.main;
}