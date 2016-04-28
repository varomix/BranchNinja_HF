package;

import entities.Health;
import entities.Player;
import entities.Shuriken;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;
import flixel.addons.editors.tiled.TiledImageLayer;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import fx.DeadSkullfx;
import fx.Diefx;
import fx.EnemyExplode;
import fx.Jumpfx;
import fx.Pickupfx;
import extension.share.Share;
import flixel.tweens.FlxTween;

using flixel.util.FlxSpriteUtil;


class PlayState extends FlxState
{
	public var commits:FlxText;
	public var commitsScore:FlxText;
	public var bugstxt:FlxText;
	public var bugsScore:FlxText;
	public var won_tryagain:FlxText;
	public var tryagain:FlxText;
	public var tryaganKeys:FlxText;
	public var tryagainBg:FlxSprite;
	public var won_tryagainbg:FlxSprite;

	public var health:Health;
	public var twitterBtn:FlxButton;

	public var level:TiledLevel;
	var player:Player;
	public var coins:FlxGroup;
	public var bugs:FlxGroup;
	public var floor:FlxGroup;
	public var exit:FlxSprite;
	public var items(default, null):FlxTypedGroup<FlxSprite>;
	private var _entities:FlxGroup;
	public var bugsKilled:Float = 0;

	public var damageable:Bool;
	public var won:Bool;

	private static var youDied:Bool = false;

