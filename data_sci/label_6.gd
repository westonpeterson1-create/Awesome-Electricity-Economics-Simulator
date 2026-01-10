extends Label

func _process(delta: float) -> void:
	self.text = "Production subsidy: " + str(Global.T_RENEWABLESUBSIDY) + " cents/kwh"
	pass
