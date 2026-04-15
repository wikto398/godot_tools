@abstract class_name FieldGrid extends Node2D

@abstract func get_field_at(field_position) -> Field
@abstract func get_neighbours(field_position) -> Array[Field]

static var instance: FieldGrid = null

func _ready():
    if instance:
        push_error("Multiple instances of FieldGrid detected. This may lead to unexpected behavior.")
    else:
        instance = self
