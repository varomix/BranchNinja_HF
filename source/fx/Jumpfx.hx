package fx;

import flixel.FlxSprite;

class Jumpfx extends FlxSprite {

	public function new(X:Float, Y:Float)
	{
		super(X,Y);

		loadGraphic("assets/images/fx/jumpfx.png", true, 36, 36);

	    animation.add("jump", [0,1,2,3,4], 15, false);

	    animation.play("jump");


	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if(animation.finished) this.destroy();
	}
	
}