const mathlib = preload("res://mathlib.gd")


static var PeakDemand = 40
static var interestrate = 0.07
static var CO2cost = 180 #Per ton

static var SolarCapex = 400
static var SolarOM = 17
static var Solarlifespan = 40
static var BatteryCapex = 130
static var BatteryOM = 10
static var Batterylifespan = 20

static var LWRCapex = 8500
static var LWRLifespan = 80
static var LWROM = 170

static var SFRCapex = 8100 #these don't include the steam plant required to turn it into power
static var SFROM = 170

static var WindCapex = 1200
static var WindOM = 33.5
static var Windlifespan = 30

static func gaspricefunction(x: float) -> float:
	return mathlib.GasMBtuCost * pow(1.01, x)

static var CCSinjectioncost = 30
static var BaseCCSinjectioncost = 30
static var CCSinjectionfixed = 0.75
static var CCSOMMod = 1

static var ElectrolyzerCapex = 400
static var Electrolyzerlifespan = 80000
