@tool
extends TileMapLayer

var screen_size: Vector2

var map_size: Vector2i
var map_size_pixel: Vector2

var cam_pos_min: Vector2
var cam_pos_max: Vector2

var map_scale = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size / map_scale
	var cells = get_used_cells()
	var map_size_raw: Vector2i
	for cell in cells:
		if map_size_raw.x < cell.x:
			map_size_raw.x = cell.x
		if map_size_raw.y < cell.y:
			map_size_raw.y = cell.y

	map_size = Vector2i(map_size_raw.x + 2, map_size_raw.y + 1)
	map_size_pixel = Vector2(floorf(float(map_size.x - 2) / 2) * 128
							 + ceilf(float(map_size.x - 2) / 2) * 256,
							 map_size.y * 224 - 112)
	$Camera2D.position = screen_size / 2.0
	print(map_size_pixel)
	print(screen_size)
	
	cam_pos_min = screen_size / 2
	cam_pos_max = map_size_pixel - screen_size / 2
	if cam_pos_max.x < cam_pos_min.x:
		cam_pos_max.x = cam_pos_min.x
		print("Warning: Map is too small in width to cover the screen.")
	if cam_pos_max.y < cam_pos_min.y:
		cam_pos_max.y = cam_pos_min.y
		print("Warning: Map is too small in height to cover the screen.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if velocity.length() > 0:
		velocity = velocity.normalized()
		$Camera2D.position += velocity * 1024 * delta
		$Camera2D.position = $Camera2D.position.clamp(cam_pos_min, cam_pos_max)
		print($Camera2D.position)
