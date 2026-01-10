extends Label
const mathlib = preload("res://mathlib.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var HydrogenStorage = mathlib.HydrogenStorage
	self.text = "Hydrogen storage: (" + str(HydrogenStorage) + " Hours)"
	pass
