package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;


class MenuState extends FlxState
{
	var logo:FlxSprite;
	var shurikenIntro:FlxSprite;

	override public function create():Void
	{
		super.create();
		FlxG.sound.playMusic("main_theme");
		FlxG.sound.music.fadeIn(5, 0, 0.4);
		FlxG.sound.music.volume = 0.4;

		FlxG.camera.fade(FlxColor.BLACK, 0.5, true);

		shurikenIntro = new FlxSprite("assets/images/hud/shurikenIntro.png");


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

		add(shurikenIntro);
		shurikenIntro.x = -400;

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed)
	    {
	    	FlxG.sound.music.stop();
	    	FlxG.sound.play("wooshintro_snd");
	    	FlxG.camera.shake(0.07, 0.1);
	    	FlxTween.tween(shurikenIntro, {x:340, y: 20}, 0.1);
	    	FlxG.camera.flash(FlxColor.WHITE, 0.1);
			FlxG.camera.fade(FlxColor.BLACK, 0.5, false);

	    	new FlxTimer().start(1.3, function(_) FlxG.switchState( new PlayState()));

	    }
	}
}
