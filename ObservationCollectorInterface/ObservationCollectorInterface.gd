@abstract
class_name ObservationCollectorInterface extends Node

static var instance: ObservationCollectorInterface = null

func _ready() -> void:
    if instance:
        push_error("Multiple instances of ObservationCollector detected. This is not supported.")
    else:
        instance = self

func get_observation() -> Dictionary:
    var result: Dictionary = {
        "observation": _observation(),
        "action_mask": _action_mask(),
        "reward": _reward(),
        "done": _done(),
        "info": _info(),
    }
    DebugLogger.trace("Generated observation: " + str(result))
    return result

func get_observation_bytes() -> PackedByteArray:
    return Messagepack.encode(get_observation())["value"]

func _info() -> Dictionary:
    return {}

@abstract func _observation() -> Dictionary
@abstract func _action_mask() -> Dictionary
@abstract func _reward() -> float
@abstract func _done() -> bool
