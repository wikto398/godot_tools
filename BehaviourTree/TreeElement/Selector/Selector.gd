class_name Selector extends TreeElement

@export var children: Array[TreeElement] = []

func tick(blackboard: Blackboard) -> Status:
    for child in children:
        DebugLogger.info("Selector: Ticking child element: " + str(child))
        var result = await child.tick(blackboard)
        if result == Status.SUCCESS:
            return Status.SUCCESS
        elif result == Status.RUNNING:
            return Status.RUNNING
    return Status.FAILURE
