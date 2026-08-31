extends Node2D

class_name Division

enum DivisionType { infantry, Tank }

var selected = false
var division_name: String
var nation: Nation
var type: DivisionType
var attack: float
var defense: float
var speed: float

signal select

func _init(division_name: String, nation: Nation,
		   type: DivisionType, attack: float,
		   defense: float, speed: float) -> void:
	self.division_name = division_name
	self.nation = nation
	self.type = type
	self.attack = attack
	self.defense = defense
	self.speed = speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_pressed() -> void:
	if selected == false:
		selected = true
		$SelectRim.visible = true
	else:
		selected = false
		$SelectRim.visible = false
	select.emit()
