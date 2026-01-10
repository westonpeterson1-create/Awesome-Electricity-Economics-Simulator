extends Camera2D

var currentpos
var oldmousepos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentpos = self.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed( 2 ):
		self.position = oldmousepos - get_viewport().get_mouse_position()
		currentpos = self.position
func _input( event ):
	if event is InputEventMouseButton:
		oldmousepos = currentpos + get_viewport().get_mouse_position()
	
	if (event is InputEventMouseButton && event.is_action_released("click")):
		self.position = currentpos
	if event is InputEventKey and event.pressed:
		if event.keycode == 49:
			self.position = Vector2(0, 0)
			currentpos =  Vector2(0, 0)
	if event is InputEventKey and event.pressed:
		if event.keycode == 49:
			self.position = Vector2(0, 0)
			currentpos =  Vector2(0, 0)
		if event.keycode == 50:
			self.position = Vector2((546 * 4 * 7), 0)
			currentpos =  Vector2((546 * 4 * 7), 0)
		if event.keycode == 51:
			self.position = Vector2((546 * 4 * 7 * 2), 0)
			currentpos =  Vector2((546 * 4 * 7 * 2), 0)
		if event.keycode == 52:
			self.position = Vector2((546 * 4 * 7 * 3), 0)
			currentpos =  Vector2((546 * 4 * 7 * 3), 0)
func zoom():
	if Input.is_action_just_released('MouseWheelUp'):
		set_zoom(get_zoom() + Vector2(0.1, 0.1))
	if Input.is_action_just_released('MouseWheelDown'): #and get_zoom() > Vector2.ONE:
		set_zoom(get_zoom() - Vector2(0.1, 0.1))

func _physics_process(delta):
	zoom()
