extends Object
signal UpdateGraphs

static var LOCATION = Global.T_LOCATION

static var WINDFILE="res://data_sci/FLORIDAWIND.csv"
static var SOLARFILE="res://data_sci/FLORIDASOLAR.csv"
static var DEMANDFILE="res://data_sci/FLORIDADEMAND.csv"
static var HYDROFRACTION = 0.005
static var WINTERHYDRO = 0.66 #Make sure these all average to 0.66 for HYDROFRACTION to work
static var SPRINGHYDRO = 1
static var SUMMERHYDRO = 0.33
static var FALLHYDRO = 0.66
static var GasMBtuCost = 3.50
static var CoalMBtuCost = 2.50
static var BiogasCost = 14.00
static var BiogasFraction = 0.01

static func Initiatevars() -> void:
	if(Global.T_COSTDATA == "AMERICA_2040"):
		D = preload("res://COST_SCENARIOS/AMERICA_2040.gd")
	if(Global.T_COSTDATA == "AMERICA_2040 (good solar)"):
		D = preload("res://COST_SCENARIOS/AMERICA_2040 (good_solar).gd")
	if(Global.T_COSTDATA == "AMERICA_TODAY"):
		D = preload("res://COST_SCENARIOS/AMERICA_TODAY.gd")
	print(LOCATION)
	if (LOCATION == "JAPAN"):
		WINDFILE="res://data_sci/JAPANWIND.csv"
		SOLARFILE="res://data_sci/JAPANSOLAR.csv"
		DEMANDFILE="res://data_sci/JAPANDEMAND.csv"
		HYDROFRACTION = 0.085
		WINTERHYDRO = 0.33 #Make sure these all average to 0.66 for HYDROFRACTION to work
		SPRINGHYDRO = 1
		SUMMERHYDRO = 0.66
		FALLHYDRO = 0.66
		GasMBtuCost = 8.00
		CoalMBtuCost = 5.00
		BiogasCost = 14.00
		BiogasFraction = 0.017 #Because of combined cycle weirdness, this is higher than it looks here by around 2

	if (LOCATION == "GERMANY"):
		WINDFILE="res://data_sci/GERMANYWIND.csv"
		SOLARFILE="res://data_sci/GERMANYSOLAR.csv"
		DEMANDFILE="res://data_sci/GERMANYDEMAND.csv"
		HYDROFRACTION = 0.06
		WINTERHYDRO = 0.33 #Make sure these all average to 0.66 for HYDROFRACTION to work
		SPRINGHYDRO = 1
		SUMMERHYDRO = 0.66
		FALLHYDRO = 0.66
		GasMBtuCost = 8.00
		CoalMBtuCost = 2.50
		BiogasCost = 14.00
		BiogasFraction = 0.017 #Because of combined cycle weirdness, this is higher than it looks here by around 2

#CALIFORNIA VALUES
	if (LOCATION == "CALIFORNIA"):
		WINDFILE="res://data_sci/CAISOWIND.csv"
		SOLARFILE="res://data_sci/CAISOSOLAR.csv"
		DEMANDFILE="res://data_sci/CAISODEMAND.csv"
		HYDROFRACTION = 0.1
		WINTERHYDRO = 0.66 #Make sure these all average to 0.66 for HYDROFRACTION to work
		SPRINGHYDRO = 1
		SUMMERHYDRO = 0.33
		FALLHYDRO = 0.66
		GasMBtuCost = 3.50
		CoalMBtuCost = 2.50
		BiogasCost = 14.00
		BiogasFraction = 0.017 #Because of combined cycle weirdness, this is higher than it looks here by around 2

#FLORIDA VALUES
	if (LOCATION == "FLORIDA"):
		WINDFILE="res://data_sci/FLORIDAWIND.csv"
		SOLARFILE="res://data_sci/FLORIDASOLAR.csv"
		DEMANDFILE="res://data_sci/FLORIDADEMAND.csv"
		HYDROFRACTION = 0.005
		WINTERHYDRO = 0.66 #Make sure these all average to 0.66 for HYDROFRACTION to work
		SPRINGHYDRO = 1
		SUMMERHYDRO = 0.33
		FALLHYDRO = 0.66
		GasMBtuCost = 3.50
		CoalMBtuCost = 2.50
		BiogasCost = 14.00
		BiogasFraction = 0.017 #Because of combined cycle weirdness, this is higher than it looks here by around 2
#ASSUMTPIONS

#HIGH PRIORITY ASSUMPTIONS
static var PeakDemand = 40
static var interestrate = Global.T_INTEREST
static var CO2cost = Global.T_CARBONCOST #Per tonS
static var D


#LOWER PRIORITY ASSUMPTIONS
static var flexibledemandfraction = 0.3
static var demandflexibilitytimelimit = 12
static var uraniumyearlycost = 42.50
static var HumanLifeCost = 5000000
static var GasAirPollutionToll = 2
static var DoHumanMortality = 0
static var base_steam_min_throttle = 0.2
static var PowerRationIncentive = 5000
static var HydroElectricCapex = 3000
static var HydroElectricOM = 60
static var HydroElectricResourceDistance = 250

static var DistributedSolarCapex = 2200
static var DistributedBatteryCapex = 320

static var CoalCapex = 3200
static var CoalOM = 40

static var GasCapex = 800
static var GasLifespan = 50
static var GasOM = 14
	#return GasMBtuCost * pow(1.01, x)
static var GasTurbineEfficiency = 0.40
static var SteamCapex = 900
static var Steamlifespan = 50
static var SteamThermalAuxBoilerCost = 300
static var SteamOpex = 22
static var ThermalStorageCapex = 25
static var ThermalStoragelifespan = 40
static var ThermalStorageLossRate = 1.2 #https://thundersaidenergy.com/downloads/thermal-energy-storage-cost-model/
static var HydrogenMBtuHandlingCost = 0.0 #https://assets.publishing.service.gov.uk/media/659e600b915e0b00135838a6/hydrogen-transport-and-storage-cost-report.pdf
#Added cost given in british report, converted to dollars, and multiplied by 0.81 since america is more efficient. 0.81 derived from vogtle vs hinkley point C cost per watt
static var HyroTurbineCostAdd = 0.3
static var ElectrolyzerOM = 2.5
static var CCScostModifier = 3
static var HydrogenStorageCost = 2
static var HVDCCapex = 1.25 #Dollars per ilowatt kilometer
static var HPIPECapex = 0.125 / GasTurbineEfficiency
static var HVDCOM = 0.16
static var HPIPEOM = 0.01 / GasTurbineEfficiency
static var SteamReformerCapex = 2400 #Per kilowatt of hydrogen equivilant
static var SteamReformerOM = 40 #Per kilowatt year of hydrogen equivilant
static var Interconnectcost = 120
#END OF ASSUMTPIONS
static var ShouldUpdateCost = 0
static var LAGSTATUS = "READY"
static var DemandArray
static var RealBiogasFraction = 0
static var UnusedBiogas = 0
static var virtualstorageintegral: Array[float] = []
static var lostpotentialarray: Array[float] = []
static var DupeArray
static var SolarArray
static var WindArray
static var CoalCapacity = 0
static var RationPowerTracker = 0
static var RationedPower = 0
static var GasKWY
static var DistributedSolarCapacity = 0
static var HydroKWY
static var Minutelyloss
static var SolarCapacity = 0
static var WindCapacity = 0
static var GasCapacity = 0
static var LWRNuclearCapacity = 0
static var NukeCurtailments: Array[float] = []
static var mingasarray: Array[float] = []
static var NetGenIntegralStorage: Array[float] = []
static var NetGenIntegralStorageThermal: Array[float] = []
static var HydrogenIntegral: Array[float] = []
static var MaxBatteryOutput = -0.25
static var NetGenIntegral = 0
static var BatteryCapacity = 0
static var CO2GenIntegralStorage: Array[float] = []
static var GasTurbineThrottle: Array[float] = []
static var CoalGenIntegralStorage: Array[float] = []
static var SecondCycleGraphStorage: Array[float] = []
static var NonFossilThermalGeneration: Array[float] = []
static var CombinedCycleCharginess = 0
static var IntensityCO2 = 0
static var CCSFraction = 0
static var SFRNuclearCapacity = 0
static var ThermalBatteryCapacity = 0
static var SteamReformer = 0
static var ThermalBatterySteamCapacity = 0
static var ElectrolyzerCapacity = 0
static var Hydroproduction = 0
static var ScrubbedCO2 = 0
static var HydrogenStorage = 0
static var GasSecondaryEnergy = 0
static var truesteam = 0
static var winter_discharge = 1
static var spring_discharge = 1
static var summer_discharge = 1
static var fall_discharge = 1
#static var minimum_gas = 0
static var previous_gas_storage = 0
static var HydroElectricPower = 0
static var SMRcapacityfactor = 0
static var SMRTotal = 0
static func Solar(Hour: float) -> float:
#	if (Hour <= (546 * 4)): #Winter
#		var mathfunc = sin(Hour * PI/12) * sin(Hour * PI/168) * 100
#		mathfunc = mathfunc - 30
#		if(mathfunc <= 0):
#			mathfunc = 0 #Solar panels can't produce negative power!
#		mathfunc = mathfunc / 100
#		return mathfunc
#
#	if (Hour <= (1092 * 4)): #Spring
#		var mathfunc = sin(Hour * PI/12) * sin(Hour * PI/168) * 100
#		if(mathfunc <= 0):
#			mathfunc = 0 #Solar panels can't produce negative power!
#		mathfunc = mathfunc / 100
#		return mathfunc #Fall
#	
#	if (Hour <= (1638* 4)): #Summer
#		var mathfunc = sin(Hour * PI/12) * sin(Hour * PI/168) * 100
#		mathfunc = mathfunc + 40
#		if (mathfunc >= 100):
#			mathfunc = 100
#		if(mathfunc <= 0):
#			mathfunc = 0 #Solar panels can't produce negative power!
#		mathfunc = mathfunc / 100
#		return mathfunc
#	var mathfunc = sin(Hour * PI/12) * sin(Hour * PI/168) * 100 #Fall
#	if(mathfunc <= 0):
#		mathfunc = 0 #Solar panels can't produce negative power!
#	mathfunc = mathfunc / 100
#	return mathfunc
	return float(SolarArray[Hour])
