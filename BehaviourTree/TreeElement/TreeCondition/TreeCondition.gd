class_name TreeCondition extends TreeElement

@export var condition: Condition

func _do_tick(blackboard: Blackboard) -> Status:
    if condition.evaluate({"blackboard": blackboard}):
        return Status.SUCCESS
    else:
        return Status.FAILURE
