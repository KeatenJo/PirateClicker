extends Control

@onready var newGameButton: Button = $CanvasLayer/MarginContainer/VBoxContainer/NewGameButton
@onready var creditsButton: Button = $CanvasLayer/MarginContainer/VBoxContainer/CreditsButton
@onready var quitButton: Button = $CanvasLayer/MarginContainer/VBoxContainer/QuitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	newGameButton.pressed.connect(loadNewGameScene)
	quitButton.pressed.connect(quitGame)
	creditsButton.pressed.connect(loadCreditsScene) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func loadNewGameScene():
	get_tree().change_scene_to_file("res://main.tscn")
	
func loadCreditsScene():
	get_tree().change_scene_to_file("res://credits.tscn")
	
func quitGame():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit(0)
	
