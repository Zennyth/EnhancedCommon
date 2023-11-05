@icon("res://addons/enhanced_common/icons/icons8-gps-signal-24.png")
extends Node
class_name EventsProxy

signal event_triggered(event: String)

@export var debug: bool = false

func get_events() -> Array:
	var custom_class: GDScript = load(ClassUtils.get_custom_class(self).path)
	return SignalUtils.get_signal_list_overlap(EventsProxy, custom_class).map(func(c): return c.name) 

func connect_to_proxy(events_proxy: EventsProxy) -> void:
	for event in get_events():
		events_proxy.get(event).connect(trigger_event.bind(event))

func trigger_event(event) -> void:
	if debug:
		print(event)
	
	get(event).emit()

func get_same_class() -> GDScript:
	return load(ClassUtils.get_custom_class(self).path)