static func SolarPower(Hour: float) -> float:
	return Solar(Hour) * SolarCapacity

static var oldadditionalthrottle = 0
static func SmartDispatch(Hour: float) -> float:
	var additionalthrottle = 0
	additionalthrottle = 1 - (WindPower(Hour) + SolarPower(Hour)) * (((BatteryCapacity + 0.1 + (10 * HydroElectricPower)) - (NetGenIntegralStorage[Hour])) / (BatteryCapacity + 0.1 + (10 * HydroElectricPower)))
	if (additionalthrottle > oldadditionalthrottle + 0.1):
		additionalthrottle = oldadditionalthrottle + 0.1
	if (additionalthrottle < oldadditionalthrottle - 0.1):
		additionalthrottle = oldadditionalthrottle - 0.1
			
	oldadditionalthrottle = additionalthrottle
	if(additionalthrottle > DemandMod(Hour)):
		additionalthrottle = DemandMod(Hour)
	#print("Batterychargeadditions:" + str(batterychargingadditions))
	#return returnme
	#print(additionalthrottle)
	var secondcyclecapacity = (GetGasTurbineCapacity() * ((1 - GasTurbineEfficiency) * 0.4) / GasTurbineEfficiency) - (Steam_Base_Throttle(Hour))
	var returnme = additionalthrottle * (GetGasTurbineCapacity()) * CombinedCycleCharginess
	if (returnme + NetGenIntegralStorage[Hour] > 0.9 * (BatteryCapacity + 0.1 + (10 * HydroElectricPower))):
		returnme = (0.9 * (BatteryCapacity + 0.1 + (10 * HydroElectricPower))) - NetGenIntegralStorage[Hour]
	if(returnme <= 0):
		returnme = 0
	return returnme
static func Steam_Base_Throttle(Hour: float) -> float:
	#if(Hour == 0):
	#	return 1 * ThermalBatterySteamCapacity
	#var batterychargingadditions = 0
	#var additionalthrottle = 0
	#if (NetGenIntegralStorage[Hour - 1] <= (0.8 * (BatteryCapacity + 0.1 + (10 * HydroElectricPower)))):
	#	additionalthrottle = 1
	#if (NetGenIntegralStorage[Hour - 1] > (BatteryCapacity + 0.1 + (10 * HydroElectricPower))):
	#	additionalthrottle = 0
	#	
	#if (additionalthrottle < SFRNuclearCapacity):
	#	additionalthrottle = SFRNuclearCapacity
	#if (additionalthrottle < base_steam_min_throttle):
	#	additionalthrottle = base_steam_min_throttle
	#	
	#if (additionalthrottle > oldadditionalthrottle + 0.5):
	#	additionalthrottle = oldadditionalthrottle + 0.5
	#if (additionalthrottle < oldadditionalthrottle - 0.5):
	#	additionalthrottle = oldadditionalthrottle - 0.5
	#oldadditionalthrottle = additionalthrottle
	#print("Batterychargeadditions:" + str(batterychargingadditions))
	#return returnme
	#print(additionalthrottle)
	#return additionalthrottle * ThermalBatterySteamCapacity * CombinedCycleCharginess
	#return 1 * ThermalBatterySteamCapacity
	var thing = (0.2 * ThermalBatterySteamCapacity)
	if (thing <= 0):
		thing = 0
	return thing
static func HydroPower(Hour: float) -> float:
	if (Hour <= (273 * 4)): #Winter first half
		return WINTERHYDRO * HydroElectricPower

	if (Hour <= (819 * 4)): #Spring
		return SPRINGHYDRO * HydroElectricPower

		
	if (Hour <= (1365 * 4)): #Summer
		return SUMMERHYDRO * HydroElectricPower

	if (Hour <= (1911 * 4)): #fall
		return FALLHYDRO * HydroElectricPower
	
	if (Hour <= (2184 * 4)): #Winter second half
		return FALLHYDRO * HydroElectricPower
	print("Hydropower seasonal calculation fuckup")
	return 0 #Fuckup
	
static func LWRNuclearPower(Hour: float) -> float:
	return LWRNuclearCapacity
	
static func Wind(Hour: float) -> float:
#	if (Hour <= (546 * 4)): #Winter
#		var mathfunc = (cos(Hour * PI/156) * 40) + 60
#		mathfunc = abs(mathfunc)
#		if(mathfunc <= 0):
#			mathfunc = 0 #Wind panels can't produce negative power!
#		mathfunc = mathfunc / 100
#		return mathfunc
#
#	if (Hour <= (1092 * 4)): #Spring
#		var mathfunc = (cos(Hour * PI/156) * 60) + 40
#		mathfunc = abs(mathfunc)
#		if(mathfunc <= 0):
#			mathfunc = 0 #Wind panels can't produce negative power!
#		mathfunc = mathfunc / 100
#		return mathfunc
#		
#
#	if (Hour <= (1638* 4)): #Fall
#		var mathfunc = ((cos(Hour * PI/156) * 60) + 40) * sin(Hour/156)
#		if(mathfunc <= 0):
#			mathfunc = 0 #Wind panels can't produce negative power!
#		return mathfunc
#	var mathfunc = ((cos(Hour * PI/156) * 60) + 40) * sin(Hour/156)
#	if(mathfunc <= 0):
#		mathfunc = mathfunc * -1 #Wind panels can't produce negative power!
#	mathfunc = mathfunc / 100
#	return mathfunc #Fall
	return float(WindArray[Hour])
static func GetThermalDischargeRate(Hour: float) -> float:
	if (Hour <= (546 * 4)): #Winter
		return winter_discharge

	if (Hour <= (1092 * 4)): #Spring
		return spring_discharge
		

	if (Hour <= (1638 * 4)): #Summer
		return summer_discharge

	if (Hour <= (2184 * 4)): #fall
		return fall_discharge
	print("Discharge rate fuckup")
	return 0 #Fuckup
	
static func WindPower(Hour: float) -> float:
	return Wind(Hour) * WindCapacity
	
static func GetGasTurbineCapacity() -> float:
	#var naturalturbinecapacity = 1 - SFRNuclearCapacity - LWRNuclearCapacity - CoalCapacity - (HydroElectricPower * 0.33)
	#var secondcyclecapacity = naturalturbinecapacity * ((1 - GasTurbineEfficiency) * 0.4) / GasTurbineEfficiency
	#if (secondcyclecapacity >= (ThermalBatterySteamCapacity - SFRNuclearCapacity)):
	#	secondcyclecapacity = ThermalBatterySteamCapacity - SFRNuclearCapacity
	#return (naturalturbinecapacity * (naturalturbinecapacity / (naturalturbinecapacity + secondcyclecapacity))) - RationedPower
	return 1 - RationedPower
	

