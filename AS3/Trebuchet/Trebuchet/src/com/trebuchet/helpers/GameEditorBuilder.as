package com.trebuchet.helpers
{
	import com.core.util.GraphicsUtils;
	import com.core.util.SuperSprite;
	import com.physics.PhysicsContext;
	
	public class GameEditorBuilder
	{
		private var _canvas:SuperSprite;
		private var _physicsContext:PhysicsContext;

		public function GameEditorBuilder(_canvas:SuperSprite, _physicsContext:PhysicsContext)
		{
			this._canvas = _canvas;
			this._physicsContext = _physicsContext;
		}
		
	}
}