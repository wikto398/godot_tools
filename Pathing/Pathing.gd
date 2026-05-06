class_name Pathing

static func a_star(start: Field, goal: Field, field_grid: FieldGrid, heuristic: Callable, condition: Condition, unit: Unit = null) -> Array[Field]:
	var open_set: PriorityQueue = PriorityQueue.new()
	var came_from: Dictionary[Field, Field] = {}
	var g_score: Dictionary[Field, int] = {}
	var f_score: Dictionary[Field, int] = {}

	g_score[start] = 0
	f_score[start] = heuristic.call(start, goal)
	open_set.push(start, f_score[start])

	var current_path: Array[Field] = []
	while not open_set.is_empty():
		var current: Field = open_set.pop()
		if current == goal:
			current_path = _reconstruct_path(came_from, current)
			return current_path

		for neighbor in field_grid.get_neighbours(current.grid_position):
			if not condition.evaluate({"neighbor": neighbor, "unit": unit}):
				continue
			var tentative_g_score = g_score[current] + neighbor.movement_cost
			if not g_score.has(neighbor) or tentative_g_score < g_score[neighbor]:
				came_from[neighbor] = current
				g_score[neighbor] = tentative_g_score
				f_score[neighbor] = tentative_g_score + heuristic.call(neighbor, goal)
				open_set.push(neighbor, f_score[neighbor])

	DebugLogger.debug("No path found from {start} to {goal}".format({start = start.grid_position, goal = goal.grid_position}))
	return []

static func dijkstra(start: Field, max_range: int, field_grid: FieldGrid, condition: Condition, unit: Unit = null) -> Dictionary:
	var open_set: PriorityQueue = PriorityQueue.new()
	var came_from: Dictionary[Field, Field] = {}
	var g_score: Dictionary[Field, int] = {}
	var visited: Dictionary[Field, bool] = {}

	g_score[start] = 0
	open_set.push(start, g_score[start])

	var reachable_fields: Array[Field] = []

	while not open_set.is_empty():
		var current: Field = open_set.pop()

		visited[current] = true

		reachable_fields.append(current)

		for neighbor in field_grid.get_neighbours(current.grid_position):
			if not condition.evaluate({"neighbor": neighbor, "unit": unit}):
				continue

			var tentative_g_score = g_score[current] + neighbor.movement_cost

			if max_range != -1 and tentative_g_score > max_range:
				continue

			if not g_score.has(neighbor) or tentative_g_score < g_score[neighbor]:
				came_from[neighbor] = current
				g_score[neighbor] = tentative_g_score
				if not visited.has(neighbor):
					open_set.push(neighbor, g_score[neighbor])

	return {"reachable_fields": reachable_fields, "came_from": came_from}

static func get_nearest_field_towards_goal(start: Field, goal: Field, max_range: int, field_grid: FieldGrid, condition: Condition, unit: Unit = null) -> Field:
	var result = dijkstra(start, max_range, field_grid, condition, unit)
	var reachable_fields: Array[Field] = result["reachable_fields"]
	var best_field: Field = null
	var best_distance: float = INF
	for field in reachable_fields:
		if field == start:
			continue
		var dist = field.grid_position.distance_to(goal.grid_position)
		if dist < best_distance:
			best_distance = dist
			best_field = field
	return best_field

static func _reconstruct_path(came_from: Dictionary[Field, Field], current: Field) -> Array[Field]:
	var total_path: Array[Field] = [current]
	while came_from.has(current):
		current = came_from[current]
		total_path.insert(0, current)
	return total_path

static func reconstruct_path(came_from: Dictionary[Field, Field], start: Field, target: Field) -> Array[Field]:
	var path: Array[Field] = []
	var current: Field = target
	while current != start:
		path.push_front(current)
		current = came_from[current]
	path.push_front(start)
	return path
