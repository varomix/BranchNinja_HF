package entities;

import entities.Shuriken;
import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite {
	
	public var _stopAnimations = false;

	public function new(X:Float=0, Y:Float=0)
	{
	    super(X, Y);

	    loadGraphic("assets/images/ninjaBlack.png", true, 36, 36);

	    animation.add("walk", [12,13,14,15], 12, true);
	    animation.add("hitAnim", [24,25,26,27], 12, true);
	    animation.add("shoot", [23]);

	    width = 14;
	    offset.x = 11;

	    animation.play("walk");
	    velocity.x = 130;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (FlxG.keys.justPressed.UP && y > 36) 
		{
			y -= 72;

		} 
		else if (FlxG.keys.justPressed.DOWN && y < 252)
		{
			y += 72;
		}



		
	}
	
}