static func RedundantDemandMod(Hour: float, seasonal_modifier: float) -> float:
	var TrueHour = Hour - seasonal_modifier
	var mathfunc = (sin((TrueHour * PI/168)+cos(TrueHour)) * sin((PI * TrueHour/12) + 6) * 30) + 70
	mathfunc = mathfunc / 100
	return mathfunc * 0.5

static func TotalGeneration(Hour: float) -> float:
		var AvgDistance =  sqrt((LandUse() * 200)/3.14) * 0.66 #For transmission loss
		AvgDistance = AvgDistance + (60 * (CoalCapacity + LWRNuclearCapacity + SFRNuclearCapacity + GetGasTurbineCapacity()))
		AvgDistance = AvgDistance / 2
		#print(str(AvgDistance) + "#2")
		var loss = 0.067 * (AvgDistance / 1000) #Typical AC transmission loss, the distances aren't long enough to justify HVDC in this world
		var hydroloss = 0.067 * (HydroElectricResourceDistance / 1000)
		var coalthrottle = 0
		
		var nonhydro = ((SolarPower(Hour) + WindPower(Hour) + LWRNuclearCapacity + SFRNuclearCapacity + minimum_gas(Hour) + (minimum_gas(Hour) * ((0.4 * (1 - GasTurbineEfficiency)) / GasTurbineEfficiency))) * (1 - loss))
		
		if ((NetGenIntegralStorage[Hour - 1]) < (0.9 * (BatteryCapacity + 0.1 + (10 * HydroElectricPower)))):
			if(NetGenIntegralStorage[Hour - 1]) >= (0.7 * (BatteryCapacity + 0.1 + (10 * HydroElectricPower))):
				coalthrottle = 1 - (WindPower(Hour) + SolarPower(Hour))
			else:
				coalthrottle = 1
		else:
			coalthrottle = 0.5
		if (coalthrottle > oldcoalthrottle + 0.1):
			coalthrottle = oldcoalthrottle + 0.1
		if (coalthrottle < oldcoalthrottle - 0.1):
			coalthrottle = oldcoalthrottle - 0.1
			
		oldcoalthrottle = coalthrottle
		CoalGenIntegralStorage[Hour] = coalthrottle * CoalCapacity
		var hydro = HydroPower(Hour) * (1 - hydroloss)
		return hydro + nonhydro + (coalthrottle * CoalCapacity)
static var DupeSum = 0
static func ComputeDemand(): #Absolutely broken for the time being, do not use!
	DupeSum = 0
	var shiftme = 0
	var Hour = 0
	
	for i in range(0, 8759):
		DupeArray[i] = DemandArray[i]
		virtualstorageintegral[i] = 0
		lostpotentialarray[i] = 0
	DupeArray[0] = DemandArray[0]
	DupeSum = 0
	while (Hour < 8759):
		Hour = Hour + 1
		if ((LWRNuclearCapacity + SFRNuclearCapacity + SolarPower(Hour) + WindPower(Hour)) > float(DemandArray[Hour])):
			shiftme = (LWRNuclearCapacity + SFRNuclearCapacity + SolarPower(Hour) + WindPower(Hour)) - float(DemandArray[Hour])
		if(shiftme >= (flexibledemandfraction * float(DemandArray[Hour]))):
			shiftme = flexibledemandfraction * float(DemandArray[Hour])
		virtualstorageintegral[Hour] = virtualstorageintegral[Hour - 1] + shiftme
		#DupeArray[Hour] = float(DupeArray[Hour]) - virtualstorageintegral[Hour]
		if ((LWRNuclearCapacity + SFRNuclearCapacity + SolarPower(Hour) + WindPower(Hour)) < float(DemandArray[Hour])):
			var antifraction = 1 - flexibledemandfraction
			DupeArray[Hour] = float(DupeArray[Hour]) - virtualstorageintegral[Hour]
			if(DupeArray[Hour] < float(DemandArray[Hour]) * antifraction):
				DupeArray[Hour] = float(DemandArray[Hour]) * antifraction
			virtualstorageintegral[Hour] = virtualstorageintegral[Hour] - (float(DemandArray[Hour]) - float(DupeArray[Hour]))
		
		if(Hour > demandflexibilitytimelimit):
			if(0 < virtualstorageintegral[Hour - 12] && virtualstorageintegral[Hour - 12] < 12):
				lostpotentialarray[Hour - demandflexibilitytimelimit] = virtualstorageintegral[Hour - demandflexibilitytimelimit]
				virtualstorageintegral[Hour] = virtualstorageintegral[Hour] - virtualstorageintegral[Hour - demandflexibilitytimelimit]
		if(virtualstorageintegral[Hour] < 0):
			virtualstorageintegral[Hour] = 0
		#DupeArray[Hour - demandflexibilitytimelimit] = float(DupeArray[Hour - demandflexibilitytimelimit]) - lostpotentialarray[Hour - demandflexibilitytimelimit]
		DupeArray[Hour] = float(DupeArray[Hour]) + shiftme
		DupeSum = DupeSum + DupeArray[Hour]
	
static func DemandMod(Hour: float) -> float:
#	var seasonal_modifier = 0
#	if (Hour <= (546 * 4)): #Winter
#		seasonal_modifier = 7

#	if (Hour <= (1092 * 4) && Hour > (546 * 4)): #Spring
#		seasonal_modifier = 3
#		
#	if (Hour <= (1638 * 4) && Hour > (1092 * 4)): #Summer
#		seasonal_modifier = 0
#
#	if (Hour <= (2184 * 4) && Hour > (1638 * 4)): #fall
#		seasonal_modifier = 5

#	var TrueHour = Hour
#	var mathfunc = (sin((TrueHour * PI/168)+cos(TrueHour)) * sin((PI * TrueHour/12) + 6) * 30) + 70
#	mathfunc = mathfunc / 100
	#return (RedundantDemandMod(Hour, seasonal_modifier)) + (mathfunc * 0.5)
	return float(DemandArray[Hour]) - (Solar(Hour) * DistributedSolarCapacity)
	#return 1
	
static func DemandMod_B(Hour: float) -> float:
#	var seasonal_modifier = 0
#	if (Hour <= (546 * 4)): #Winter
#		seasonal_modifier = 7

#	if (Hour <= (1092 * 4) && Hour > (546 * 4)): #Spring
#		seasonal_modifier = 3
#		
#	if (Hour <= (1638 * 4) && Hour > (1092 * 4)): #Summer
#		seasonal_modifier = 0
#
#	if (Hour <= (2184 * 4) && Hour > (1638 * 4)): #fall
#		seasonal_modifier = 5

#	var TrueHour = Hour
#	var mathfunc = (sin((TrueHour * PI/168)+cos(TrueHour)) * sin((PI * TrueHour/12) + 6) * 30) + 70
#	mathfunc = mathfunc / 100
	#return (RedundantDemandMod(Hour, seasonal_modifier)) + (mathfunc * 0.5)
	return float(DemandArray[Hour])
	#return 0.7

static var DemandCF = 0
static func GetDemandCF() -> float:
	if (DemandCF == 0):
		var i = 0
		var integral = 0
		while (i < 2184 * 4):
			i = i + 1
			integral = integral + DemandMod_B(i)
		DemandCF = integral / (2184 * 4 * 1)
		#print(DemandCF)
		return DemandCF
	else:
		#print(DemandCF)
		return DemandCF
		
static func LandUse() -> float:
	return  40 * ((0.03 * (LWRNuclearCapacity + SFRNuclearCapacity + ThermalBatterySteamCapacity + GetGasTurbineCapacity())) + (1.2 + CoalCapacity) + (9.6 * SolarCapacity) + (29 * WindCapacity))
	
static func GridSize() -> float: #Assume transmission is 1.25 kw/km, source https://energy.utexas.edu/sites/default/files/UTAustin_FCe_TransmissionCosts_2017.pdf page 7
	#var AvgDistance =  (2 * sqrt((LandUse() * 20) / 3.14)) / 3 WRONG
	var AvgDistance =  sqrt((LandUse() * 200)/3.14) * 0.66 #For transmission loss
	AvgDistance = AvgDistance + (60 * (CoalCapacity + LWRNuclearCapacity + SFRNuclearCapacity + GetGasTurbineCapacity()))
	AvgDistance = AvgDistance / 2
	#print(str(AvgDistance) + "#3")
	var GwSize = SolarCapacity + WindCapacity + ThermalBatterySteamCapacity + LWRNuclearCapacity + GetGasTurbineCapacity() + CoalCapacity
	if (GwSize >= 1):
		GwSize = 1 + (0.2 * ((SolarCapacity + WindCapacity + ThermalBatterySteamCapacity + LWRNuclearCapacity + GetGasTurbineCapacity() + CoalCapacity) - 1))
	if (GwSize <= 1):
		GwSize = 1
	return AvgDistance * GwSize #In kilowatt-kilometers
