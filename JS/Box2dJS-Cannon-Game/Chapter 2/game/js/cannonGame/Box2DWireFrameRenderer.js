// Class for use when performing wire frame rendering of box2d objects.
function Box2dWireFrameRenderer(){}

// Color of the wireframe we wish to draw.
Box2dWireFrameRenderer.WIRE_FRAME_COLOR  = '#ffffff';
	
// Static method to call in order to draw a wireframe of all the physics object in the game world.
Box2dWireFrameRenderer.drawWireFrame = function(_world, _context) {

	// Loop through the physics shapes in the world and draw all of them.
	for (var bodyList = _world.m_bodyList; bodyList; bodyList = bodyList.m_next) {
	
		// Once we find a body, get all the shapes attached to that body and outline them.
		for (var shape = bodyList.GetShapeList(); shape != null; shape = shape.GetNext()) {
			Box2dWireFrameRenderer.drawShape(shape, _context);
		}
	}
}

// Draw each shape's outline.
Box2dWireFrameRenderer.drawShape = function(_shape, _context) {

	// Start a stroke path.
	_context.strokeStyle = Box2dWireFrameRenderer.WIRE_FRAME_COLOR;
	_context.beginPath();

	// Determine how to best outline the shape we have next in our list.
	switch (_shape.m_type) {
	
		case b2Shape.e_circleShape:{
		
			// We got a circle here.
			var circle = _shape;
			var pos = circle.m_position;
			var r = circle.m_radius;
			var segments = 16.0;
			var theta = 0.0;
			var dtheta = 2.0 * Math.PI / segments;

			// draw circle
			_context.moveTo(pos.x + r, pos.y);

			for (var i = 0; i < segments; i++) {

				var d = new b2Vec2(r * Math.cos(theta), r * Math.sin(theta));
				var v = b2Math.AddVV(pos, d);
				_context.lineTo(v.x, v.y);
				theta += dtheta;
			}

			_context.lineTo(pos.x + r, pos.y);

			// draw radius
			_context.moveTo(pos.x, pos.y);
			var ax = circle.m_R.col1;
			var pos2 = new b2Vec2(pos.x + r * ax.x, pos.y + r * ax.y);
			_context.lineTo(pos2.x, pos2.y);
		}
		break;
		case b2Shape.e_polyShape:{
		
			// We got a polygon shape here, often a box.
			var poly = _shape;
			var tV = b2Math.AddVV(poly.m_position, b2Math.b2MulMV(poly.m_R, poly.m_vertices[0]));
			_context.moveTo(tV.x, tV.y);
	
			// Trace all the lines for this polygon.
			for (var i = 0; i < poly.m_vertexCount; i++) {
			
				var v = b2Math.AddVV(poly.m_position, b2Math.b2MulMV(poly.m_R, poly.m_vertices[i]));
				_context.lineTo(v.x, v.y);
			}
	
			_context.lineTo(tV.x, tV.y);
		}
		break;
	}

	// Draw it!
	_context.stroke();
}