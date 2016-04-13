package fx;

import flixel.FlxSprite;

class Pickupfx extends FlxSprite {

	public function new(X:Float, Y:Float)
	{
		super(X,Y);

		loadGraphic("assets/images/fx/3.png", true, 36, 36);

	    animation.add("pickup", [0,1,2,3,4,5,6], 15, false);

	    animation.play("pickup");


	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if(animation.finished) this.destroy();
	}
	
}