static func HydrogenGridSize() -> float:
	var AvgDistance =  sqrt((LandUse() * 200)/3.14) * 0.66 #For transmission loss
	AvgDistance = AvgDistance + (60 * (CoalCapacity + LWRNuclearCapacity + SFRNuclearCapacity + GetGasTurbineCapacity()))
	AvgDistance = AvgDistance / 2
	#print(str(AvgDistance) + "#4")
	var GwSize = ElectrolyzerCapacity
	if (GwSize <= GasCapacity):
		GwSize = GasCapacity
	return AvgDistance * GwSize
static var oldcoalthrottle = 0

static func NetGeneration(Hour: float) -> float:
		return TotalGeneration(Hour) - DemandMod(Hour)
# Called when the node enters the scene tree for the first time.
static func ThermGeneration(Hour: float) -> float:
	var ThermalRelease = 0
	ThermalRelease = -1 * NetGeneration(Hour)
	if (ThermalRelease <= 0):
		ThermalRelease = 0
	
	if (ThermalRelease >= (GetThermalDischargeRate(Hour) * (ThermalBatterySteamCapacity - SFRNuclearCapacity))):
		ThermalRelease = (GetThermalDischargeRate(Hour) * (ThermalBatterySteamCapacity - SFRNuclearCapacity))
	
	return ThermalRelease

static func ActualRelease(Hour: float) -> float:
	var thing = 0
	if (NetGenIntegralStorageThermal[Hour] >= ThermGeneration(Hour)):
		thing = ThermGeneration(Hour)
		return thing
	if (NetGenIntegralStorageThermal[Hour] < ThermGeneration(Hour)):
		thing = NetGenIntegralStorageThermal[Hour]
		return thing
	return 0
static var usedupsteam = 0
static func SmartBackup(Hour: float) -> float: #MAKE SURE THIS IS ONLY <FUCKING> CALLED ONCE AND WITHIN BACKUPGENERATION FNCTION
	var SmartBackup = SmartDispatch(Hour)
	if (SmartDispatch(Hour) <= NetGenIntegralStorageThermal[Hour]):
		SmartBackup = SmartDispatch(Hour) - ThermalBatterySteamCapacity
	if (SmartBackup <= 0):
		SmartBackup = 0
	usedupsteam = SmartDispatch(Hour) - SmartBackup
	NetGenIntegralStorageThermal[Hour] = NetGenIntegralStorageThermal[Hour] - usedupsteam
	return SmartBackup
	
static func BackupGeneration(Hour: float) -> float:
	var secondcyclecapacity = GetGasTurbineCapacity() * ((1 - GasTurbineEfficiency) * 0.4) / GasTurbineEfficiency
	if (secondcyclecapacity >= (ThermalBatterySteamCapacity - (SFRNuclearCapacity + usedupsteam))):
		secondcyclecapacity = ThermalBatterySteamCapacity - (SFRNuclearCapacity + usedupsteam)
	usedupsteam = 0
	if(secondcyclecapacity <= 0):
		secondcyclecapacity = 0
	var thing = 0
	if (NetGeneration(Hour) < 0):
		if (NetGeneration(Hour) + ActualRelease(Hour) < 0):
			thing = (-1 * NetGeneration(Hour)) - ActualRelease(Hour)
	#print(SmartBackup(Hour))
	GasTurbineThrottle[Hour] = thing
	RationedPower = 1 - GasTurbineThrottle.max()
	#print(RationedPower)
	if (NetGenIntegralStorage[Hour] > 0):
		thing = SmartBackup(Hour)
	var sexgas = 0
	if (thing > GetGasTurbineCapacity() + secondcyclecapacity):
		RationPowerTracker = RationPowerTracker + (thing - (GetGasTurbineCapacity() + secondcyclecapacity))
		thing = GetGasTurbineCapacity() + secondcyclecapacity
	GasSecondaryEnergy = (((1 - GasTurbineEfficiency) * 0.4) / GasTurbineEfficiency) * thing
	if (GasSecondaryEnergy >= (ThermalBatterySteamCapacity - SFRNuclearCapacity)):
		GasSecondaryEnergy = (ThermalBatterySteamCapacity - SFRNuclearCapacity)

	if (GasSecondaryEnergy <= ActualRelease(Hour)):
		NetGenIntegralStorageThermal[Hour] = NetGenIntegralStorageThermal[Hour] + GasSecondaryEnergy
	else:
		NetGenIntegralStorageThermal[Hour] + ActualRelease(Hour)
	SecondCycleGraphStorage[Hour] = GasSecondaryEnergy
	if(SecondCycleGraphStorage[Hour] > secondcyclecapacity):
		SecondCycleGraphStorage[Hour] = secondcyclecapacity
	thing = thing * (thing / (thing + GasSecondaryEnergy + 0.00001))
	if (thing <= 0):
		thing = 0
	GasTurbineThrottle[Hour] = GasTurbineThrottle[Hour] - SecondCycleGraphStorage[Hour]
	return thing

static func minimum_gas(Hour: float):
		var non_storage_steam = (Steam_Base_Throttle(Hour) - SFRNuclearCapacity)
		if (NetGenIntegralStorageThermal[Hour] > 0 && NetGenIntegralStorageThermal[Hour] <= (Steam_Base_Throttle(Hour) - SFRNuclearCapacity)):
			non_storage_steam = non_storage_steam - NetGenIntegralStorageThermal[Hour]
			#NetGenIntegralStorageThermal[Hour] = 0
		if (NetGenIntegralStorageThermal[Hour] > 0 && NetGenIntegralStorageThermal[Hour] > (Steam_Base_Throttle(Hour) - SFRNuclearCapacity)):
			non_storage_steam = 0
		var returnme = (((1 - GasTurbineEfficiency) * 0.4) / 0.4) * ((1 * non_storage_steam))
		if(returnme <= 0):
			returnme = 0
		mingasarray[Hour] = returnme
		return returnme
