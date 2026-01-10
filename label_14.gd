extends Label
const mathlib = preload("res://mathlib.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ScrubbedEmissions2 = mathlib.UnadulteratedScrubbedCO2 / (2184 * 4)
	var UnscrubbedEmissions2 = mathlib.UnadulteratedIntensityCO2 - (mathlib.UnadulteratedIntensityCO2 / (2184 * 4))
	var hydrofraction = (mathlib.Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions2 + 0.00001) / 494)
	if (hydrofraction > 1):
		hydrofraction = 1
	self.text = "Hydrogen Blend: " + str(hydrofraction)
	pass
