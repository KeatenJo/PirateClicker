extends Button

@onready var quitButton: Button = $"."
# Called when the node enters the scene tree for the first time.
func _ready():
	quitButton.pressed.connect(returnToMainMenu)
	pass # Replace with function body.

func returnToMainMenu():
	get_tree().change_scene_to_file("res://mainMenu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
