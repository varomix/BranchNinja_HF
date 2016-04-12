package;

import entities.Player;
import entities.Shuriken;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import flixel.addons.editors.tiled.TiledImageLayer;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import fx.DeadSkullfx;
import fx.Diefx;

using flixel.util.FlxSpriteUtil;


class PlayState extends FlxState
{
	public var commits:FlxText;
	public var commitsScore:FlxText;
	public var bugs:FlxText;
	public var bugsScore:FlxText;
	public var tryagain:FlxText;
	public var tryagainBg:FlxSprite;


	public var level:TiledLevel;
	var player:Player;
	public var coins:FlxGroup;
	public var floor:FlxGroup;
	public var items(default, null):FlxTypedGroup<FlxSprite>;
	private var _entities:FlxGroup;

	private static var youDied:Bool = false;

	override public function create():Void
	{
		super.create();
		FlxG.debugger.drawDebug = true;

		youDied = false;
		
		// game level
		coins = new FlxGroup();
		floor = new FlxGroup();
		level = new TiledLevel("assets/tiled/testMap.tmx", this);

		var bg = new FlxSprite("assets/tiled/bg.png");
		bg.scrollFactor.set(0,0);
		add(bg);

		add(level.backgroundLayer);
		// add(level.imagesLayer);

		add(floor);
		add(level.objectsLayer);
		add(level.foregroundTiles);
		add(coins);

		var textSize = 20;

		// Create UI
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

		bugs = new FlxText(340, 5, 150);
		bugs.setFormat("assets/data/bitlow.ttf", textSize, FlxColor.WHITE);
		bugs.scrollFactor.set(0, 0); 
		bugs.borderColor = 0xff000000;
		bugs.borderStyle = SHADOW;
		bugs.text = "BUGS:";
		add(bugs);

		bugsScore = new FlxText(410, 5, 100);
		bugsScore.setFormat("assets/data/bitlow.ttf", textSize, FlxColor.PINK);
		bugsScore.scrollFactor.set(0, 0); 
		bugsScore.borderColor = 0xff000000;
		bugsScore.borderStyle = SHADOW;
		bugsScore.text = Std.string(coins.countDead());
		add(bugsScore);

		tryagainBg = new FlxSprite(0,130);
		tryagainBg.scrollFactor.set(0,0);
		tryagainBg.makeGraphic(FlxG.width, 65, FlxColor.BLACK);
		tryagainBg.visible = false;
		add(tryagainBg);

		tryagain = new FlxText(0, 0, FlxG.width);
		tryagain.setFormat("assets/data/bitlow.ttf", 50, FlxColor.MAGENTA, FlxTextAlign.CENTER);
		tryagain.scrollFactor.set(0, 0); 
		tryagain.borderColor = 0xff000000;
		tryagain.borderStyle = SHADOW;
		tryagain.text = "CLICK TO TRY AGAIN";
		tryagain.screenCenter();
		tryagain.visible = false;
		add(tryagain);


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
	}

	override public function update(elapsed:Float):Void
	{
	    if(FlxG.keys.justPressed.CONTROL)
		{
			items.add(new Shuriken(player.x + 20, player.y + 10));
			player.animation.play("shoot");
			new FlxTimer().start(0.1, function(_) player.animation.play("walk"));

		}

		super.update(elapsed);

		FlxG.overlap(coins, player, getCoin);

		if (FlxG.overlap(player, floor))
		{
			if(!youDied)
			{
				youDied = true;
				deadState();
			}
		}

		if(FlxG.mouse.justPressed && youDied)
		{
			FlxG.resetState();
		}
	}

	public function deadState()
	{
		// YOU ARE DEAD
		add(new DeadSkullfx(player.x, player.y));
		add(new Diefx(player.x - 55, player.y - 75));
		youDied = true;
		tryagain.visible = true;
		tryagainBg.visible = true;
		player.velocity.x = 0;
		player.visible = false;
	    
	}

	public function getCoin(Coin:FlxObject, Player:FlxObject):Void
	{
		Coin.kill();
		commitsScore.text = Std.string(coins.countDead());
		if (coins.countLiving() == 0)
		{
			trace("no more Krakens");
		}
	}
}
