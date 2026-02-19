@abstract
class_name State extends Node

signal change_state(new_state: String)

func enter(_user: Node) -> void:
	pass

func exit(_user: Node) -> void:
	pass

func update(_delta: float, _user: Node) -> void:
	pass
