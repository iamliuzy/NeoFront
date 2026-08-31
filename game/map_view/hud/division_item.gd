extends Control

class_name DivisionItem

var division: Division

func _init(division: Division):
	self.division = division

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DivisionName.text = division.division_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
