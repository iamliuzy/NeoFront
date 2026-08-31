extends Node

class_name Game

var debug = OS.is_debug_build()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Divisions.add_division(Division.new("aaa",
										 Nation.new("a", Color.AQUA),
										 Division.DivisionType.Tank,
										 10.0, 10.0, 10.0), self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if debug:
		$HUD/ZoomLabel.text = str($MapView/Camera.zoom.x)


func _on_division_select(division: Division) -> void:
	$HUD._on_division_selected(division)
