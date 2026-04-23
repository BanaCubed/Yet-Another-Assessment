class_name Level extends Control


## Level data with which the level is initialized.
@export var level: LevelData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rows := level.size.x
	var cols := level.size.y
	
	var grid_tile: Control = $Grid/GridRow/GridTile
	var grid_row: HBoxContainer = $Grid/GridRow
	var grid_full: VBoxContainer = $Grid
	
	for i in range(rows - 1):
		grid_row.add_child(grid_tile.duplicate())
	
	for i in range(cols - 1):
		grid_full.add_child(grid_row.duplicate())
	
	grid_full.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
