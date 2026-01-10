extends Timer
const mathlib = preload("res://mathlib.gd")

static var TIMER_DELAY = 0.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timeout() -> void:
	mathlib.LAGSTATUS = "LOCKED"
	mathlib.ShouldUpdateCost = 1
	pass # Replace with function body.


func _on_ccs_slider_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.



func _on_battery_up_button_pressed() -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_battery_down_button_pressed() -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_therm_str_sldr_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_electrolyzersldr_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_hydro_storage_sldr_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_smr_sldr_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_ration_slider_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_thermal_steam_slider_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_season_dschrg_1_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_season_dschrg_2_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_season_dschrg_3_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_season_dschrg_4_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_hydroelectric_sldr_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.

func _on_h_slider_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.
	


func _on_coal_sldr_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_solar_slider_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_wind_slider_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_lwr_slider_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_sfr_slider_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_biogas_sldr_value_changed(value: float) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_ration_slider_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_solar_slider_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_wind_slider_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_lwr_slider_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_ccs_slider_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_sfr_slider_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_thermal_steam_slider_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_therm_str_sldr_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_hydro_storage_sldr_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_smr_sldr_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_season_dschrg_1_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_season_dschrg_2_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_season_dschrg_3_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_season_dschrg_4_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_hydroelectric_sldr_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_coal_sldr_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_biogas_sldr_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_electrolyzersldr_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.


func _on_dist_solar_sldr_drag_ended(value_changed: bool) -> void:
	start(TIMER_DELAY)
	pass # Replace with function body.
