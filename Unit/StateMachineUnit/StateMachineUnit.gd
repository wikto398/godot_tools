@abstract
class_name StateMachineUnit extends Unit

@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
    super._ready()
    setup()

func setup() -> void:
    _setup()

@abstract func _setup() -> void

func _on_field_changed() -> void:
    global_position = field.global_position
