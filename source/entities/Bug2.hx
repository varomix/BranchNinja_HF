package entities;

import flixel.FlxG;
import flixel.FlxSprite;

class Bug2 extends FlxSprite {
	
	public function new(X:Float=0, Y:Float=0)
	{
	    super(X, Y);

	    loadGraphic("assets/images/enemies/bug2.png", true, 48, 48);

	    animation.add("walk", [2,6,10,14], 10, true);

	    animation.play("walk");

	    health = 50;

	    width = 10;
	    offset.x = 11;
	    velocity.x = -15;

	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		// destroy enemy if we go out on the left
		if(((this.x + 30) - FlxG.camera.scroll.x) < 0)
		{
			 this.kill();
		}
	}
	
}