#pragma strict

var spacer : int = 8;
var barHeight : int = 32;
var tiles : Tile[]; // home-made class. see the end of script.
var springSpeed : float = 5.0; 
var throwSpeed : float = 8.0;

private var tileSize : int;
private var screenWidth : int = Screen.width;
private var screenHeight : int = Screen.height;
private var slidePosition : Vector3;
private var maxSlidePosition : Vector3;
private var oldMousePosition : Vector3;
private var throwPosition : Vector3;

function Start () {
    // in a real senario maybe this is dynamically created from a database. for now, here are some blanks.
    tiles = [new Tile(), new Tile(),new Tile(),
         new Tile(), new Tile(), new Tile(),
         new Tile(), new Tile(), new Tile(),
         new Tile(), new Tile(), new Tile(),
         new Tile(), new Tile(), new Tile(),
         new Tile(), new Tile(), new Tile(),
         new Tile(), new Tile(), new Tile(),
         new Tile(), new Tile(), new Tile(),
         new Tile(), new Tile()];
    oldMousePosition = Input.mousePosition;
}

function Update () {
    if (!Input.anyKey) {
       if (slidePosition.x > 0){
           slidePosition = Vector3.Slerp(slidePosition, Vector3(0,0,0), Time.deltaTime * springSpeed);
        }
        else if (slidePosition.x < maxSlidePosition.x) {
           slidePosition = Vector3.Slerp(slidePosition, maxSlidePosition, Time.deltaTime * springSpeed);
        } 
        else {
            slidePosition = Vector3.Slerp(slidePosition, throwPosition, Time.deltaTime * springSpeed);
        }
        oldMousePosition = Input.mousePosition;
    }

    if (Input.GetButton ("Fire1")) {
        slidePosition.x += Input.mousePosition.x - oldMousePosition.x;
        throwPosition = Vector3(slidePosition.x+throwSpeed*(Input.mousePosition.x-oldMousePosition.x),0,0);
        oldMousePosition = Input.mousePosition;
    }
}

function OnGUI () {
    screenWidth = Screen.width;
    screenHeight = Screen.height;
    tileSize = (screenHeight-barHeight-(spacer*4))/3;

    var xMax : int = Mathf.CeilToInt(tiles.length/3.0f);
    maxSlidePosition.x = -spacer*(xMax+1)-tileSize*(xMax)+screenWidth;

    for (var i=0; i<tiles.length; i++){
       var position : float = i+1;
       var xGridPosition : int = Mathf.CeilToInt(position/3.0f);
       var yGridPosition : int = position - (xGridPosition-1)*3;
       var rect : Rect = new Rect(spacer*xGridPosition+tileSize*(xGridPosition-1)+slidePosition.x, spacer*yGridPosition+tileSize*(yGridPosition-1), tileSize, tileSize);
       var tile : Tile = tiles[i];
       GUI.Box(rect, tile.name);
    }
    GUI.Box(Rect(0, screenHeight-barHeight, screenWidth, barHeight), "Bottom Bar");
}

class Tile {
    var name : String = "name";
    var texture : Texture2D;
}