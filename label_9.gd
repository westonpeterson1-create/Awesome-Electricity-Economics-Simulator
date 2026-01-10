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
	var RawCO2 = mathlib.IntensityCO2
	var hydrofraction = (mathlib.Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions2 + 0.00001) / 494)
	if (hydrofraction > 1):
		hydrofraction = 1
	var multiplier = (179 / mathlib.GasTurbineEfficiency) / 497
	var CO2Total = mathlib.IntensityCO2 * multiplier
	var CO2Intensity = (ScrubbedEmissions * 0.1 * 1.4) + (UnscrubbedEmissions * (1 - hydrofraction))
	if (CO2Intensity <= 0):
		CO2Intensity = 0
	var PollutionToll = ((RawCO2 / 497) * mathlib.GasAirPollutionToll) * ((27.6 * 8600) / 1000)
	var PollutionCost = (PollutionToll * mathlib.HumanLifeCost) / ((27.6 * 8600) * 1000000)
	PollutionCost = PollutionCost * 100 * mathlib.DoHumanMortality
	CO2Intensity = CO2Intensity * multiplier
	CO2Intensity = CO2Intensity + (0.05 * CO2Total) #For methane emissions at 0.5% leak rate
	
	var coalco2coefficient = 323.19 / 0.43 #https://www.eia.gov/environment/emissions/co2_vol_mass.php
	var coalfraction = 0
	var w = 0
	while(w <= (2184 * 4)):
		w = w + 1
		coalfraction = coalfraction + mathlib.CoalGenIntegralStorage[w]
	coalfraction = coalfraction / (2184 * 4)
	CO2Intensity = CO2Intensity + (coalfraction * coalco2coefficient)
	
	var coalkwhcost = (mathlib.CoalMBtuCost / 297) / 0.43
	coalkwhcost = coalkwhcost * coalfraction
	coalkwhcost = coalkwhcost * 100
	var P = mathlib.GetCAPEX()
	var i = mathlib.interestrate / 12
	var n = 80 * 12
	var actualcost = (P * (i * pow((1 + i), n))) / (pow((1 + i), n) - 1)
	actualcost = (80 * 12) * actualcost
	actualcost = actualcost + (mathlib.GetCAPEX80() - mathlib.GetCAPEX())
	var carbonfee = (mathlib.CO2cost/ 10) * (CO2Intensity / 1000)
	var yearlycost = (mathlib.YearlyOpEX80() + (actualcost / 80))
	yearlycost = (yearlycost / 8760) * 100
	yearlycost = yearlycost / mathlib.GetDemandCF()
	if (mathlib.ShouldUpdateCost == 1):
		self.text = "Cost80: " + str(yearlycost + (carbonfee / mathlib.GetDemandCF()) + coalkwhcost + PollutionCost - mathlib.Get_Production_Subsidy())
		mathlib.ShouldUpdateCost = 0
	if(Global.T_EVALPERIOD != 80):
		self.text = " "
	pass
