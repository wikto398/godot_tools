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

static func dijkstra(start: Field, max_range: int, field_grid: FieldGrid, condition: Condition, unit: Unit = null) -> Array[Field]:
	var open_set: PriorityQueue = PriorityQueue.new()
	var came_from: Dictionary[Field, Field] = {}
	var g_score: Dictionary[Field, int] = {}
	var visited: Dictionary[Field, bool] = {}

	g_score[start] = 0
	open_set.push(start, g_score[start])

	var reachable_fields: Array[Field] = []

	while not open_set.is_empty():
		var current: Field = open_set.pop()

		if visited.has(current):
			continue
		visited[current] = true

		if g_score[current] > max_range:
			continue

		reachable_fields.append(current)

		for neighbor in field_grid.get_neighbours(current.grid_position):
			if not condition.evaluate({"neighbor": neighbor, "unit": unit}):
				continue

			var tentative_g_score = g_score[current] + neighbor.movement_cost

			if not g_score.has(neighbor) or tentative_g_score < g_score[neighbor]:
				came_from[neighbor] = current
				g_score[neighbor] = tentative_g_score
				open_set.push(neighbor, g_score[neighbor])

	return reachable_fields

static func _reconstruct_path(came_from: Dictionary[Field, Field], current: Field) -> Array[Field]:
	var total_path: Array[Field] = [current]
	while came_from.has(current):
		current = came_from[current]
		total_path.insert(0, current)
	return total_path
