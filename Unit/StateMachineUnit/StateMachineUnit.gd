@abstract
class_name StateMachineUnit extends Unit

@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
    super._ready()

@abstract func setup() -> void
