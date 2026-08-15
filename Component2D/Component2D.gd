class_name Component2D extends Node2D

@export var user: Node:
    get:
        if _user == null:
            return get_parent()
        return _user
    set(value):
        _user = value

var _user: Node = null


func _ready() -> void:
    if _user == null:
        _user = get_parent()
