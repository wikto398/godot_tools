class_name Sequence extends TreeElement

@export var children: Array[TreeElement] = []

func tick(blackboard: Blackboard) -> Status:
	for child in children:
		var result = await child.tick(blackboard)
		if result == Status.FAILURE:
			return Status.FAILURE
		elif result == Status.RUNNING:
			return Status.RUNNING
	return Status.SUCCESS
