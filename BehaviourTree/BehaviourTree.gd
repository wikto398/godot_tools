class_name BehaviourTree extends Resource

@export var root: TreeElement

var blackboard: Blackboard = Blackboard.new()

func tick() -> TreeElement.Status:
	if root == null:
		return TreeElement.Status.FAILURE
	var result = await root.tick(blackboard)
	return result
