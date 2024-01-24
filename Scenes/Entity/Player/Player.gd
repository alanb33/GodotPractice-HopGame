class_name Player extends CharacterBody2D

var _climbable = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

### Public Methods ###

func set_climbable(mode: bool) -> void:
	self._climbable = mode
	if _climbing and mode == false:
		_climbing = false
		print("Climbing is now false")

### Private Methods ###

var _climbing = false

func _handle_climbing(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		if _climbable and not _climbing:
			_climbing = true
			print("Climbing is now true")
		if _climbing:
			position.y -= SPEED * delta
			velocity.y = 0

### Godot Methods ###

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	_handle_climbing(delta)
		
	# Add the gravity.
	if not is_on_floor() and not _climbing:
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
