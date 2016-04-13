package fx;

import flixel.FlxSprite;

class EnemyExplode extends FlxSprite {

	public function new(X:Float, Y:Float)
	{
		super(X,Y);

		loadGraphic("assets/images/fx/explosion.png", true, 36, 36);

	    animation.add("explode", [0,1,2,3,4,5], 15, false);

	    animation.play("explode");


	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if(animation.finished) this.destroy();
	}
	
}