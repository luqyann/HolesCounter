class MathUtils{
	static public function roundPrec(v:Float, prec:Int) {
		var mag = Math.pow(10, prec);
		v = v * mag;
		var out:Float = Std.int(v);
		out /= mag;
		return out;
	}
}