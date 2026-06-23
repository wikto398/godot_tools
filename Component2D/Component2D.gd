class_name Component2D extends Node2D

@export var user: Node:
    get:
        if _user == null:
            return get_parent()
        return _user

var _user: Node = null
