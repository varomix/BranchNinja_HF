package;

import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;

class Reg {
	public static var score:Int = 0;	
	public static var bugs:Int = 300;	
	public static var health:Float = 100;

	public static var pause:Bool = false;

	public static var effects(default, null):FlxGroup;	
}