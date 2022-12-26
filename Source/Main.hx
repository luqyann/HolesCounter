package;

import haxe.ui.Toolkit;
import haxe.ui.HaxeUIApp;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		Toolkit.scale = 2;
		var app = new HaxeUIApp();
		app.ready(() -> {
			app.addComponent(App.app);
			app.start();
		});

	}
}
