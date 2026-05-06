class_name Blackboard extends RefCounted

var _data: Dictionary[StringName, Variant] = {}

func set_value(key: StringName, value: Variant) -> void:
    _data[key] = value

func get_value(key: StringName, default: Variant = null) -> Variant:
    return _data.get(key, default)

func has(key: StringName) -> bool:
    return _data.has(key)

func clear(key: StringName) -> void:
    _data.erase(key)
