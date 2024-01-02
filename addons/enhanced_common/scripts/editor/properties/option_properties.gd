@tool
extends OptionButton
class_name OptionProperties


signal property_set(item)


var object: Object
var property: String
# [{ name: String, value: Variant, icon: String | null }]
var items: Array
var set_first_item_as_default: bool
var empty_item: bool = false

func initialize(_object: Object, _property: String, _items: Array, _set_first_item_as_default: bool = true) -> void:
	object = _object
	property = _property
	items = _items
	set_first_item_as_default = _set_first_item_as_default
	alignment = HORIZONTAL_ALIGNMENT_CENTER
	text_overrun_behavior = TextServer.OVERRUN_TRIM_WORD_ELLIPSIS
	fit_to_longest_item = false
	expand_icon = true
	set("theme_override_constants/icon_max_width", 20)



func _ready() -> void:
	item_selected.connect(_on_item_selected)

	var is_in_options: bool = items.any(func(item): return item.value == object.get(property))
	if not is_in_options and not set_first_item_as_default:
		items.push_front({ "name": "", "value": null })
		empty_item = true

	for i in len(items):
		var item = items[i]

		if "icon" in item and item.icon != null and item.icon != "":
			var texture: Texture2D = load(item.icon)
			var image := texture.get_image()
			image.resize(48, 48, Image.INTERPOLATE_NEAREST)
			var second_texture := ImageTexture.create_from_image(image)
			add_icon_item(texture, item.name)
		else:
			add_item(item.name)
		
		if object.get(property) == item.value:
			_on_item_selected(i)
		
	if selected > 0:
		return
	
	if set_first_item_as_default == true:
		_on_item_selected(0)




func _on_item_selected(index: int) -> void:
	if items.is_empty():
		return

	object.set(property, items[index].value)
	select(index)
	property_set.emit(items[index])