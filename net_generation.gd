extends Line2D
const mathlib = preload("res://mathlib.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Calculate() -> void:
	clear_points()
	var i = 0
	while (i <= 2184*4):
		#add_point(Vector2(i * 7, 800 - (((mathlib.TotalGeneration(i) - mathlib.CoalGenIntegralStorage[i] - (mathlib.Steam_Base_Throttle(i) * 1) - mathlib.NukeCurtailments[i]) * 800))))
		add_point(Vector2(i * 7, 800 - ((mathlib.SolarPower(i) + mathlib.HydroPower(i) + mathlib.WindPower(i) + mathlib.LWRNuclearCapacity + mathlib.SFRNuclearCapacity) - mathlib.NukeCurtailments[i]) * 800))
		i = i + 168/60
		
	i = 0
	return


func _on_h_slider_value_changed(value: float) -> void:
	Calculate()
	pass # Replace with function body.


func _on_h_slider_2_value_changed(value: float) -> void:
	Calculate()
	pass # Replace with function body.


func _on_lwr_slider_value_changed(value: float) -> void:
	Calculate()
	pass # Replace with function body.


func _on_sfr_slider_value_changed(value: float) -> void:
	Calculate()
	pass # Replace with function body.


func _on_thermal_steam_slider_value_changed(value: float) -> void:
	Calculate()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	Calculate()
	pass # Replace with function body.
