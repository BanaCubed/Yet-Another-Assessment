class_name Entity extends Control


## The type of entity to render.
@export var entity_type: EntityType


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$EntitySprite.texture = entity_type.sprite
