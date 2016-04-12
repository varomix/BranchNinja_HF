package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Shuriken extends FlxSprite {

	public function new(X:Float, Y:Float)
	{
		super(X,Y);

		loadGraphic("assets/images/shuriken.png", false, 26, 26);

		velocity.x = 700;
		origin = new FlxPoint(13, 13);

		angularVelocity = 500;

		// acceleration.x = 200;


	    
	}
	
}