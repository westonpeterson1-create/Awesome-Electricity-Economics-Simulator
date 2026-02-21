extends Label
const mathlib = preload("res://mathlib.gd")
func round_place(num):
	return (round(num*pow(10,1))/pow(10,1))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var HydrogenStorage = mathlib.HydrogenStorage
	self.text = "H2 storage: (" + str(round_place(HydrogenStorage)) + " Hours)"
	pass
