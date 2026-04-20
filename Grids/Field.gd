@abstract class_name Field extends Node2D

signal field_clicked(field: Field)

var grid_position:
    set(value):
        _set_grid_position(value)
    get:
        return _get_grid_position()

var movement_cost: int:
    get:
        return _get_movement_cost()

@abstract func _get_grid_position()
@abstract func _set_grid_position(value)
@abstract func _get_movement_cost()
