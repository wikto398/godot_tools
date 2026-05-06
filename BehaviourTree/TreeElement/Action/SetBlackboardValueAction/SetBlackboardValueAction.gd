class_name SetBlackboardValueAction extends Action

@export var key: String
@export var value: Variant

func tick(blackboard: Blackboard) -> Status:
    DebugLogger.info("SetBlackboardValueAction: Setting blackboard key '" + key + "' to value '" + str(value) + "'.")
    blackboard.set_value(key, value)
    return Status.SUCCESS
