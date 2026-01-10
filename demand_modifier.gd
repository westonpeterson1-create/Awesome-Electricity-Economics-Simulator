extends Line2D
const mathlib = preload("res://mathlib.gd")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_points()
	var i = 0
	while (i <= 2184*4):
		add_point(Vector2(i * 7, 800 - ((mathlib.DemandMod(i) * 800))))
		i = i + 1
		
	i = 0
	return


func _on_battery_up_button_pressed() -> void:
	pass # Replace with function body.


func _on_mathlib_update_graphs() -> void:
	clear_points()
	var i = 0
	while (i <= 2184*4):
		add_point(Vector2(i * 7, 800 - ((mathlib.DemandMod(i) * 800))))
		i = i + 1
		
	i = 0
	pass # Replace with function body.
