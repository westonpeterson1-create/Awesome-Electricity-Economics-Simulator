extends Label
const mathlib = preload("res://mathlib.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ScrubbedEmissions = mathlib.ScrubbedCO2 / (2184 * 4)
	var RawCO2 = mathlib.IntensityCO2
	var UnscrubbedEmissions = mathlib.IntensityCO2 - (mathlib.ScrubbedCO2 / (2184 * 4))
	var hydrofraction = (mathlib.Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions + 0.00001) / 494)
	if (hydrofraction > 1):
		hydrofraction = 1
	var multiplier = (179 / mathlib.GasTurbineEfficiency) / 497
	var CO2Total = mathlib.IntensityCO2 * multiplier
	var CO2Intensity = (ScrubbedEmissions * 0.1) + (UnscrubbedEmissions * (1 - hydrofraction))
	if (CO2Intensity <= 0):
		CO2Intensity = 0
	var PollutionToll = ((RawCO2 / 497) * mathlib.GasAirPollutionToll) * ((27.6 * 8600) / 1000)
	#self.text = "Yearly pollution deaths: " + str(PollutionToll)
	self.text = " "
	pass
