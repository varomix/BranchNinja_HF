package entities;

import flixel.FlxSprite;

class Health extends FlxSprite {

	public function new(X:Float, Y:Float)
	{
		super(X,Y);

		loadGraphic("assets/images/items/health.png", true, 36, 36);

	    animation.add("100", [0]);
	    animation.add("75", [1]);
	    animation.add("50", [2]);
	    animation.add("25", [3]);
	    animation.add("0", [4]);

	    animation.play("100");
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		switch (Reg.health) {
			case 100:
	    		animation.play("100");
	    	case 75:
	    		animation.play("75");
	    	case 50:
	    		animation.play("50");
	    	case 25:
	    		animation.play("25");
	    	case 0:
	    		animation.play("0");
		}

	}
	
}