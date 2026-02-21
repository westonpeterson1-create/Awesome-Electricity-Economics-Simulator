extends Label
const mathlib = preload("res://mathlib.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = "Location: "+str(Global.T_LOCATION)+"\n"+"Interest: "+str(Global.T_INTEREST)+"\n"+"Carbon Cost: $"+str(Global.T_CARBONCOST)+"\n"+"Period: "+str(Global.T_EVALPERIOD)+" years"+"\n"+"Cost data: "+str(Global.T_COSTDATA)+"\n"+"Investment Subsidy: "+str(Global.T_INVESTSUBSIDY*100)+"%"+"\n"+"Renewable Subsidy: "+str(Global.T_RENEWABLESUBSIDY)+" cent/kwh"


	pass
