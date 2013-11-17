var speed:float;
var _transform:Transform;

function Update () {
        // Only if there are touches
        if (Input.touches.Length > 0)
        {
            // Only work with the first touch
            // and only if the touch moved since last update
            if (Input.touches[0].phase == TouchPhase.Moved)
            {
                var x = Input.touches[0].deltaPosition.x * speed * Time.deltaTime;
                var y = Input.touches[0].deltaPosition.y * speed * Time.deltaTime;

                _transform.Translate(new Vector3(x, y, 0));
            }
        }
}