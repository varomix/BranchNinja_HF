package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;

class Shuriken extends FlxSprite {

	public function new(X:Float, Y:Float)
	{
		super(X,Y);

		loadGraphic("assets/images/shuriken.png", false, 26, 26);

		velocity.x = 700;
		origin = new FlxPoint(13, 13);

		angularVelocity = 500;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		new FlxTimer().start(0.7, function(_) this.destroy());
		
	}
	
}