extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		player.set_climbable(true)
		print("Player in")
		
func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		player.set_climbable(false)
		print("Player out")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





