extends Area2D

var _player: Player = null

### Private Methods ###

func _check_player_position():
	var edge_tolerance = 0.5
	if (_player.position.x <= _get_right_edge() - (_player.get_size().x * edge_tolerance)) and (_player.position.x >= position.x - (_player.get_size().x * edge_tolerance)):
		if not _player._climbable:
			_player.set_climbable(true)
			print("Player can climb now!")
	else:
		print("Player not in climb range")
		if _player._climbable:
			_player.set_climbable(false)
			print("Player can't climb no more")

func _get_right_edge() -> float:
	return position.x + $CollisionShape2D.shape.get_rect().size.x

### Godot Methods ###

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player in")
		_player = body
		
func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player out")
		_player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	pass # Replace with function body.
	
	var collider_left_edge = position.x
	var collider_right_edge = collider_left_edge + $CollisionShape2D.shape.get_rect().size.x
	
	print("Climbable left edge is " + str(collider_left_edge))
	print("Climbable right edge is " + str(collider_right_edge))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _player != null:
		_check_player_position()





