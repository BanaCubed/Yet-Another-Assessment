class_name Level extends Control
## Control node representing a level.
## Could have use in a level preview of sorts, but otherwise only useful inside
## its designated scene.


## Enum containing all the abilities that could be used by entities.
## This does *not* contain any interactions.
enum Abilities {
	NONE,
	MOVE,
}


## Level data with which the level is initialized.
@export var level_data: LevelData


## The coordinates of the currently selected tile on the tile grid.
## In all honesty this variable isn't needed, but I can't really figure out how to safely remove it.
var selected_coordinates: Vector2i
## The type of the currently selected entity.
var selected_entity: EntityData
## Whether the board is currently expecting the player to select a tile to use an ability on.
var awaiting_ability_tile_selection := Abilities.NONE
## The amount of moves performed whilst playing this particular level.
var level_moves := 0


## Tween variable for the actions bar.
var tween_actionsbar: Tween


#region Grid Preperation
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

	var walls: Array[Vector2i] = Movement.find_wall_tiles(selected_entity, level_data.entities)
	var obstacles: Array[Vector2i] = Movement.find_blocking_tiles(selected_entity, level_data.entities)
	
	var legal_tiles = Movement.get_valid_tiles(
		selected_entity.type.movement_type,
		level_data.dimensions,
		selected_coordinates,
		walls,
		obstacles,
	)
	for tile in legal_tiles:
		var target_node: GridTile = get_node("Grid/GridRow%s/GridTile%s" % [tile.y, tile.x])
		target_node.set_action_indicator(load("res://sprites/icon_move.png"))
#endregion


#region Selection
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


## Selects a tile and entity at the given coordinates.
## Does not actually play any animations.
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
#endregion


#region Entity Updates
## Increments level moves by 1 and updates all entity states appropriately.
func finalise_turn() -> void:
	proceed_spoilage()
	delete_pending_removals()

	level_moves += 1
	$TurnCounter.text = "%s MOVES" % level_moves


## Decrements all the spoilage timers.
func proceed_spoilage() -> void:
	for entity in level_data.entities:
		# I am amazing at programming.
		match entity.state:
			Entity.States.SPOILS_IN_1:
				entity.state = Entity.States.SPOILED
			Entity.States.SPOILS_IN_2:
				entity.state = Entity.States.SPOILS_IN_1
			Entity.States.SPOILS_IN_3:
				entity.state = Entity.States.SPOILS_IN_2
			_:
				pass


## Deletes any entities with the REMOVED state.
func delete_pending_removals() -> void:
	var iterable = level_data.entities
	for entity in iterable:
		if entity.state == Entity.States.REMOVED:
			level_data.entities.erase(entity)
#endregion


#region Abilities
## Moves the currently selected entity to the specified coordinates.
## Also deselects the selected entity afterwards.
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
				entity.position.y == coordinates.y and
				entity.position.x == coordinates.x
			):
				var interactions_between = Interaction.interactions_between(selected_entity.type, entity.type.name)
				for inter in interactions_between:
					selected_entity.state = Interaction.state_after_interaction(inter, selected_entity.state, entity.state)[0]
					entity.state = Interaction.state_after_interaction(inter, selected_entity.state, entity.state)[1]
		for entity in level_data.entities:
			if (
				entity.position.y == selected_coordinates.y and
				entity.position.x == selected_coordinates.x
			):
				entity.position = coordinates
		# Vector2i cannot be set to null, so (-1, -1) is used instead here.
		selected_coordinates = Vector2i(-1, -1)
		selected_entity = null
		
		finalise_turn()
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
