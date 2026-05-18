class_name ContinueOnErrorDecorator extends Decorator

func tick(blackboard: Blackboard) -> Status:
	var child_status = await child.tick(blackboard)
	if child_status == Status.SUCCESS:
		return Status.SUCCESS
	elif child_status == Status.FAILURE:
		return Status.SUCCESS
	else:
		return child_status
