class_name Component extends Node

@export var user: Node:
    get:
        if _user == null:
            return get_parent()
        return _user

var _user: Node = null
