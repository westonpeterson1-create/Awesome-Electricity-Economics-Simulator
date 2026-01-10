extends Node


func _on_button_pressed() -> void:
	#var scene = preload("res://mathlib.tscn").instantiate()
	#var cur_scene = get_tree().get_current_scene()
	#get_tree().root.add_child(scene)
	#get_tree().get_root().remove_child(cur_scene)
	Global.T_EVALPERIOD = 40
	get_tree().change_scene_to_file("res://mathlib.tscn")
	pass # Replace with function body.


func _on_button_2_button_down() -> void:
	Global.T_LOCATION = "JAPAN"
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	Global.T_LOCATION = "GERMANY"
	#print("GERMANY")
	#print(Global.T_LOCATION)
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	Global.T_LOCATION = "CALIFORNIA"
	pass # Replace with function body.


func _on_button_5_pressed() -> void:
	Global.T_LOCATION = "FLORIDA"
	pass # Replace with function body.


func _on_button_6_pressed() -> void:
	Global.T_COSTDATA = "AMERICA_2040"
	pass # Replace with function body.


func _on_button_7_pressed() -> void:
	Global.T_COSTDATA = "AMERICA_2040 (good solar)"
	pass # Replace with function body.


func _on_button_8_pressed() -> void:
	Global.T_COSTDATA = "AMERICA_TODAY"
	pass # Replace with function body.


func _on_h_slider_value_changed(value: float) -> void:
	Global.T_INTEREST = 0.12 * (value / 100)
	pass # Replace with function body.


func _on_h_slider_2_value_changed(value: float) -> void:
	Global.T_CARBONCOST = (value / 100) * 300
	pass # Replace with function body.


func _on_button_9_pressed() -> void:
	#var scene = preload("res://mathlib.tscn").instantiate()
	#var cur_scene = get_tree().get_current_scene()
	#get_tree().root.add_child(scene)
	#get_tree().get_root().remove_child(cur_scene)
	Global.T_EVALPERIOD = 80
	get_tree().change_scene_to_file("res://mathlib.tscn")
	pass # Replace with function body.


func _on_h_slider_3_value_changed(value: float) -> void:
	Global.T_INVESTSUBSIDY = (value / 100)
	pass # Replace with function body.


func _on_h_slider_4_value_changed(value: float) -> void:
	Global.T_RENEWABLESUBSIDY = (value / 100) * 3
	pass # Replace with function body.
