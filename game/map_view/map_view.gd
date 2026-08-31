extends CanvasLayer

var screen_size: Vector2

var map_size: Vector2i
var map_size_pixel: Vector2
var map_scale: Vector2

var pos_min: Vector2
var pos_max: Vector2
var zoom_min: float = 0.8**3
var zoom_max = 1.25**7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_scale = $Map.scale.abs()
	screen_size = $Map.get_viewport_rect().size / map_scale
	var cells = $Map.get_used_cells()
	var map_size_raw: Vector2i
	for cell in cells:
		if map_size_raw.x < cell.x:
			map_size_raw.x = cell.x
		if map_size_raw.y < cell.y:
			map_size_raw.y = cell.y

	map_size = Vector2i(map_size_raw.x + 1, map_size_raw.y + 1)
	map_size_pixel = Vector2(floorf(float(map_size.x) / 2) * 128
							 + ceilf(float(map_size.x) / 2) * 256,
							 map_size.y * 224)
	print("Map size: %s" % map_size)
	print("Map size (pixels): %s" % map_size_pixel)
	print("Screen size: %s" % screen_size)
	
	$Camera.position = Vector2.ZERO
	pos_min = Vector2.ZERO
	pos_max = map_size_pixel

func process_cam(delta: float):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized()
		$Camera.position += velocity * 2048 * delta
		$Camera.position = $Camera.position.clamp(pos_min, pos_max)
	
	var zoom = $Camera.zoom
	if Input.is_action_just_pressed("zoom_out"):
		zoom *= 0.8
	if Input.is_action_just_pressed("zoom_in"):
		zoom *= 1.25
	if zoom != $Camera.zoom:
		$Camera.zoom = zoom.clamp(Vector2(zoom_min, zoom_min),
								  Vector2(zoom_max, zoom_max))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_cam(delta)

func _exit_tree() -> void:
	$Camera.position = Vector2.ZERO
