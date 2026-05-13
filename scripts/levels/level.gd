class_name Level extends Control
## Control node representing a level.
## Could have use in a level preview of sorts, but otherwise only useful inside
## its designated scene.


## Enum containing all the abilities that could be used by entities.
enum Abilities {
	NONE,
	MOVE,
}


## Level data with which the level is initialized.
@export var level_data: LevelData

## The coordinates of the currently selected tile on the tile grid.
var selected_coordinates: Vector2i
## The type of the currently selected entity.
var selected_entity: EntityData


## Whether the board is currently expecting the player to select a tile to use an ability on.
var awaiting_ability_tile_selection := Abilities.NONE


## Tween variable for the actions bar.
var tween_actionsbar: Tween


#region Grid Preperation
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var grid_tile: GridTile = $Grid/GridRow/GridTile
	var grid_row: HBoxContainer = $Grid/GridRow
	var grid_full: VBoxContainer = $Grid
	
	# Populating the level grid.
	for i in range(level_data.dimensions.y):
		var new_row: HBoxContainer = grid_row.duplicate()
		new_row.name = "GridRow%s" % [i]
		new_row.remove_child(new_row.get_child(0))

		for j in range(level_data.dimensions.x):
			var new_tile: GridTile = grid_tile.duplicate()
			new_tile.name = "GridTile%s" % [j]
			new_tile.tile_coordinates = Vector2i(j, i)
			new_row.add_child(new_tile)
		
		grid_full.add_child(new_row)
	
	# Removing the default grid_row since it could cause issues.
	grid_full.remove_child(grid_row)
	grid_full.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Since the entities might change during the level, their logic should be here.
	var entities := level_data.entities
	
	# Hide all entities on the board to catch any entities that either don't
	# exist anymore or have moved to new tiles, since there is not callback
	# for either of those cases that directly hides the entities in their tiles
	# directly.
	for i in range(level_data.dimensions.x):
		for j in range(level_data.dimensions.y):
			var target_node: Entity = get_node("Grid/GridRow%s/GridTile%s/Entity" % [j, i])
			target_node.visible = false
	
	for entity in entities:
		var pos := entity.position
		var entity_type := entity.type
		if pos.x < level_data.dimensions.x and pos.x >= 0 and pos.y < level_data.dimensions.y and pos.y >= 0:
			var target_node: Entity = get_node(
				"Grid/GridRow%s/GridTile%s/Entity" % [pos.y, pos.x]
			)
			target_node.entity_type = entity_type
			target_node.visible = true
#endregion


#region Input Detection
func _on_grid_tile_selected(coordinates: Vector2i) -> void:
	for i in range(level_data.dimensions.x):
		for j in range(level_data.dimensions.y):
			var node: GridTile = get_node("Grid/GridRow%s/GridTile%s" % [j, i])
			node.deselect()
	
	if awaiting_ability_tile_selection == Abilities.NONE:
		# Select targeted tile after all tiles are deselected so it actually gets selected.
		select_tile(coordinates)
	elif awaiting_ability_tile_selection == Abilities.MOVE:
		move_to_tile(coordinates)


func _on_move_ability_button_pressed() -> void:
	awaiting_ability_tile_selection = Abilities.MOVE

	# Hacky solution to map level_data.entities[].position to its own array.
	var entity_tiles: Array[Vector2i] = []
	for entity in level_data.entities:
		entity_tiles.append(entity.position)
	
	var legal_tiles = Movement.get_valid_tiles(
		selected_entity.type.movement_type,
		level_data.dimensions,
		selected_coordinates,
		entity_tiles,
	)
	for tile in legal_tiles:
		var target_node: GridTile = get_node("Grid/GridRow%s/GridTile%s" % [tile.y, tile.x])
		target_node.set_action_indicator(load("res://sprites/icon_move.png"))


## Updates and animates the contents of the actions bar to reflect the current state.
func update_actions_bar():
	if tween_actionsbar:
		tween_actionsbar.kill()
	tween_actionsbar = create_tween()
	tween_actionsbar.set_trans(Tween.TRANS_EXPO)
	
	if selected_entity:
		$ActionsBar/EntityTypeNameHolder/EntityTypeNameDisplay.text = selected_entity.type.name
		$ActionsBar/EntityTypeNameHolder/EntityStateDisplay.text = Entity.name_from_state_id(selected_entity.state)
		$ActionsBar/MoveAbilityButton.visible = selected_entity.type.movement_type != Movement.MovementType.STATIONARY
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
			selected_entity = entity
	update_actions_bar()


func move_to_tile(coordinates: Vector2i) -> void:
	if (
		# There isn't really any easier way get the ActionIndicator node.
		# Also, the sprite of the ActionIndicator doesn't particularly matter
		# since if the entity cannot move to that tile it will be hidden.
		get_node(
			"Grid/GridRow%s/GridTile%s/ActionIndicator" % [coordinates.y, coordinates.x]
		).visible == true
	):
		for entity in level_data.entities:
			if (
				entity.position.y == selected_coordinates.y and
				entity.position.x == selected_coordinates.x
			):
				entity.position = coordinates
		# Vector2i cannot be set to null, so (-1, -1) is used instead here.
		selected_coordinates = Vector2i(-1, -1)
		selected_entity = null
		update_actions_bar()
	else:
		select_tile(coordinates)
	
	# Clear action indicators on all tiles, regardless of whether the entity actually moved.
	# This is because either way the entity gets deselected, and the movement process ends.
	for i in range(level_data.dimensions.x):
		for j in range(level_data.dimensions.y):
			var target_node: GridTile = get_node("Grid/GridRow%s/GridTile%s" % [j, i])
			target_node.clear_action_indicator()
	
	awaiting_ability_tile_selection = Abilities.NONE
#endregion
