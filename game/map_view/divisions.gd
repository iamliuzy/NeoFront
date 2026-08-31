extends CanvasLayer

var camera: Camera2D

func add_division(division: Division, game: Game):
	division.select.connect(game._on_division_select.bind(division))
	self.add_child(division)
	division.position = Vector2(0, 0)

func _process(delta: float) -> void:
	if self.get_child_count() > 0:
		scale = Vector2(1 / camera.zoom.x, 1 / camera.zoom.y)
		if camera.zoom.x < 0.8:
			for i in self.get_children():
				i.visible = false
		else:
			for i in self.get_children():
				i.visible = true


func _on_camera_ready() -> void:
	camera = get_viewport().get_camera_2d()
