@abstract
class_name TreeElement extends Resource

const COOLDOWNS_KEY := &"__element_cooldowns"

enum Status {
    SUCCESS,
    FAILURE,
    RUNNING,
}

enum CooldownGroup {
    NONE,
    ATTACK,
}

@export var cooldown: float = 0.0
@export var cooldown_group: CooldownGroup = CooldownGroup.NONE

func tick(blackboard: Blackboard) -> Status:
    if cooldown > 0.0 and _is_on_cooldown(blackboard):
        return Status.FAILURE
    var result: Status = await _do_tick(blackboard)
    if result != Status.RUNNING:
        _start_cooldown(blackboard)
    return result

func _cooldown_key() -> Variant:
    return cooldown_group if cooldown_group != CooldownGroup.NONE else self

func _is_on_cooldown(blackboard: Blackboard) -> bool:
    var map: Dictionary = blackboard.get_value(COOLDOWNS_KEY, {})
    return int(map.get(_cooldown_key(), 0)) > Time.get_ticks_msec()

func _start_cooldown(blackboard: Blackboard) -> void:
    var map: Dictionary = blackboard.get_value(COOLDOWNS_KEY, {})
    map[_cooldown_key()] = int(Time.get_ticks_msec() + cooldown * 1000.0)
    blackboard.set_value(COOLDOWNS_KEY, map)

@abstract func _do_tick(blackboard: Blackboard) -> Status