static func DoNetGenIntegral() -> void:
	var i = 1
	var thermalisfull = 0
	var batteryisfull = 0
	var hydrogenisfull = 0
	var SMRCurtailmentTotal = 0
	thermalisfull = 0
	batteryisfull = 0
	hydrogenisfull = 0
	Hydroproduction = 0
	RationPowerTracker = 0
	var SFRHeat
	#var defaultmingas = minimum_gas
	var lol = 1 #zero out the thermal and hydrogen integrals, they are kinda sussy
	SMRTotal = 0
	while (lol <= 2184*4):
		NetGenIntegralStorageThermal[lol] = 0
		HydrogenIntegral[lol] = 0
		lol = lol + 1
	while (i <= 2184*4):
		#print(Steam_Base_Throttle(i))
		SFRHeat = (SFRNuclearCapacity - (1 * Steam_Base_Throttle(i))) / SFRNuclearCapacity
		if (SFRHeat < 0):
			SFRHeat = 0
		if (SFRNuclearCapacity <= 0):
			SFRHeat = 0
		#minimum_gas = (((1 - GasTurbineEfficiency) * 0.4) / 0.4) * ((ThermalBatterySteamCapacity * Steam_Base_Throttle(i)) - SFRNuclearCapacity)
		#if (minimum_gas(i) <= 0):
		#	minimum_gas = 0
		#if (minimum_gas >= (ThermalBatterySteamCapacity - SFRNuclearCapacity)):
		#	minimum_gas = ThermalBatterySteamCapacity - SFRNuclearCapacity
		#var additionalstoredsteam = 0
		#if (NetGenIntegralStorageThermal[i - 1] > 0):
		#	#minimum_gas = 0
		#	additionalstoredsteam = NetGenIntegralStorageThermal[i - 1]
		#	if (additionalstoredsteam > (ThermalBatterySteamCapacity - SFRNuclearCapacity)):
		#		additionalstoredsteam = (ThermalBatterySteamCapacity - SFRNuclearCapacity)
		#NetGenIntegralStorageThermal[i] = NetGenIntegralStorageThermal[i] - additionalstoredsteam
	#	minimum_gas = minimum_gas - additionalstoredsteam
		NetGenIntegralStorage[i] = NetGeneration(i) + NetGenIntegralStorage[i - 1] - (SFRNuclearCapacity * SFRHeat)
		NetGenIntegralStorage[i] = NetGenIntegralStorage[i] + SmartDispatch(i)
		var ThermalSpecificGeneration = 0
		if (NetGeneration(i) <= (SFRNuclearCapacity * SFRHeat)):
			ThermalSpecificGeneration = NetGeneration(i)
		else:
			ThermalSpecificGeneration = SFRNuclearCapacity * SFRHeat
		if (ThermalSpecificGeneration <= 0):
			ThermalSpecificGeneration = 0
		
		ThermalSpecificGeneration = ThermalSpecificGeneration
		NetGenIntegralStorageThermal[i] = ThermalSpecificGeneration + NetGenIntegralStorageThermal[i - 1]
		NetGenIntegralStorageThermal[i] = NetGenIntegralStorageThermal[i] * (1 - Minutelyloss)
		
		if (NetGenIntegralStorage[i] >= (BatteryCapacity + 0.1 + (10 * HydroElectricPower))):
			NetGenIntegralStorageThermal[i] =  NetGenIntegralStorageThermal[i] + ((NetGenIntegralStorage[i] - (BatteryCapacity + 0.1 + (10 * HydroElectricPower))) * 0.4)
			NetGenIntegralStorage[i] = (BatteryCapacity + 0.1 + (10 * HydroElectricPower))
			batteryisfull = 1
		var curtailment = 0
		var SMRCurtailment = 0
		HydrogenIntegral[i] = (SteamReformer * 1) + HydrogenIntegral[i - 1]
		if (NetGenIntegralStorageThermal[i] >= ThermalBatteryCapacity):
			var hydrogenpotential = ((NetGenIntegralStorageThermal[i] - ThermalBatteryCapacity) / 0.4)
			curtailment = hydrogenpotential
			if (hydrogenpotential >= ElectrolyzerCapacity):
				hydrogenpotential = ElectrolyzerCapacity
			var heatshare = hydrogenpotential * 0.333
			var powershare = hydrogenpotential * 0.666
			if (heatshare >= SFRNuclearCapacity * SFRHeat):
				heatshare = SFRNuclearCapacity * SFRHeat
			powershare = heatshare * 2
			HydrogenIntegral[i] = (((1.5 * heatshare) + (0.7 * powershare)) * GasTurbineEfficiency) + HydrogenIntegral[i]
			HydrogenIntegral[i] = HydrogenIntegral[i] + ((0.7 * hydrogenpotential - (heatshare + powershare)) * GasTurbineEfficiency)
			#Hydroproduction = (((1.5 * heatshare) + (0.7 * powershare)) * GasTurbineEfficiency) + Hydroproduction
			#Hydroproduction = Hydroproduction + ((0.7 * hydrogenpotential - (heatshare + powershare)) * GasTurbineEfficiency)
			NetGenIntegralStorageThermal[i] = ThermalBatteryCapacity
			thermalisfull = 1
		if (Hydroproduction <= 0):
			Hydroproduction = 0
		#print(HydrogenIntegral[i])
		#print(HydrogenStorage)
		if (BackupGeneration(i) >= GetGasTurbineCapacity() * CCSFraction):
			var starter = 0
			HydrogenIntegral[i] = HydrogenIntegral[i] - ((BackupGeneration(i) + minimum_gas(i)) - (((GetGasTurbineCapacity()) * CCSFraction)))
			if (HydrogenIntegral[i] < 0):
				starter = HydrogenIntegral[i]
				if(starter > 0):
					starter = 0
				HydrogenIntegral[i] = 0
			var Hydrogenburner = (BackupGeneration(i) + minimum_gas(i)) - (GetGasTurbineCapacity() * CCSFraction)
			if(Hydrogenburner < 0):
				Hydrogenburner = 0
			Hydroproduction = Hydrogenburner + Hydroproduction + starter
		SMRCurtailment = 0
		#print("At least you have this")
		var overstep = HydrogenIntegral[i] - HydrogenStorage
		if (overstep <= 0):
			overstep = 0
		if (HydrogenIntegral[i] > HydrogenStorage):
			HydrogenIntegral[i] = HydrogenStorage
		Hydroproduction = Hydroproduction - overstep
		SMRCurtailment = overstep
		if (SMRCurtailment >= SteamReformer):
			SMRCurtailment = SteamReformer
		hydrogenisfull = 1
		SMRCurtailmentTotal = SMRCurtailment + SMRCurtailmentTotal
		#if(SMRCurtailment != 0):
			#print(SMRCurtailment)
		if (NetGenIntegralStorage[i] <= 0):
			NetGenIntegralStorageThermal[i] = NetGenIntegralStorageThermal[i] - ActualRelease(i)
		
		if (NetGenIntegralStorage[i] <= 0):
			NetGenIntegralStorage[i] = 0

			
		if (NetGenIntegralStorageThermal[i] <= 0):
			NetGenIntegralStorageThermal[i] = 0
		if (NetGenIntegralStorageThermal[i] > 0 && NetGenIntegralStorageThermal[i] > (Steam_Base_Throttle(i) - SFRNuclearCapacity)):
			if ((Steam_Base_Throttle(i) - SFRNuclearCapacity) > 0):
				NetGenIntegralStorageThermal[i] = NetGenIntegralStorageThermal[i] - (Steam_Base_Throttle(i) - SFRNuclearCapacity)
		if (NetGenIntegralStorageThermal[i] > 0 && NetGenIntegralStorageThermal[i] <= (Steam_Base_Throttle(i) - SFRNuclearCapacity)):
			#non_storage_steam = non_storage_steam - NetGenIntegralStorageThermal[i]
			NetGenIntegralStorageThermal[i] = 0

		if (batteryisfull == 1 && thermalisfull == 1):
			#print("Nuclear load following time >:)")
			curtailment = curtailment - ElectrolyzerCapacity
			if (curtailment <= 0):
				curtailment = 0
			if (curtailment >= ((LWRNuclearCapacity) * 0.75)):
				curtailment = (LWRNuclearCapacity)
			NukeCurtailments[i] = curtailment
		else:
			NukeCurtailments[i] = 0
		curtailment = 0
		i = i + 1
	SMRcapacityfactor = ((2184*SteamReformer*4) - SMRCurtailmentTotal) / (2184*(SteamReformer+0.000000001)*4)
	#print("SMR Capacity factor: " + str(SMRcapacityfactor))
	i = 0
	pass
	
static func GetHydrogenIntegral(i: float) -> float:
	return HydrogenIntegral[i]

static func DistributedYearlyCost():
	var capex = (DistributedSolarCapex * DistributedSolarCapacity)

static var CCSCF = 0
static var UnadulteratedIntensityCO2 = 0
static var UnadulteratedScrubbedCO2 = 0
static func DoCO2Integral() -> void:
	var AvgDistance =  sqrt((LandUse() * 200)/3.14) * 0.66 #For transmission loss
	AvgDistance = AvgDistance + (60 * (CoalCapacity + LWRNuclearCapacity + SFRNuclearCapacity + GetGasTurbineCapacity()))
	AvgDistance = AvgDistance / 2
	#print(str(AvgDistance) + "#1")
	var loss = 0.035 * (AvgDistance / 1000)
	var fullusescrubber = 540 * 2184*4 * (GetGasTurbineCapacity() * CCSFraction)
	var i = 1
	ScrubbedCO2 = 0
	UnadulteratedScrubbedCO2 = 0
	while (i <= 2184*4):
		var GasGeneration = BackupGeneration(i) + minimum_gas(i)
		var delta = GasGeneration - previous_gas_storage
		if (previous_gas_storage <= 0.1):
			previous_gas_storage = 0.1
		delta = abs(delta) / previous_gas_storage
		previous_gas_storage = GasGeneration
		if (delta <= 0.25):
			delta = 0.25
		delta = delta * 0.65
		CO2GenIntegralStorage[i] = GasGeneration * 497 * (1 + delta)
		if (GasGeneration <= (GetGasTurbineCapacity()) * CCSFraction):
			ScrubbedCO2 = ScrubbedCO2 + (GasGeneration * 497) * (1 + delta)
			UnadulteratedScrubbedCO2 = UnadulteratedScrubbedCO2 + (GasGeneration * 497) * (1 + delta)
			ScrubbedCO2 = ScrubbedCO2 + (497 * SteamReformer * SMRcapacityfactor)
		else:
			UnadulteratedScrubbedCO2 = UnadulteratedScrubbedCO2 + (497 * (GetGasTurbineCapacity()) * CCSFraction) * (1 + delta)
			ScrubbedCO2 = ScrubbedCO2 + (497 * SteamReformer * SMRcapacityfactor)
			ScrubbedCO2 = ScrubbedCO2 + (497 * (GetGasTurbineCapacity()) * CCSFraction) * (1 + delta)
		i = i + 1
	CCSCF = ScrubbedCO2 / fullusescrubber
	print(CCSCF)
	if(CCSCF > 1):
		CCSCF = 1
	D.CCSinjectioncost = ((1 - D.CCSinjectionfixed) * D.BaseCCSinjectioncost) + (((D.CCSinjectionfixed) * (1 / CCSCF)) * D.BaseCCSinjectioncost)
	print(D.CCSinjectioncost)
	if(CCSFraction == 0):
		CCSCF = 1
		D.CCSinjectioncost = 0
	i = 0
	IntensityCO2 = CO2GenIntegralStorage.reduce(func(acc, num): return acc + num) + (497 * SteamReformer * SMRcapacityfactor)
	IntensityCO2 = IntensityCO2 / (2184 * 4)
	IntensityCO2 = IntensityCO2 / (1 - loss)
	IntensityCO2 = IntensityCO2 - (494 * RealBiogasFraction)
	
	UnadulteratedIntensityCO2 = CO2GenIntegralStorage.reduce(func(acc, num): return acc + num)
	UnadulteratedIntensityCO2 = UnadulteratedIntensityCO2 / (2184 * 4)
	UnadulteratedIntensityCO2 = UnadulteratedIntensityCO2 / (1 - loss)
	UnadulteratedIntensityCO2 = UnadulteratedIntensityCO2 - (494 * RealBiogasFraction)
	if (IntensityCO2 <= 0):
		UnusedBiogas = -1 * IntensityCO2
		IntensityCO2 = 0
	pass

