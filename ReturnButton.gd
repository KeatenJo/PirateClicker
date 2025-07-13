extends Button

@onready var returnButton: Button = $"."
# Called when the node enters the scene tree for the first time.
func _ready():
	returnButton.pressed.connect(returnToMainMenu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func returnToMainMenu():
	get_tree().change_scene_to_file("res://mainMenu.tscn")
