extends Node2D

var score: int = 0
var upgradeCost: int = 4
var buttonPayout = 1

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var click_button: Button = $CanvasLayer/ClickButton
@onready var upgrade_button: Button = $CanvasLayer/UpgradeContainer/UpgradeButton
@onready var upgrade_cost_label: Label = $CanvasLayer/UpgradeContainer/UpgradeCostLabel

func _ready() -> void:
	click_button.pressed.connect(_on_click_button_pressed)
	upgrade_button.pressed.connect(upgrade_button_payout)
	update_score_label()

func _on_click_button_pressed() -> void:
	score += buttonPayout
	animate_button_click()
	update_score_label()

func update_score_label() -> void:
	score_label.text = "Score: %d" % score
	

func update_cost_label() -> void:
	upgrade_cost_label.text = "Upgrade Cost: %d" % upgradeCost

func animate_button_click() -> void:
	var tween := create_tween()
	tween.tween_property(click_button, "scale", Vector2(1.2, 1.2), 0.08).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(click_button, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

func upgrade_button_payout() -> void:
	if score >= upgradeCost:
		score -= upgradeCost
		buttonPayout *= 2
		upgradeCost *= 4
		
	update_score_label()
	update_cost_label()
		

