class_name BehaviourTree extends Resource

@export var root: TreeElement

var blackboard: Blackboard = Blackboard.new()
var user: Node2D

func set_user(user_node: Node2D) -> void:
    user = user_node
    blackboard.set_value("user", user)

func tick() -> TreeElement.Status:
    if root == null:
        DebugLogger.debug("Root node is null in BehaviourTree.")
        return TreeElement.Status.FAILURE
    var result = await root.tick(blackboard)
    return result
