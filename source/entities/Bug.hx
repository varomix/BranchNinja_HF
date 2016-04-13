package entities;

import flixel.FlxG;
import flixel.FlxSprite;

class Bug extends FlxSprite {
	
	public function new(X:Float=0, Y:Float=0)
	{
	    super(X, Y);

	    loadGraphic("assets/images/enemies/bug.png", true, 36, 36);

	    animation.add("walk", [0,1,2,3], 12, true);

	    animation.play("walk");

	    width = 10;
	    offset.x = 11;
	    velocity.x = -80;

	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		// FlxG.watch.add(this, "x");
		// FlxG.watch.add(FlxG.camera.scroll, "x");

		if(((this.x + 30) - FlxG.camera.scroll.x) < 0)
		{
			 this.kill();
		}
		
	}
	
}