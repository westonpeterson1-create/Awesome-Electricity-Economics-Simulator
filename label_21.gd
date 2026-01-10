extends Label
const mathlib = preload("res://mathlib.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var HydrogenStorage = mathlib.SteamReformer * 40
	var AvgDistance =  sqrt((mathlib.LandUse() * 200)/3.14) * 0.66 #For transmission loss
	AvgDistance = AvgDistance + (60 * (mathlib.CoalCapacity + mathlib.LWRNuclearCapacity + mathlib.SFRNuclearCapacity + mathlib.GetGasTurbineCapacity()))
	AvgDistance = AvgDistance / 2
	self.text = "Avg Distance: " + str(AvgDistance) + " KM"
	pass
