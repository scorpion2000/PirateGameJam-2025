@tool
extends Container
class_name FullGrid

## Mode of stretching applied to grid cells:
enum StretchMode { 
	FullStretch, ## Cells stretch both horizontally and vertically to fill the container.
	StretchX, ## Cells stretch horizontally but retain their defined height.
	StretchY, ## Cells stretch vertically but retain their defined width.
	NoStretch ## Cells do not stretch and use their defined size.
}

## Defines how the cells are stretched within the grid:
@export var mode: StretchMode = StretchMode.FullStretch:
	set(value):
		mode = value
		notify_property_list_changed()
		_update_grid()

## Number of columns in the grid. Minimum value is 1.
@export var columns: int = 4:
	set(value):
		columns = max(1, value)
		_update_grid()

## Number of rows in the grid. Minimum value is 1.
@export var rows: int = 2:
	set(value):
		rows = max(1, value)
		_update_grid()

## Defines the space between grid cells and the grid edges as a Vector2 (horizontal padding, vertical padding).
@export var padding: Vector2 = Vector2(10, 10):
	set(value):
		padding = value
		_update_grid()

## Internal variable for cell size (not exported directly).
var cell_size: Vector2 = Vector2(100, 100)

## Map to track items based on their placement
var placement_map: Dictionary = {}

func _enter_tree() -> void:
	_check_children_meta()

## Custom dynamic property handling for cell_size based on mode
func _get_property_list() -> Array:
	var properties = []
	match mode:
		StretchMode.StretchX:
			properties.append({
				"name": "cell_size_y",
				"type": TYPE_FLOAT,
				"usage": PROPERTY_USAGE_DEFAULT,
				"hint": "Defines the height of each cell when stretching horizontally."
			})
		StretchMode.StretchY:
			properties.append({
				"name": "cell_size_x",
				"type": TYPE_FLOAT,
				"usage": PROPERTY_USAGE_DEFAULT,
				"hint": "Defines the width of each cell when stretching vertically."
			})
		StretchMode.NoStretch:
			properties.append({
				"name": "cell_size",
				"type": TYPE_VECTOR2,
				"usage": PROPERTY_USAGE_DEFAULT,
				"hint": "Defines the size of each individual cell when no stretching is applied."
			})
	return properties

# Custom getters and setters for dynamic `cell_size_x` and `cell_size_y`
func get_cell_size_x() -> float:
	return cell_size.x

func set_cell_size_x(value: float) -> void:
	cell_size.x = value
	_update_grid()

func get_cell_size_y() -> float:
	return cell_size.y

func set_cell_size_y(value: float) -> void:
	cell_size.y = value
	_update_grid()

# Notification handler to dynamically handle children and updates
func _notification(_what: int) -> void:
	_check_children_meta()
	_update_grid()

# Ensure all children have meta tags for `row` and `column`
func _check_children_meta():
	for child in get_children():
		if child is Control:
			if not child.has_meta("row"):
				child.set_meta("row", -1)
			if not child.has_meta("column"):
				child.set_meta("column", -1)

# Sort and position children
func _sort_children():
	var effective_cell_size = cell_size
	var total_padding_x = padding.x * (columns + 1)  # Include edges
	var total_padding_y = padding.y * (rows + 1)    # Include edges
	
	match mode:
		StretchMode.FullStretch:
			effective_cell_size.x = (size.x - total_padding_x) / columns
			effective_cell_size.y = (size.y - total_padding_y) / rows
		StretchMode.StretchX:
			effective_cell_size.x = (size.x - total_padding_x) / columns
			effective_cell_size.y = cell_size.y
		StretchMode.StretchY:
			effective_cell_size.x = cell_size.x
			effective_cell_size.y = (size.y - total_padding_y) / rows
		StretchMode.NoStretch:
			effective_cell_size = cell_size
	
	for child in get_children():
		if child is Control:
			var row = child.get_meta("row", -1)
			var column = child.get_meta("column", -1)

			if row == -1 or column == -1: continue
			
			if row >= 0 and column >= 0 and row < rows and column < columns:
				var x = padding.x + column * (effective_cell_size.x + padding.x)
				var y = padding.y + row * (effective_cell_size.y + padding.y)
				child.set_position(Vector2(x, y))
				child.set_size(effective_cell_size)
			else:
				push_error("Child '{}' has invalid row or column values.".format(child.name))

# Update the grid layout
func _update_grid():
	_sort_children()

# Add an item to a specific grid slot
func add_item(item: Control, placement: Vector2) -> void:
	var row = int(placement.y)
	var column = int(placement.x)

	# Validate the slot
	if row < 0 or row >= rows or column < 0 or column >= columns:
		push_error("Invalid placement: Row {} or Column {} is out of bounds.".format(row, column))
		return

	# Check if the slot is already occupied
	if placement_map.has(Vector2(column, row)):
		push_error("Slot ({}, {}) is already occupied.".format(column, row))
		return

	# Add the item to the scene
	item.set_meta("row", row)
	item.set_meta("column", column)
	add_child(item)
	placement_map[Vector2(column, row)] = item
	_update_grid()

# Remove an item by its name
func remove_item(item_name: String) -> void:
	# Find the item in the placement map
	for key in placement_map.keys():
		var item = placement_map[key]
		if item.name == item_name:
			remove_child(item)
			placement_map.erase(key)
			_update_grid()
			return
	
	push_error("Item with name '{}' not found.".format(item_name))
