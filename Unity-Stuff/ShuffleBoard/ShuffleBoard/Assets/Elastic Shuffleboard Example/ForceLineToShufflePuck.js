
var puck : GameObject;

function Start()
{

}

function Update() {
	
		var mousePos = new Vector3(Input.mousePosition.x,Input.mousePosition.y,0);
	    var a = Camera.main.ScreenToWorldPoint(mousePos);
	    a.z = 0;
    Debug.DrawLine (a, Vector3 (1, 1, 1), Color.red);
}
