
var  c1:Color = Color.yellow;
var  c2:Color = Color.red;
var player:GameObject;
private var positions:ArrayList = new ArrayList(2);
private var pullForce:Vector3; // how strong and in what direction the pull force of the mouse is
private var distance:float;
private var angle:float;
private var impulseForceDirection:Vector3;

function Start(){

     var lineRenderer : LineRenderer = gameObject.AddComponent(LineRenderer);
     lineRenderer.material = new Material (Shader.Find("Particles/Additive"));
     lineRenderer.SetColors(c1, c2);
     lineRenderer.SetWidth(0.2,0.2);
     lineRenderer.SetVertexCount(2);
     positions.Add(GetPuckCenter());
	 positions.Add(GetPuckCenter());
}

function Update() {

		//get the mouse position
	    var mousePos:Vector3=Input.mousePosition; 
	    mousePos.z = 1f;
	
		//convert it to a world point
		var worldPos:Vector3 = Camera.main.ScreenToWorldPoint(mousePos);
		
		//find the angle
	    var dx = ( worldPos.x);
	    var dz = ( worldPos.z);
	    angle = Mathf.Atan2(dz,dx);
	    
	    //lengthen the lines
    	var xForce = 2500 * Mathf.Cos(angle);
    	var zForce = 2500 * Mathf.Sin(angle);
    	
	   // Debug.DrawLine ( Vector3.zero, new Vector3(0f,0f,dz), Color.red ); 
	   // Debug.DrawLine ( Vector3.zero, new Vector3(dx,0f,0f), Color.yellow ); 
	   // Debug.DrawLine ( Vector3.zero, new Vector3(dx,0f,dz), Color.green ); 
	    //impulseForceDirection = new Vector3(dx,0f,dz);
	    
	    Debug.DrawLine ( Vector3.zero, new Vector3(0f,0f,dz), Color.red ); 
	    Debug.DrawLine ( Vector3.zero, new Vector3(dx,0f,0f), Color.yellow ); 
	    Debug.DrawLine ( Vector3.zero, new Vector3(dx,0f,dz), Color.green ); 
	    impulseForceDirection = new Vector3(dx,0f,dz);
	    distance = Vector3.Distance(player.rigidbody.position,impulseForceDirection);
	    
	    DrawLine();
}

function DrawLine()
{

	while(Input.GetMouseButton(0)){
    	var force = -150000;
	    var invertedForce:Vector3 = new Vector3(impulseForceDirection.x*force,impulseForceDirection.y,impulseForceDirection.z*force);
	    player.rigidbody.AddRelativeForce(invertedForce,ForceMode.Impulse);
	    print("x force component " + impulseForceDirection.x);
	    print("z force component " + impulseForceDirection.z);
	    print("distance force component " + distance);
	  
	    yield;
    }
}

function GetPuckCenter()
{
     return player.rigidbody.position;
}

function OnMouseDown()
{
   // if(Mathf.Abs(distance) > 0)
    //{
    /*
 		var lineRenderer = GetComponent(LineRenderer);
	    var angle:float  = Vector3.Angle(Vector3.zeroVector3.zero,positions[1]);
	    print("degrees " + angle);
	    angle = angle * Mathf.Deg2Rad;
	    print("rads " + angle);
	    lineRenderer.SetPosition(0,GetPuckCenter());
	    lineRenderer.SetPosition(1,GetPuckCenter());
	    
	    positions[0] = GetPuckCenter();
	    positions[1] = GetPuckCenter();
	    
    	var body = player.rigidbody;
    	var xForce = distance * Mathf.Sin(angle)* 5;
    	var zForce = distance * Mathf.Cos(angle) * 5;*/
    	
	   // var force : Vector3 = new Vector3(xForce,0,zForce);
	    /*
	    print("x force component " + xForce);
	    print("z force component " + zForce);
	    print("distance force component " + distance);*/
   // }
}