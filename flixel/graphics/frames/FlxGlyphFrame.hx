package flixel.graphics.frames;

import flash.display.BitmapData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFrame.FlxFrameType;
import flixel.math.FlxMatrix;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * Just a special frame for handling bitmap fonts
 */
class FlxGlyphFrame extends FlxFrame
{
	/**
	 * How much to jump after drawing this glyph.
	 */
	public var xAdvance:Int = 0;
	
	public var charCode:Int;
	
	@:allow(flixel)
	private function new(parent:FlxGraphic, charCode:Int) 
	{
		super(parent);
		this.charCode = charCode;
		type = FlxFrameType.GLYPH;
	}
	
	override public function paint(bmd:BitmapData = null, point:Point = null, mergeAlpha:Bool = false):BitmapData
	{
		if (sourceSize.x == 0 || sourceSize.y == 0)
		{
			return bmd;
		}
		
		if (point == null)
		{
			point = FlxPoint.point1;
			point.setTo(0, 0);
		}
		
		if (bmd != null && !mergeAlpha)
		{
			var rect:Rectangle = FlxRect.rect;
			rect.setTo(point.x, point.y, xAdvance, sourceSize.y + offset.y);
			bmd.fillRect(rect, FlxColor.TRANSPARENT);
		}
		else if (bmd == null)
		{
			bmd = new BitmapData(xAdvance, Std.int(sourceSize.y + offset.y), true, FlxColor.TRANSPARENT);
		}
		
		FlxPoint.point.setTo(point.x + offset.x, point.y + offset.y);
		bmd.copyPixels(parent.bitmap, frame.copyToFlash(FlxRect.rect), FlxPoint.point, null, null, mergeAlpha);
		return bmd;
	}
	
	override public function paintFlipped(bmd:BitmapData = null, point:Point = null, flipX:Bool = false, flipY:Bool = false, mergeAlpha:Bool = false):BitmapData
	{
		return bmd;
	}
}