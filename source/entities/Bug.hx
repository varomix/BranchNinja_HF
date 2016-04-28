package entities;

import flixel.FlxG;
import flixel.FlxSprite;

class Bug extends FlxSprite {
	
	public function new(X:Float=0, Y:Float=0)
	{
	    super(X, Y);

	    loadGraphic("assets/images/enemies/bug.png", true, 30, 30);

	    animation.add("walk", [0,1,2,3], 12, true);

	    animation.play("walk");

	    health = 25;

	    width = 10;
	    offset.x = 11;
	    velocity.x = -50;

	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if(((this.x + 30) - FlxG.camera.scroll.x) < 0)
		{
			 this.kill();
		}
	}
	
}