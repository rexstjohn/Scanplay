// Prints number of fingers touching the screen
function Update () {
    var fingerCount = 0;
    for (var touch : Touch in Input.touches) {
        if (touch.phase != TouchPhase.Ended && touch.phase != TouchPhase.Canceled)
            fingerCount++;
    }
    if (fingerCount > 0)
        print ("User has " + fingerCount + " finger(s) touching the screen");
}