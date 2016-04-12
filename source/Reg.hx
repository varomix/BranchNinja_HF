package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;

class Reg {
	public static var score:Int = 0;	
	public static var bugs:Int = 0;	
	public static var health:Int = 0;

	public static var pause:Bool = false;

	public static var items(default, null):FlxTypedGroup<FlxSprite>;	
}