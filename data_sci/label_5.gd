extends Label

func _process(delta: float) -> void:
	self.text = "Investment subsidy: " + str(Global.T_INVESTSUBSIDY * 100) + "%"
	pass
