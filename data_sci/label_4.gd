extends Label

func _process(delta: float) -> void:
	self.text = "$" + str(Global.T_CARBONCOST) + " Per Ton"
	pass
