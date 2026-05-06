@abstract
class_name TreeElement extends Resource

enum Status {
    SUCCESS,
    FAILURE,
    RUNNING,
}

@abstract func tick(blackboard: Blackboard) -> Status
