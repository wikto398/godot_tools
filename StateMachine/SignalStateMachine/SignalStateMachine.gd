class_name SignalStateMachine extends StateMachine

func setup(signal_reference) -> void:
   signal_reference.connect(_update_on_signal)

func _update_on_signal() -> void:
   _update(0)