static func GetCAPEX() -> float:
	var ScrubbedEmissions = UnadulteratedScrubbedCO2 / (2184 * 4)
	var UnscrubbedEmissions = UnadulteratedIntensityCO2 - (UnadulteratedScrubbedCO2 / (2184 * 4))
	var hydrofraction = (Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions + 0.00001) / 494)
	if (hydrofraction > 1):
		hydrofraction = 1
	HyroTurbineCostAdd = (1 - CCSFraction) * HyroTurbineCostAdd
	var RealGasCapex = GasCapex * (1 + (HyroTurbineCostAdd * hydrofraction))
	var TotalCapacity = (WindCapacity + SolarCapacity + GetGasTurbineCapacity() + LWRNuclearCapacity + ThermalBatterySteamCapacity) + (ElectrolyzerCapacity * 0.5)
	var payfraction = Global.T_INVESTSUBSIDY
	var GubmentGibs = ((LWRNuclearCapacity * D.LWRCapex) + (SFRNuclearCapacity * D.SFRCapex) + (BatteryCapacity * D.BatteryCapex)) * payfraction
	
	return (HVDCCapex * GridSize()) + (HVDCCapex * HydroElectricPower * HydroElectricResourceDistance) + ((TotalCapacity + HydroElectricPower) * Interconnectcost) + (HPIPECapex * HydrogenGridSize()) + (CoalCapacity * CoalCapex) + (SteamReformer * SteamReformerCapex) + (HydrogenStorage * HydrogenStorageCost) + (D.SolarCapex * SolarCapacity) + (D.ElectrolyzerCapex * ElectrolyzerCapacity) + (D.WindCapex * WindCapacity) + (ThermalStorageCapex * ThermalBatteryCapacity) + (HydroElectricPower * HydroElectricCapex) + (D.BatteryCapex * BatteryCapacity) + (D.LWRCapex * LWRNuclearCapacity) + (D.SFRCapex * SFRNuclearCapacity) + (SteamCapex * ThermalBatterySteamCapacity) + ((RealGasCapex * GetGasTurbineCapacity()) * (1 + (CCScostModifier * CCSFraction))) - GubmentGibs
#Thermalsteam capacity is 2100 because 1800 steam plant + 300 boiler so its firm power
static func GetCAPEX80() -> float:
	var ScrubbedEmissions = UnadulteratedScrubbedCO2 / (2184 * 4)
	var UnscrubbedEmissions = UnadulteratedIntensityCO2 - (UnadulteratedScrubbedCO2 / (2184 * 4))
	var hydrofraction = (Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions + 0.00001) / 494)
	HyroTurbineCostAdd = (1 - CCSFraction) * HyroTurbineCostAdd
	var RealGasCapex = GasCapex * (1 + (HyroTurbineCostAdd * hydrofraction))
	var TotalCapacity = (WindCapacity + SolarCapacity + GetGasTurbineCapacity() + LWRNuclearCapacity + ThermalBatterySteamCapacity) + (ElectrolyzerCapacity * 0.5)
	if (hydrofraction > 1):
		hydrofraction = 1
	var payfraction = Global.T_INVESTSUBSIDY
	var GubmentGibs = ((LWRNuclearCapacity * D.LWRCapex) + (SFRNuclearCapacity * D.SFRCapex) + (BatteryCapacity * D.BatteryCapex)) * payfraction
	return (1.75 * ((HVDCCapex * GridSize()) + (HVDCCapex * HydroElectricPower * HydroElectricResourceDistance) + (HPIPECapex * HydrogenGridSize()) + (D.SolarCapex * SolarCapacity) + (D.ElectrolyzerCapex * ElectrolyzerCapacity) + (D.WindCapex * WindCapacity) + (D.BatteryCapex * BatteryCapacity))) + ((HydrogenStorage * HydrogenStorageCost) + (ThermalStorageCapex * ThermalBatteryCapacity) + (CoalCapacity * CoalCapex) + (D.LWRCapex * LWRNuclearCapacity) + (HydroElectricPower * HydroElectricCapex) + ((TotalCapacity + HydroElectricPower) * Interconnectcost) + ((RealGasCapex * GetGasTurbineCapacity()) * (1 + (CCScostModifier * CCSFraction))) + (D.SFRCapex * SFRNuclearCapacity) + (SteamCapex * ThermalBatterySteamCapacity) + (SteamReformer * SteamReformerCapex) * 1.5) - GubmentGibs

#source: https://www.statista.com/statistics/519144/power-plant-operation-and-maintenance-costs-in-the-us-by-technology/
static func GetAverageNukeCurtailments() -> float:
	var i = 0
	var counter = 0
	while (i <= 4*2184):
		i = i + 1
		counter = counter + NukeCurtailments[i]
	return counter / (4*2184)
	
static func GetYearlyBiogasCost():
	var biogasuse = (494 * RealBiogasFraction) - UnusedBiogas
	#print(biogasuse / 494)
	if (biogasuse < 0):
		biogasuse = 0
	var biopercent = biogasuse / 494
	var yearlybiocost = ((BiogasCost / 293) * 8760) / GasTurbineEfficiency
	return yearlybiocost * (biogasuse / 494)

static func YearlyOpEX() -> float:
	var nuclearloadsaving = GetAverageNukeCurtailments() * uraniumyearlycost
	var SMRFraction = (SteamReformer * (2184 * 4) * GasTurbineEfficiency) / (Hydroproduction + 0.0000001)
	var NewHydrogenMBtuHandlingCost = HydrogenMBtuHandlingCost + ((((80  * 297) / 0.7) / D.Electrolyzerlifespan) * (1 - SMRFraction))
	var ScrubbedEmissions = UnadulteratedScrubbedCO2 / (2184 * 4)
	var UnscrubbedEmissions = UnadulteratedIntensityCO2 - (UnadulteratedScrubbedCO2 / (2184 * 4))
	var hydrofraction = (Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions + 0.00001) / 494)
	HydroKWY = ((HydrogenMBtuHandlingCost / 293) * 8760) / GasTurbineEfficiency
	var fixed = (HVDCOM * GridSize()) + (BatteryCapacity * D.BatteryOM) + (HVDCOM * HydroElectricPower * HydroElectricResourceDistance) + (SteamReformer * SteamReformerOM) + (HydroElectricOM * HydroElectricPower) + ((SteamReformer * GasKWY * SMRcapacityfactor) / 0.7) + (ElectrolyzerOM * ElectrolyzerCapacity ) + (D.LWROM * LWRNuclearCapacity) + (D.SFROM * SFRNuclearCapacity) + (SteamOpex * ThermalBatterySteamCapacity) + (D.SolarOM * SolarCapacity) + (D.WindOM * WindCapacity) + (CoalCapacity * CoalOM) + (GasOM * (GetGasTurbineCapacity()) * (1 + (D.CCSOMMod * CCSFraction)))
	#var replacements = ((D.WindOMCapex * WindCapacity) / Windlifespan) + ((D.D.SolarCapex * SolarCapacity) / Solarlifespan) + ((D.LWRCapex * LWRNuclearCapacity) / LWRLifespan) + ((D.BatteryCapex * BatteryCapacity) / Batterylifespan) + ((SFRNuclearCapacity * LWRNuclearCapacity) / LWRLifespan) + ((SteamCapex * ThermalBatterySteamCapacity) / Steamlifespan) + ((ThermalStorageCapex * ThermalBatteryCapacity) / ThermalStoragelifespan) + ((GasCapex * GasCapacity) / GasLifespan) + ((D.ElectrolyzerCapex * ElectrolyzerCapacity) / D.Electrolyzerlifespan)
	#replacements = replacements * 0.66 #Replacing an existing plant is cheaper since existing stuff in place
	#var variable = (((IntensityCO2 / GetDemandCF()) / 490) * (220 * (1 + (0.2 * CCSFraction)))) + ((ScrubbedCO2/ (2184 * 60)) * 1.2 * (120 / 1000000) * 1.2 * 8600 * 0.6942) #Dollars A kilowatt year, 1.2x carbon capture price since carbon capture gas needs 1.2x more fuel
	var scrubfraction = (ScrubbedCO2 / (2184 * 4)) / (IntensityCO2 + 0.00000000001)
	var dirtyfraction = 1 - scrubfraction
	var variable = (scrubfraction * GasKWY * 1.4) + (dirtyfraction * (1 - hydrofraction) * GasKWY) + (dirtyfraction * hydrofraction * HydroKWY)
	variable = variable * (IntensityCO2 / 494)
	variable = variable + (((ScrubbedCO2 / (2184 * 4)) * D.CCSinjectioncost * 1.4 * 8760 * GetDemandCF()) / 1000000)
	fixed = fixed + (PowerRationIncentive * (RationPowerTracker / (2184 * 4)))
	#print(nuclearloadsaving)
	return fixed + variable - nuclearloadsaving + GetYearlyBiogasCost() # + replacements
	
