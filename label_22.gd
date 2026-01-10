extends Label
const mathlib = preload("res://mathlib.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ScrubbedEmissions = mathlib.ScrubbedCO2 / (2184 * 4)
	var UnscrubbedEmissions = mathlib.IntensityCO2 - 0
	var hydrofraction = (mathlib.Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions + 0.00001) / 494)
	if (hydrofraction > 1):
		hydrofraction = 1
	var CO2Intensity = (ScrubbedEmissions * 0.1) + (UnscrubbedEmissions * (1 - hydrofraction))
	if (CO2Intensity <= 0):
		CO2Intensity = 0
	CO2Intensity = CO2Intensity / mathlib.GetDemandCF()
	var WastedEnergy = ((CO2Intensity / 497) * 100) + (((mathlib.LWRNuclearCapacity + mathlib.SFRNuclearCapacity) / mathlib.GetDemandCF()) * 100) + (((mathlib.WindCapacity * 0.38) / mathlib.GetDemandCF()) * 100) + (((mathlib.SolarCapacity * 0.21) / mathlib.GetDemandCF()) * 100) - 100
	self.text = "ENERGY MIX: " + "\n" + str((CO2Intensity / 497) * 100) + "% Natural Gas" + "\n" + str(((mathlib.LWRNuclearCapacity + mathlib.SFRNuclearCapacity) / mathlib.GetDemandCF()) * 100) + "% Nuclear" + "\n" + str(((mathlib.WindCapacity * 0.38) / mathlib.GetDemandCF()) * 100) + "% Wind" + "\n" + str(((mathlib.SolarCapacity * 0.21) / mathlib.GetDemandCF()) * 100) + "% Solar" + "\n" + str(WastedEnergy * -1) + "% Curtailments"
	self.text = " "
	pass
