extends Node2D

var score: int = 0
var upgradeCost: int = 4
var buttonPayout = 1
var autoClickerCost: int = 20
var isAutoClicker: bool = false
var isAutoClicking: bool = false
var autoClickerLvl: int = 1
var autoClickerUpgradeCost: int = 40

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var click_button: Button = $CanvasLayer/ClickButton

@onready var upgrade_button: Button = $CanvasLayer/UpgradeContainer/UpgradeButton
@onready var upgrade_cost_label: Label = $CanvasLayer/UpgradeContainer/UpgradeCostLabel

@onready var auto_clicker_label: Label = $CanvasLayer/VBoxContainer/AutoClickerContainer/AutoclickerCostLabel
@onready var auto_clicker_button: Button = $CanvasLayer/VBoxContainer/AutoClickerContainer/AutoClickerButton

@onready var auto_clicker_upgrade_container: HBoxContainer =$CanvasLayer/VBoxContainer/AutoClickerUpgradeContainer
@onready var auto_clicker_upgrade_label: Label = $CanvasLayer/VBoxContainer/AutoClickerUpgradeContainer/AutoclickerUpgradeCostLabel
@onready var auto_clicker_upgrade_button: Button = $CanvasLayer/VBoxContainer/AutoClickerUpgradeContainer/AutoClickerUpgradeButton

func _ready() -> void:
	click_button.pressed.connect(_on_click_button_pressed)
	upgrade_button.pressed.connect(upgrade_button_payout)
	auto_clicker_button.pressed.connect(auto_clicker_button_pressed)
	auto_clicker_upgrade_button.pressed.connect(autoClickerUpgrade)
	
	update_score_label()
	

func _on_click_button_pressed() -> void:
	score += buttonPayout
	animate_button_click(click_button)
	update_score_label()

func update_score_label() -> void:
	score_label.text = "Score: %d" % score
	
	
func update_cost_label() -> void:
	upgrade_cost_label.text = "Upgrade Cost: %d" % upgradeCost
	
func update_auto_clicker_label() -> void:
	auto_clicker_label.text = "Sold Out!"

func animate_button_click(button) -> void:
	var tween := create_tween()
	tween.tween_property(button, "scale", Vector2(1.2, 1.2), 0.08).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

func upgrade_button_payout() -> void:
	if score >= upgradeCost:
		score -= upgradeCost
		buttonPayout *= 2
		upgradeCost *= 4
		update_score_label()
		update_cost_label()
		animate_button_click(upgrade_button)
	
func auto_clicker_button_pressed() -> void:
	if score >= autoClickerCost and isAutoClicker != true:
		score -= autoClickerCost
		isAutoClicker = true
		autoClickerCost *= 2
		auto_clicker_upgrade_container.show()
		update_score_label()
		update_auto_clicker_label()
		start_autoclicking()
		animate_button_click(auto_clicker_button)

func start_autoclicking() -> void:
	# Start a repeating timer to click automatically every second
	var auto_timer := Timer.new()
	auto_timer.wait_time = 0.5
	auto_timer.autostart = true
	auto_timer.one_shot = false
	auto_timer.timeout.connect(_on_auto_click)
	add_child(auto_timer)
	auto_timer.start()

func _on_auto_click() -> void:
	if isAutoClicking:
		score += buttonPayout * autoClickerLvl
		animate_button_click(click_button)
		update_score_label()	
	
func _on_click_button_mouse_entered():
	if isAutoClicker == true:
		isAutoClicking = true

func _on_click_button_mouse_exited():
	if isAutoClicker == true:
		isAutoClicking = false
		
func autoClickerUpgrade():
	if isAutoClicker == true:
		if score >= autoClickerUpgradeCost:
			score -= autoClickerUpgradeCost
			autoClickerLvl += 1
			autoClickerUpgradeCost *= 1.75
			updateAutClickerUpgradeLevel()
			updateAutoClickerUpgradeLabel()
			update_score_label()
			
func updateAutoClickerUpgradeLabel():
	auto_clicker_upgrade_label.text = "Upgrade Cost: %d" % autoClickerUpgradeCost
			
			
func updateAutClickerUpgradeLevel():
	auto_clicker_upgrade_button.text = "LVL: %d" % autoClickerLvl
		
		
