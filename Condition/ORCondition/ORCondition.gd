class_name ORCondition extends Condition

@export var conditions: Array[Condition] = []

func _evaluate(data: Dictionary = {}) -> bool:
    for condition in conditions:
        if condition.evaluate(data):
            return true
    return false
