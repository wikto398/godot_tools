class_name PointyHexGrid extends FieldGrid

@export var columns: int
@export var rows: int
@export var hex_size: float = 16.0

var fields: Dictionary[Vector2i, Field] = {}

const EVEN_R_DIRECTIONS := [
	Vector2i(-1, -1), Vector2i(0, -1),
	Vector2i(-1, 0),  Vector2i(1, 0),
	Vector2i(-1, 1),  Vector2i(0, 1),
]

const ODD_R_DIRECTIONS := [
	Vector2i(0, -1),  Vector2i(1, -1),
	Vector2i(-1, 0),  Vector2i(1, 0),
	Vector2i(0, 1),   Vector2i(1, 1),
]

func _ready():
	super._ready()

func get_neighbours(field_position: Vector2i) -> Array[Field]:
	var result: Array[Field] = []
	var directions = EVEN_R_DIRECTIONS if (field_position.y & 1) == 0 else ODD_R_DIRECTIONS
	for d in directions:
		var f := get_field_at(field_position + d)
		if f:
			result.append(f)
	return result

func get_field_at(field_position: Vector2i) -> Field:
	return fields.get(field_position, null)