static func YearlyOpEX40() -> float:
	var nuclearloadsaving = GetAverageNukeCurtailments() * uraniumyearlycost
	var i = 0
	var gasintegral = 0
	while (i <= 40):
		gasintegral = D.gaspricefunction(i) + gasintegral
		i = i + 1
	var gascostmultiplier = (gasintegral / 40) / GasMBtuCost
	var ActualGasKWY = gascostmultiplier * GasKWY
	var SMRFraction = (SteamReformer * (2184 * 4) * GasTurbineEfficiency) / (Hydroproduction + 0.0000001)
	var NewHydrogenMBtuHandlingCost = HydrogenMBtuHandlingCost + ((((80  * 297) / 0.7) / D.Electrolyzerlifespan) * (1 - SMRFraction))
	var ScrubbedEmissions = UnadulteratedScrubbedCO2 / (2184 * 4)
	var UnscrubbedEmissions = UnadulteratedIntensityCO2 - (UnadulteratedScrubbedCO2 / (2184 * 4))
	var hydrofraction = (Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions + 0.00001) / 494)
	HydroKWY = ((HydrogenMBtuHandlingCost / 293) * 8760) / GasTurbineEfficiency
	var fixed = (HVDCOM * GridSize()) + (HVDCOM * HydroElectricPower * HydroElectricResourceDistance) + (SteamReformer * SteamReformerOM) + (HydroElectricOM * HydroElectricPower) + ((SteamReformer * ActualGasKWY * SMRcapacityfactor) / 0.7) + (ElectrolyzerOM * ElectrolyzerCapacity ) + (D.LWROM * LWRNuclearCapacity) + (D.SFROM * SFRNuclearCapacity) + (SteamOpex * ThermalBatterySteamCapacity) + (D.SolarOM * SolarCapacity) + (D.WindOM * WindCapacity) + (GasOM * (1 - (LWRNuclearCapacity + ThermalBatterySteamCapacity + RationedPower)) * (1 + (D.CCSOMMod * CCSFraction)))
	#var replacements = ((D.WindOMCapex * WindCapacity) / Windlifespan) + ((D.D.SolarCapex * SolarCapacity) / Solarlifespan) + ((D.LWRCapex * LWRNuclearCapacity) / LWRLifespan) + ((D.BatteryCapex * BatteryCapacity) / Batterylifespan) + ((SFRNuclearCapacity * LWRNuclearCapacity) / LWRLifespan) + ((SteamCapex * ThermalBatterySteamCapacity) / Steamlifespan) + ((ThermalStorageCapex * ThermalBatteryCapacity) / ThermalStoragelifespan) + ((GasCapex * GasCapacity) / GasLifespan) + ((D.ElectrolyzerCapex * ElectrolyzerCapacity) / D.Electrolyzerlifespan)
	#replacements = replacements * 0.66 #Replacing an existing plant is cheaper since existing stuff in place
	#var variable = (((IntensityCO2 / 0.6942) / 490) * (220 * (1 + (0.2 * CCSFraction)))) + ((ScrubbedCO2/ (2184 * 60)) * 1.2 * (120 / 1000000) * 1.2 * 8600 * 0.6942) #Dollars A kilowatt year, 1.2x carbon capture price since carbon capture gas needs 1.2x more fuel
	var scrubfraction = (ScrubbedCO2 / (2184 * 4)) / (IntensityCO2 + 0.00000000001)
	var dirtyfraction = 1 - scrubfraction
	var variable = (scrubfraction * ActualGasKWY * 1.4) + (dirtyfraction * (1 - hydrofraction) * ActualGasKWY) + (dirtyfraction * hydrofraction * HydroKWY)
	variable = variable * (IntensityCO2 / 494)
	variable = variable + (((ScrubbedCO2 / (2184 * 4)) * D.CCSinjectioncost * 1.4 * 8760 * GetDemandCF()) / 1000000)
	fixed = fixed + (PowerRationIncentive * (RationPowerTracker / (2184 * 4)))
	#print(nuclearloadsaving)
	return fixed + variable - nuclearloadsaving + GetYearlyBiogasCost() # + replacements
	
static func YearlyOpEX80() -> float:
	var nuclearloadsaving = GetAverageNukeCurtailments() * uraniumyearlycost
	var i = 0
	var gasintegral = 0
	while (i <= 80):
		gasintegral = D.gaspricefunction(i) + gasintegral
		i = i + 1
	var gascostmultiplier = (gasintegral / 80) / GasMBtuCost
	var ActualGasKWY = gascostmultiplier * GasKWY
	var SMRFraction = (SteamReformer * (2184 * 4) * GasTurbineEfficiency) / (Hydroproduction + 0.0000001)
	var NewHydrogenMBtuHandlingCost = HydrogenMBtuHandlingCost + ((((80  * 297) / 0.7) / D.Electrolyzerlifespan) * (1 - SMRFraction))
	var ScrubbedEmissions = UnadulteratedScrubbedCO2 / (2184 * 4)
	var UnscrubbedEmissions = UnadulteratedIntensityCO2 - (UnadulteratedScrubbedCO2 / (2184 * 4))
	var hydrofraction = (Hydroproduction / (2184 * 4)) / ((UnscrubbedEmissions + 0.00001) / 494)
	HydroKWY = ((HydrogenMBtuHandlingCost / 293) * 8760) / GasTurbineEfficiency
	var fixed = (HVDCOM * GridSize()) + (HVDCOM * HydroElectricPower * HydroElectricResourceDistance) + (SteamReformer * SteamReformerOM) + (HydroElectricOM * HydroElectricPower) + ((SteamReformer * ActualGasKWY * SMRcapacityfactor) / 0.7) + (ElectrolyzerOM * ElectrolyzerCapacity ) + (D.LWROM * LWRNuclearCapacity) + (D.SFROM * SFRNuclearCapacity) + (SteamOpex * ThermalBatterySteamCapacity) + (D.SolarOM * SolarCapacity) + (D.WindOM * WindCapacity) + (GasOM * (1 - (LWRNuclearCapacity + ThermalBatterySteamCapacity + RationedPower)) * (1 + (D.CCSOMMod * CCSFraction)))
	#var replacements = ((D.WindOMCapex * WindCapacity) / Windlifespan) + ((D.D.SolarCapex * SolarCapacity) / Solarlifespan) + ((D.LWRCapex * LWRNuclearCapacity) / LWRLifespan) + ((D.BatteryCapex * BatteryCapacity) / Batterylifespan) + ((SFRNuclearCapacity * LWRNuclearCapacity) / LWRLifespan) + ((SteamCapex * ThermalBatterySteamCapacity) / Steamlifespan) + ((ThermalStorageCapex * ThermalBatteryCapacity) / ThermalStoragelifespan) + ((GasCapex * GasCapacity) / GasLifespan) + ((D.ElectrolyzerCapex * ElectrolyzerCapacity) / D.Electrolyzerlifespan)
	#replacements = replacements * 0.66 #Replacing an existing plant is cheaper since existing stuff in place
	#var variable = (((IntensityCO2 / GetDemandCF()) / 490) * (220 * (1 + (0.2 * CCSFraction)))) + ((ScrubbedCO2/ (2184 * 60)) * 1.2 * (120 / 1000000) * 1.2 * 8600 * 0.6942) #Dollars A kilowatt year, 1.2x carbon capture price since carbon capture gas needs 1.2x more fuel
	var scrubfraction = (ScrubbedCO2 / (2184 * 4)) / (IntensityCO2 + 0.00000000001)
	var dirtyfraction = 1 - scrubfraction
	var variable = (scrubfraction * ActualGasKWY * 1.4) + (dirtyfraction * (1 - hydrofraction) * ActualGasKWY) + (dirtyfraction * hydrofraction * HydroKWY)
	variable = variable * (IntensityCO2 / 494)
	variable = variable + (((ScrubbedCO2 / (2184 * 4)) * D.CCSinjectioncost * 1.4 * 8760 * GetDemandCF()) / 1000000)
	fixed = fixed + (PowerRationIncentive * (RationPowerTracker / (2184 * 4)))
	#print(nuclearloadsaving)
	#print(variable)
	return fixed + variable - nuclearloadsaving + GetYearlyBiogasCost() # + replacements 
