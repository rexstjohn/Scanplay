

/********Main Object***********/
var targetItem : GameObject;

//Dragging limits

var horizontalLimit : float = 2.5;
var verticalLimit : float = 2.5;



private var scrollDistanceX : float;
private var scrollDistanceY : float;


private var hit: RaycastHit;
private var layerMask = (1 <<  8) | (1 << 2);



function Start()
{

	
	
	scrollDistanceX = targetItem.transform.position.x;
	scrollDistanceY = targetItem.transform.position.y;
	layerMask =~ layerMask;
	
	
}




function FixedUpdate()
{
	
	if (Input.touchCount > 0) 
	{		//	If there are touches...
			var theTouch : Touch = Input.GetTouch (0);		//	Cache Touch (0)
			
			var ray = Camera.main.ScreenPointToRay(theTouch.position);
			
			
				
         	if(Physics.Raycast(ray,hit,50,layerMask))
         	{			
         			
         				if(Input.touchCount == 1)
						{
							
							
											
							var scrollDeltaX = theTouch.deltaPosition.x;
							var scrollDeltaY = theTouch.deltaPosition.y;
				
							
							scrollDistanceX = Mathf.Clamp(scrollDistanceX+scrollDeltaX*Time.deltaTime*.5,-horizontalLimit,horizontalLimit);
							scrollDistanceY = Mathf.Clamp(scrollDistanceY+scrollDeltaY*Time.deltaTime*.5,-verticalLimit,verticalLimit);
							
							
							
							targetItem.transform.position.x = scrollDistanceX;
							targetItem.transform.position.y = scrollDistanceY;
							

						}
         				 	
				
			}


			
						
			
	}
	
}