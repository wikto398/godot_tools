class_name Selector extends TreeElement

@export var children: Array[TreeElement] = []

func _do_tick(blackboard: Blackboard) -> Status:
    for child in children:
        var result = await child.tick(blackboard)
        if result == Status.SUCCESS:
            return Status.SUCCESS
        elif result == Status.RUNNING:
            return Status.RUNNING
    return Status.FAILURE
