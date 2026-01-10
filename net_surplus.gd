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
		add_point(Vector2(i * 7, 800 - sqrt(((mathlib.GetHydrogenIntegral(i) * 800)))))
		i = i + 168/60
		
	i = 0
	return


func _on_solar_slider_value_changed(value: float) -> void:
	Calculate()
	pass # Replace with function body.


func _on_wind_slider_value_changed(value: float) -> void:
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


func _on_therm_str_sldr_value_changed(value: float) -> void:
	Calculate()
	pass # Replace with function body.


func _on_battery_wattage_sldr_value_changed(value: float) -> void:
	Calculate()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	Calculate()
	pass # Replace with function body.
