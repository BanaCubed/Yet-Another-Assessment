class_name Level extends Control


enum Abilities {
	NONE,
	MOVE,
}


## Level data with which the level is initialized.
@export var level_data: LevelData

## The coordinates of the currently selected tile on the tile grid.
var selected_coordinates: Vector2i
## The type of the currently selected entity.
var selected_entity: EntityType
## Tween variable for the actions bar.
var tween_actionsbar: Tween
## Whether the board is currently expecting the player to select a tile to use an ability on.
var awaiting_ability_tile_selection := Abilities.NONE


#region Grid Preperation
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rows := level_data.size.y
	var cols := level_data.size.x
	
	# Populating the grid.
	var grid_tile: GridTile = $Grid/GridRow/GridTile
	var grid_row: HBoxContainer = $Grid/GridRow
	var grid_full: VBoxContainer = $Grid
	
	for i in range(rows):
		var new_row: HBoxContainer = grid_row.duplicate()
		new_row.name = "GridRow%s" % [i]
		new_row.remove_child(new_row.get_child(0))
		for j in range(cols):
			var new_tile: GridTile = grid_tile.duplicate()
			new_tile.name = "GridTile%s" % [j]
			new_tile.tile_coordinates = Vector2i(j, i)
			new_row.add_child(new_tile)
		grid_full.add_child(new_row)
	grid_full.remove_child(grid_row)
	grid_full.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var rows := level_data.size.y
	var cols := level_data.size.x
	
	# Since the entities might change during the level, their logic should be here.
	var entities := level_data.entities
	
	for i in range(cols):
		for j in range(rows):
			var target_node: Entity = get_node("Grid/GridRow%s/GridTile%s/Entity" % [j, i])
			target_node.visible = false
	
	for entity in entities:
		var pos := entity.position
		var entity_type := entity.entity
		if pos.x < rows and pos.x >= 0 and pos.y < cols and pos.y >= 0:
			var target_node: Entity = get_node("Grid/GridRow%s/GridTile%s/Entity" % [pos.y, pos.x])
			target_node.entity_type = entity_type
			target_node.visible = true
#endregion


#region Input Detection
func _on_grid_tile_selected(coordinates: Vector2i) -> void:
	var rows := level_data.size.y
	var cols := level_data.size.x
	
	for i in range(cols):
		for j in range(rows):
			var node: GridTile = get_node("Grid/GridRow%s/GridTile%s" % [j, i])
			node.deselect()
	
	if awaiting_ability_tile_selection == Abilities.NONE:
		select_tile(coordinates)
	elif awaiting_ability_tile_selection == Abilities.MOVE:
		move_to_tile(coordinates)


func _on_move_ability_button_pressed() -> void:
	awaiting_ability_tile_selection = Abilities.MOVE
	var entity_tiles: Array[Vector2i] = []
	for entity in level_data.entities:
		entity_tiles.append(entity.position)
	
	var legal_tiles = Movement.get_valid_tiles(
			selected_entity.movement_type,
			level_data.size,
			selected_coordinates,
			entity_tiles,
	)
	for tile in legal_tiles:
		var node: GridTile = get_node("Grid/GridRow%s/GridTile%s" % [tile.y, tile.x])
		node.set_action_indicator(load("res://sprites/icon_move.png"))


## Updates and animates the contents of the actions bar to reflect the current state.
func update_actions_bar():
	if tween_actionsbar:
		tween_actionsbar.kill()
	tween_actionsbar = create_tween()
	tween_actionsbar.set_trans(Tween.TRANS_EXPO)
	
	if selected_entity:
		$ActionsBar/EntityTypeNameHolder/EntityTypeNameDisplay.text = selected_entity.name
		$ActionsBar/MoveAbilityButton.visible = selected_entity.movement_type != Movement.MovementType.STATIONARY
		tween_actionsbar.tween_property($ActionsBar, ^"position", Vector2(8.0, 312.0), 0.4)
	else:
		tween_actionsbar.tween_property($ActionsBar, ^"position", Vector2(8.0, 400.0), 0.4)
#endregion


#region Abilities
func select_tile(coordinates: Vector2i) -> void:
	selected_coordinates = coordinates
	selected_entity = null
	for entity in level_data.entities:
		if (
				entity.position.y == selected_coordinates.y and
				entity.position.x == selected_coordinates.x
		):
			selected_entity = entity.entity
	update_actions_bar()


func move_to_tile(coordinates: Vector2i) -> void:
	var rows := level_data.size.y
	var cols := level_data.size.x
	
	var selected_tile: GridTile = get_node(
			"Grid/GridRow%s/GridTile%s" % [coordinates.y, coordinates.x]
	)
	if selected_tile.get_child(-1).visible == true: # I'm not sure how else to get the action indicator node.
		for entity in level_data.entities:
			if (
					entity.position.y == selected_coordinates.y and
					entity.position.x == selected_coordinates.x
			):
				entity.position = coordinates
		selected_coordinates = Vector2i(-1, -1)
		selected_entity = null
		update_actions_bar()
		awaiting_ability_tile_selection = Abilities.NONE
	else:
		select_tile(coordinates)
	for i in range(cols):
		for j in range(rows):
			var node: GridTile = get_node("Grid/GridRow%s/GridTile%s" % [j, i])
			node.clear_action_indicator()
#endregion
