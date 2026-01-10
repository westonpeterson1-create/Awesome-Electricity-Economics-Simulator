extends Label
const mathlib = preload("res://mathlib.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ScrubbedEmissions = mathlib.ScrubbedCO2 / (2184 * 4)
	var UnscrubbedEmissions = mathlib.IntensityCO2 - (mathlib.ScrubbedCO2 / (2184 * 4))
	#var hydrofraction = (mathlib.Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions + 0.00001) / 494)
	var ScrubbedEmissions2 = mathlib.UnadulteratedScrubbedCO2 / (2184 * 4)
	var UnscrubbedEmissions2 = mathlib.UnadulteratedIntensityCO2 - (mathlib.UnadulteratedScrubbedCO2 / (2184 * 4))
	var hydrofraction = (mathlib.Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions2 + 0.00001) / 494)
	if (hydrofraction > 1):
		hydrofraction = 1
	var multiplier = (179 / mathlib.GasTurbineEfficiency) / 497
	var CO2Total = mathlib.IntensityCO2 * multiplier
	var CO2Intensity = (ScrubbedEmissions2 * 0.1 * 1.4) + (UnscrubbedEmissions2 * (1 - hydrofraction))
	if (CO2Intensity <= 0):
		CO2Intensity = 0
	CO2Intensity = CO2Intensity * multiplier
	CO2Intensity = CO2Intensity + (0.05 * CO2Total) #For methane emissions at 0.5% leak rate
	var coalco2coefficient = 323.19 / 0.43 #https://www.eia.gov/environment/emissions/co2_vol_mass.php
	var coalfraction = 0
	var i = 0
	while(i <= (2184 * 4)):
		i = i + 1
		coalfraction = coalfraction + mathlib.CoalGenIntegralStorage[i]
	coalfraction = coalfraction / (2184 * 4)
	CO2Intensity = CO2Intensity + (coalfraction * coalco2coefficient)
	
	self.text = "CO2 intensity: " + str(CO2Intensity / mathlib.GetDemandCF())
	pass
