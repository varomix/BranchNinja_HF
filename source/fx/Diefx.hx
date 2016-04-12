package fx;

import flixel.FlxSprite;

class Diefx extends FlxSprite {

	public function new(X:Float, Y:Float)
	{
		super(X,Y);

		loadGraphic("assets/images/fx/dieExplosion.png", true, 150, 150);

	    animation.add("explode", [0,1,2,3,4,5,6,7], 15, false);

	    animation.play("explode");


	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if(animation.finished) this.destroy();
	}
	
}