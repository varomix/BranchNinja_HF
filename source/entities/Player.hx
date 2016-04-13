package entities;

import flixel.FlxSprite;

class Player extends FlxSprite {
	
	public function new(X:Float=0, Y:Float=0)
	{
	    super(X, Y);

	    loadGraphic("assets/images/ninjaBlack.png", true, 36, 36);

	    animation.add("walk", [12,13,14,15], 12, true);
	    animation.add("hitAnim", [24,25,26,27], 12, true);
	    animation.add("win", [17,18,19,20], 6, true);
	    animation.add("shoot", [23]);

	    width = 14;
	    offset.x = 11;

	    health = 100;

	    animation.play("walk");
	    velocity.x = 150;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
	}
	
}