	override public function create():Void
	{
		super.create();

		// SHARE
		Share.init(Share.TWITTER);
		Share.defaultURL = 'http://varomix.net/branchninja/';
		// Share.defaultSubject = "I killed a lot of bugs in Branch Ninja";

		// FlxG.debugger.drawDebug = true;
		FlxG.mouse.hideCursor();

		FlxG.sound.playMusic("menu_theme");
		FlxG.sound.music.volume = 0.4;
		FlxG.sound.volume = 0.5;

		FlxG.camera.fade(FlxColor.BLACK, 0.5, true);

		twitterBtn = new FlxButton(0,0, "", shareStuff);
		twitterBtn.loadGraphic("assets/images/hud/share.png");

		youDied = false;
		won = false;

		// game level
		coins = new FlxGroup();
		bugs = new FlxGroup();
		floor = new FlxGroup();
		level = new TiledLevel("assets/tiled/level1.tmx", this);

		var bg = new FlxSprite("assets/tiled/bg.png");
		bg.scrollFactor.set(0,0);
		add(bg);

		add(level.backgroundLayer);
		add(level.imagesLayer);

		add(floor);
		add(level.objectsLayer);
		add(level.foregroundTiles);
		
		add(bugs);
		add(coins);

		var textSize = 20;

		// Create UI
		health = new Health(44, -2);
		health.scrollFactor.set(0,0);
		add(health);

		var face = new FlxSprite("assets/images/blackFace.png");
		face.scrollFactor.set(0,0);
		add(face);

		commits = new FlxText(90, 5, 150);
		commits.setFormat("assets/data/bitlow.ttf", textSize, FlxColor.WHITE);
		commits.scrollFactor.set(0, 0); 
		commits.borderColor = 0xff000000;
		commits.text = "COMMITS:";
		add(commits);

		commitsScore = new FlxText(195, 5, 100);
		commitsScore.setFormat("assets/data/bitlow.ttf", textSize, FlxColor.PINK);
		commitsScore.scrollFactor.set(0, 0); 
		commitsScore.borderColor = 0xff000000;
		commitsScore.borderStyle = SHADOW;
		commitsScore.text = Std.string(coins.countDead());
		add(commitsScore);

		bugstxt = new FlxText(340, 5, 150);
		bugstxt.setFormat("assets/data/bitlow.ttf", textSize, FlxColor.WHITE);
		bugstxt.scrollFactor.set(0, 0); 
		bugstxt.borderColor = 0xff000000;
		bugstxt.borderStyle = SHADOW;
		bugstxt.text = "BUGS LEFT:";
		add(bugstxt);

		bugsScore = new FlxText(470, 5, 100);
		bugsScore.setFormat("assets/data/bitlow.ttf", textSize, FlxColor.PINK);
		bugsScore.scrollFactor.set(0, 0); 
		bugsScore.borderColor = 0xff000000;
		bugsScore.borderStyle = SHADOW;
		bugsScore.text = Std.string(bugs.countLiving());
		add(bugsScore);

		tryagainBg = new FlxSprite(0,0);
		tryagainBg.scrollFactor.set(0,0);
		tryagainBg.makeGraphic(FlxG.width, 65, FlxColor.BLACK);
		tryagainBg.visible = false;
		tryagainBg.screenCenter();
		tryagainBg.y -= 4;
		add(tryagainBg);
		
		won_tryagainbg = new FlxSprite(0,0);
		won_tryagainbg.scrollFactor.set(0,0);
		won_tryagainbg.makeGraphic(FlxG.width, 90, FlxColor.BLACK);
		won_tryagainbg.visible = false;
		won_tryagainbg.screenCenter();
		won_tryagainbg.y -= 4;
		add(won_tryagainbg);

		tryaganKeys = new FlxText(0, 0, FlxG.width);
		tryaganKeys.setFormat("assets/data/bitlow.ttf", 20, FlxColor.MAGENTA, FlxTextAlign.CENTER);
		tryaganKeys.scrollFactor.set(0, 0); 
		tryaganKeys.borderColor = 0xff000000;
		tryaganKeys.borderStyle = SHADOW;
		tryaganKeys.text = "CLICK OR\nENTER TO";
		tryaganKeys.screenCenter();
		tryaganKeys.x -= 150;
		tryaganKeys.visible = false;
		add(tryaganKeys);

		tryagain = new FlxText(0, 0, FlxG.width);
		tryagain.setFormat("assets/data/bitlow.ttf", 50, FlxColor.MAGENTA, FlxTextAlign.CENTER);
		tryagain.scrollFactor.set(0, 0); 
		tryagain.borderColor = 0xff000000;
		tryagain.borderStyle = SHADOW;
		tryagain.text = "TRY AGAIN!";
		tryagain.screenCenter();
		tryagain.x += 70;
		tryagain.visible = false;
		add(tryagain);


		won_tryagain = new FlxText(0, 0, FlxG.width);
		won_tryagain.setFormat("assets/data/bitlow.ttf", 20, FlxColor.MAGENTA, FlxTextAlign.CENTER);
		won_tryagain.scrollFactor.set(0, 0); 
		won_tryagain.borderColor = 0xff000000;
		won_tryagain.borderStyle = SHADOW;
		won_tryagain.text = "I THINK YOU CAN DO BETTER";
		won_tryagain.screenCenter();
		won_tryagain.y += 25;
		won_tryagain.visible = false;
		add(won_tryagain);

		damageable = true;
		Reg.health = 100;
		player = new Player();
		player.x = -10;
		player.y = 36;
		add(player);
		FlxG.camera.follow(player, FlxCameraFollowStyle.LOCKON);
		FlxG.camera.targetOffset.x = 190;


		items = new FlxTypedGroup<FlxSprite>();
		_entities = new FlxGroup();

		_entities.add(items);
		add(_entities);
		twitterBtn.screenCenter();
		twitterBtn.y += 300;
		add(twitterBtn);
	}

	override public function update(elapsed:Float):Void
	{

		if (FlxG.keys.justPressed.UP && player.y > 36) 
		{
			add(new Jumpfx(player.x, player.y));
			FlxG.sound.play("jump_snd").volume=0.25;
			player.y -= 72;

		} 
		else if (FlxG.keys.justPressed.DOWN && player.y < 252)
		{
			add(new Jumpfx(player.x, player.y));
			FlxG.sound.play("jump_snd").volume=0.25;
			player.y += 72;
		}

	    if(FlxG.keys.justPressed.CONTROL && !youDied && !won)
		{
			items.add(new Shuriken(player.x + 20, player.y + 10));
			FlxG.sound.play("shuriken_snd").volume=0.25;
			player.animation.play("shoot");
			new FlxTimer().start(0.1, function(_) player.animation.play("walk"));

		}

		super.update(elapsed);

		FlxG.overlap(coins, player, getCoin);

		FlxG.overlap(items, bugs, hitBug);
		FlxG.overlap(player, bugs, hitPlayer);


		if (FlxG.overlap(player, floor) || player.health <= 0)
		{
			if(!youDied)
			{
				youDied = true;
				deadState();
			}
		}

		if(FlxG.mouse.justPressed && youDied && FlxG.mouse.y < 220 || FlxG.keys.justPressed.ENTER && youDied)
		{
			FlxG.sound.play("wooshintro_snd");
	    	FlxG.camera.shake(0.07, 0.1);
			new FlxTimer().start(0.3, function(_)FlxG.resetState());

		}

		if(FlxG.mouse.justPressed && won && FlxG.mouse.y < 220 || FlxG.keys.justPressed.ENTER && won)
		{
			FlxG.sound.play("wooshintro_snd");
	    	FlxG.camera.shake(0.07, 0.1);
			new FlxTimer().start(0.3, function(_)FlxG.resetState());

		}


		FlxG.overlap(exit, player, win);
	}

