package;

import entities.Shuriken;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import entities.Player;

class PlayState extends FlxState
{
	var player:Player;
	var shuriken:Shuriken;

	override public function create():Void
	{
		super.create();

		player = new Player();
		add(player);

		shuriken = new Shuriken(0,0);
		add(shuriken);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);


		if (FlxG.mouse._middleButton.justPressed)
	    {
	    	trace("mouse pressed here ");
	    	FlxG.switchState( new PlayState());
	    }
	}
}
