class_name PriorityQueue

var heap: Array = []

func is_empty() -> bool:
    return heap.is_empty()

func push(item, priority: int) -> void:
    heap.append({ "item": item, "priority": priority })
    _bubble_up(heap.size() - 1)

func pop():
    if heap.is_empty():
        return null

    var root = heap[0]["item"]
    heap[0] = heap[-1]
    heap.pop_back()

    if not heap.is_empty():
        _bubble_down(0)

    return root

func _bubble_up(index: int) -> void:
    while index > 0:
        var parent = (index - 1) / 2
        if heap[index]["priority"] >= heap[parent]["priority"]:
            break
        _swap(index, parent)
        index = parent

func _bubble_down(index: int) -> void:
    var size = heap.size()
    while true:
        var left = index * 2 + 1
        var right = index * 2 + 2
        var smallest = index

        if left < size and heap[left]["priority"] < heap[smallest]["priority"]:
            smallest = left
        if right < size and heap[right]["priority"] < heap[smallest]["priority"]:
            smallest = right

        if smallest == index:
            break

        _swap(index, smallest)
        index = smallest

func _swap(i: int, j: int) -> void:
    var temp = heap[i]
    heap[i] = heap[j]
    heap[j] = temp
