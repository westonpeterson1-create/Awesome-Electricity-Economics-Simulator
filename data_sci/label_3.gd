extends Label

func _process(delta: float) -> void:
	self.text = "Interest: " + str(Global.T_INTEREST * 100) + "%"
	pass