	public function win(Exit:FlxObject, Player:FlxObject):Void
	{
		won = true;
		player.allowCollisions = 0;
		FlxG.sound.music.stop();
		FlxG.sound.play("levelcomplete_snd");
		player.velocity.x = 0;
		player.animation.play("win");

		FlxG.mouse.showCursor();

		// TWITTER BUTTON
		FlxTween.tween(twitterBtn, {y:220}, 0.2);
		
		won_tryagainbg.visible = true;

		if(Std.parseInt(bugsScore.text) == 0 && coins.countLiving() == 0){
			tryagain.visible = true;
			tryagain.text = "YOU ARE A NINJA!";
			// tryagain.y -= 10;
		}
		else{
			tryagain.visible = true;
			tryagain.text = "YOU MADE IT!";
			tryagain.y -= 10;
			won_tryagain.visible = true;
		}



	}

	public function hitPlayer(ply:FlxObject, bugs:FlxObject):Void
	{
		if (damageable) {
			damageable = false;
			FlxG.sound.play("hitplayer_snd").volume = 6;
	    	FlxG.camera.shake(0.02, 0.1);

			player.animation.play("hitAnim");
			player.hurt(25);
			Reg.health = player.health;
			new FlxTimer().start(0.7, function(_){ player.animation.play("walk"); damageable = true;});
		}


	}

	public function hitBug(shuriken:FlxObject, bug:FlxObject):Void
	{
		add(new EnemyExplode(bug.x, bug.y));
		FlxG.sound.play("dead_bug_snd").volume = 2;

		// bug.kill();
		bug.hurt(26);
		shuriken.kill();
		bugsScore.text = Std.string(bugs.countLiving());
		if(bug.health <= 0) bugsKilled++;

	}

	public function deadState()
	{
		// YOU ARE DEAD
		FlxG.mouse.showCursor();
		Reg.health = 0;
		add(new DeadSkullfx(player.x, player.y));
		add(new Diefx(player.x - 55, player.y - 75));
		// Sounds
	    FlxG.sound.music.stop();
	    FlxG.camera.shake(0.05, 0.2);

		FlxG.sound.play("explosiondeath_snd");
		FlxG.sound.play("death_snd").volume = 1;

		youDied = true;
		tryagain.visible = true;
		tryaganKeys.visible = true;
		tryagainBg.visible = true;
		player.velocity.x = 0;
		player.visible = false;
		player.allowCollisions = 0;

		// TWITTER BUTTON
		FlxTween.tween(twitterBtn, {y:220}, 0.2);
	    
		new FlxTimer().start(0.3, function(_) FlxG.sound.play("gameover_snd").volume = 2);

		
	}

	public function getCoin(Coin:FlxObject, Player:FlxObject):Void
	{
		Coin.kill();
		commitsScore.text = Std.string(coins.countDead());
		add(new Pickupfx(Coin.x - 2, Coin.y - 7));
		FlxG.sound.play("pickups_snd").volume = 0.6;

		// if (coins.countLiving() == 0)
		// {
		// 	trace("no more Krakens");
		// }
	}

	public function shareStuff()
	{
	    Share.share("I killed " + bugsKilled + " bugs in Branch Ninja, think you can be a better ninja? #GKContest try it");
	}
}
