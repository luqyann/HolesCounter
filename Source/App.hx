import openfl.Assets;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.geom.Matrix;
import haxe.Timer;
import openfl.display.BitmapData;
import haxe.ui.events.UIEvent;
import haxe.ui.containers.Box;

using Math;
using MathUtils;

@:build(haxe.ui.macros.ComponentMacros.build("Assets/xml/app.xml"))
class App extends Box {
	static public var app(get, default):Null<App>;

	static function get_app():App {
		if (app == null)
			app = new App();
		return app;
	}

	function new() {
		super();
	}

	function recalc() {
		var t1 = Timer.stamp();

		var count = -1;

		var bd = new BitmapData(label.width.round(), label.height.round() + 8, true, 0x00000000);

		var m = new Matrix();
		m.translate(0, 4);
		bd.drawWithQuality(label, m, null, null, null, false, BEST);
		bd.lock();
		for (y in 0...bd.height) {
			for (x in 0...bd.width) {
				if (bd.getPixel32(x, y) == 0x00000000) {
					count++;
					bd.floodFill(x, y, 0xFF0000FF);
				}
			}
		}
		bd.floodFill(0, 0, 0x00000000);
		bd.unlock();
		result_label.text = 'Кол-во дырок: ${count.max(0)}';

		var g = canvas.graphics;

		g.clear();
		g.beginBitmapFill(bd, null, false);
		g.drawRect(0, 0, bd.width, bd.height);
		g.endFill();

		timing_label.text = 'Время проверки: ${(Timer.stamp() - t1).roundPrec(3)}';
	}

	@:bind(textfield, UIEvent.CHANGE)
	function textfield_Change(_) {
		label.text = textfield.text;
		label.syncComponentValidation();
		recalc();
	}

	@:bind(font_size_stepper, UIEvent.CHANGE)
	function font_size_stepper_Change(_) {
		if (label.customStyle.fontSize != font_size_stepper.value) {
			label.customStyle.fontSize = font_size_stepper.value;
			label.invalidateComponentStyle();
		}
		label.syncComponentValidation();
		recalc();
	}
}
