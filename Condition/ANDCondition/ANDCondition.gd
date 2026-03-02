class_name ANDCondition extends Condition

@export var conditions: Array[Condition] = []

func _evaluate(data: Dictionary = {}) -> bool:
    for condition in conditions:
        if not condition.evaluate(data):
            return false
    return true
