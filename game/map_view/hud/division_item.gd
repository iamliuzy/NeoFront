extends Control

class_name DivisionItem

var division: Division

static func init(division: Division):
	var divi = preload("res://game/map_view/hud/division_item.tscn").instantiate()
	divi.division = division
	return divi

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_division_name_ready() -> void:
	$DivisionName.text = division.division_name
