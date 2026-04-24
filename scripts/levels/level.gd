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
		var new_tile = grid_tile.duplicate()
		new_tile.name = "GridTile%s" % [i + 1]
		grid_row.add_child(new_tile)
	
	for i in range(cols - 1):
		var new_row = grid_row.duplicate()
		new_row.name = "GridRow%s" % [i + 1]
		grid_full.add_child(new_row)
	
	# Changing the names of the default nodes to match the naming scheme
	# of the derived nodes.
	grid_tile.name = "GridTile0"
	grid_row.name = "GridRow0"
	grid_full.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Since the entities might change during the level, their logic should be here.
	var entities := level.entities
	
	for entity in entities:
		var pos := entity.position
		var entity_type := entity.entity
		
		var target_node: Entity = get_node("Grid/GridRow%s/GridTile%s/Panel/Entity" % [pos.y, pos.x])
		target_node.entity_type = entity_type
		target_node.visible = true
