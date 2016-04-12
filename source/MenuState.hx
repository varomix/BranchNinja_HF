package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var logo:FlxSprite;

	override public function create():Void
	{
		super.create();

		logo = new FlxSprite(0,0, "assets/images/hud/BranchNinja_LOGO_v01.png");
		logo.screenCenter();
		logo.y -= 30;
		add(logo);

		var clickTxt = new FlxText(0,230, FlxG.width, "CLICK TO PLAY", 32);
		clickTxt.setFormat("assets/data/bitlow.ttf", 32, FlxColor.WHITE, FlxTextAlign.CENTER);
		add(clickTxt);

		var instructionTxt = new FlxText(0,280, FlxG.width, "USE ARROWS TO JUMP UP AND DOWN, CTRL TO SHOOT", 16);
		instructionTxt.setFormat("assets/data/bitlow.ttf", 16, FlxColor.WHITE, FlxTextAlign.CENTER);
		add(instructionTxt);



	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed)
	    {
	    	trace("mouse pressed here ");
	    	FlxG.switchState( new PlayState());
	    }
	}
}
