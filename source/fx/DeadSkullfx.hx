package fx;

import flixel.FlxSprite;

class DeadSkullfx  extends FlxSprite {

	public function new(X:Float, Y:Float)
	{
		super(X,Y);

		loadGraphic("assets/images/fx/die.png", true, 36, 36);

	    animation.add("deadskull", [0,1,2,3], 5, true);

	    animation.play("deadskull");
	}
}