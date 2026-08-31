extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.is_debug_build():
		$ZoomLabel.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_division_selected(division: Division):
	if division.selected == true:
		$DivisionList.add_child(DivisionItem.init(division))
	else:
		for i in $DivisionList.get_children():
			if i.division == division:
				$DivisionList.remove_child(i)
	
	if $DivisionList.get_child_count() == 0:
		$DivisionList.visible = false
	else:
		$DivisionList.visible = true
