// This complete script can be attached to a camera to make it 
// continuously point at another object.

// The target variable shows up as a property in the inspector. 
// Drag another object onto it to make the camera look at it.
var target : Transform; 

// Rotate the camera every frame so it keeps looking at the target 
function Update() {
    transform.LookAt(target);
}