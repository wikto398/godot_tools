@abstract
class_name Condition extends Resource

@export var should_be_true: bool = true

func evaluate(data: Dictionary = {}) -> bool:
    return _evaluate(data) == should_be_true

@abstract func _evaluate(data: Dictionary = {}) -> bool


