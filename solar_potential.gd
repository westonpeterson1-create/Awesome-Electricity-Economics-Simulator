extends Line2D
const mathlib = preload("res://mathlib.gd")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_points()
	var i = 0
	while (i <= 2184*4):
		add_point(Vector2(i * 7, 800 - (mathlib.Solar(i) * 800)))
		i = i + 1
		
	i = 0
	return
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mathlib_update_graphs() -> void:
	clear_points()
	var i = 0
	while (i <= 2184*4):
		add_point(Vector2(i * 7, 800 - (mathlib.SolarPower(i) * 800)))
		i = i + 1
		
	i = 0
	pass
