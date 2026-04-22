class_name InternalBoxShadow extends Control


@export var border_color: Color

func update_gradient_color() -> void:
	var gradient_texture: GradientTexture2D = preload(
		"res://resources/internal_box_shadow_gradient.tres"
	)
	
	gradient_texture.gradient.colors = PackedColorArray([
		Color(
			border_color.r,
			border_color.g,
			border_color.b,
			0,
		),
		border_color,
	])
	$TextureRect.texture = gradient_texture

func _ready() -> void:
	update_gradient_color()
	