static var CCSinjectioncost = 0
func _ready() -> void:
	Initiatevars()
	Minutelyloss = (ThermalStorageLossRate / 100) / (24 * 4)
	GasKWY = ((GasMBtuCost / 293) * 8760) / GasTurbineEfficiency
	HydroKWY = ((HydrogenMBtuHandlingCost / 293) * 8760) / GasTurbineEfficiency
	CCSinjectioncost = D.BaseCCSinjectioncost * ((179 / GasTurbineEfficiency) / 497)
	DemandArray = read_file_to_array(DEMANDFILE)
	DupeArray = DemandArray
	SolarArray = read_file_to_array(SOLARFILE)
	WindArray = read_file_to_array(WINDFILE)
	print("Gas KWY Value:" + str(GasKWY))
	print("Wind CF: " + str(wind_CF() * 100))
	print("Solar CF: " + str(solar_CF() * 100))
	print("Combined CF: " + str((solar_CF() + wind_CF()) * 100))
	print("Avg Demand: " + str(GetDemandCF() * 40))
	var i = 0
	while (i <= (8760) + 1):
		HydrogenIntegral.append(0)
		NetGenIntegralStorage.append(0)
		NetGenIntegralStorageThermal.append(0)
		CO2GenIntegralStorage.append(0)
		CoalGenIntegralStorage.append(0)
		SecondCycleGraphStorage.append(0)
		NonFossilThermalGeneration.append(0)
		mingasarray.append(0)
		NukeCurtailments.append(0)
		virtualstorageintegral.append(0)
		lostpotentialarray.append(0)
		GasTurbineThrottle.append(0)
		i = i + 1
		
	i = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

static func solar_CF() -> float:
	var i = 0
	var sum = 0
	while (i <= 4*2184):
		i = i + 1
		sum = sum + Solar(i)
	return sum / (4*2184)

static func wind_CF() -> float:
	var i = 0
	var sum = 0
	while (i <= 4*2184):
		i = i + 1
		sum = sum + Wind(i)
	return sum / (4*2184)
static func read_file_to_array(file_path: String) -> Array:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var lines = []
	
	if file:
		while not file.eof_reached():
			var line = file.get_line()
			if line != "":  # Avoid adding empty lines at EOF
				lines.append(line)
		file.close()
	else:
		print("Failed to open file:", file_path)
	
	return lines

static func Get_Production_Subsidy() -> float:
	var Fullsubsidy = 1.5
	var SolarSubsidy = solar_CF() * Fullsubsidy * SolarCapacity
	var WindSubsidy = wind_CF() * Fullsubsidy * SolarCapacity
	var HydroSubsidy = HydroElectricPower * 0.66 * Fullsubsidy
	return SolarSubsidy + WindSubsidy + HydroSubsidy

func _on_h_slider_value_changed(value: float) -> void:
	SolarCapacity = (value / 100) * 3
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_h_slider_2_value_changed(value: float) -> void:
	WindCapacity = (value / 100) * 3
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_h_slider_3_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_h_slider_4_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_h_slider_5_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_battery_up_button_pressed() -> void:
	BatteryCapacity = BatteryCapacity + 0.5
	pass # Replace with function body.


func _on_battery_down_button_pressed() -> void:
	BatteryCapacity = BatteryCapacity - 0.5
	pass # Replace with function body.


func _on_lwr_slider_value_changed(value: float) -> void:
	LWRNuclearCapacity = (value / 100)
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_ccs_slider_value_changed(value: float) -> void:
	CCSFraction = value / 100
	if (CCSFraction >= (1 - GasCapacity)):
		CCSFraction = 1 - GasCapacity
	#DoCO2Integral()
	pass # Replace with function body.


func _on_sfr_slider_value_changed(value: float) -> void:
	SFRNuclearCapacity = (value / 100)
	if(SFRNuclearCapacity > 0.2 * ThermalBatterySteamCapacity):
		ThermalBatterySteamCapacity = SFRNuclearCapacity + truesteam
	if(ThermalBatterySteamCapacity < SFRNuclearCapacity):
		ThermalBatterySteamCapacity = SFRNuclearCapacity
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_thermal_steam_slider_value_changed(value: float) -> void:
	ThermalBatterySteamCapacity = (value / 100)
	truesteam = ThermalBatterySteamCapacity
	ThermalBatterySteamCapacity = SFRNuclearCapacity + ThermalBatterySteamCapacity
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_therm_str_sldr_value_changed(value: float) -> void:
	ThermalBatteryCapacity = 0.3 * value
	pass # Replace with function body.


func _on_electrolyzersldr_value_changed(value: float) -> void:
	ElectrolyzerCapacity = 3 * (value / 100)
	#UpdateGraphs.emit()
	#DoNetGenIntegral()	
	#DoCO2Integral()
	pass # Replace with function body.


func _on_battery_wattage_sldr_value_changed(value: float) -> void:
	HydrogenStorage = pow(1.08, (value)) - 1
	pass # Replace with function body.


func _on_ration_slider_value_changed(value: float) -> void:
	RationedPower = (value / 100) * 1
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_smr_sldr_value_changed(value: float) -> void:
	SteamReformer = ((value / 100) * 0.7) #Only need this much SMR to be 100% hydrogen powered
	#UpdateGraphs.emit()
	#DoNetGenIntegral()	
	#DoCO2Integral()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	
	UpdateGraphs.emit()
	DoNetGenIntegral()
	DoCO2Integral()
	LAGSTATUS = "READY"
	pass # Replace with function body.


func _on_season_dschrg_1_value_changed(value: float) -> void:
	#winter_discharge = (value / 100)
	winter_discharge = 1
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_season_dschrg_2_value_changed(value: float) -> void:
	spring_discharge = 1
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_season_dschrg_3_value_changed(value: float) -> void:
	summer_discharge = 1
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_season_dschrg_4_value_changed(value: float) -> void:
	fall_discharge = 1
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_hydroelectric_sldr_value_changed(value: float) -> void:
	HydroElectricPower = (value / 100) * GetDemandCF() * (HYDROFRACTION / 0.66)
	pass # Replace with function body.


func _on_coal_sldr_value_changed(value: float) -> void:
	CoalCapacity = (value / 100) * 1
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_update_graphs() -> void:
	DemandArray = read_file_to_array(DEMANDFILE)
	ComputeDemand()
	pass # Replace with function body.


func _on_biogas_sldr_value_changed(value: float) -> void:
	RealBiogasFraction = (value / 100) * BiogasFraction
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_solar_slider_value_changed(value: float) -> void:
	SolarCapacity = (value / 100) * 3
	#UpdateGraphs.emit()
	#DoNetGenIntegral()
	#DoCO2Integral()
	pass # Replace with function body.


func _on_smr_sldr_drag_ended(value_changed: bool) -> void:
	pass # Replace with function body.


func _on_season_dschrg_4_drag_ended(value_changed: bool) -> void:
	pass # Replace with function body.


func _on_electrolyzersldr_drag_ended(value_changed: bool) -> void:
	pass # Replace with function body.


func _on_dist_solar_sldr_value_changed(value: float) -> void:
	CombinedCycleCharginess = (value / 100)
	pass # Replace with function body.
