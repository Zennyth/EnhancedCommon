extends Object
class_name SignalUtils


static func disconnect_if_connected(_signal: Signal, _callable: Callable) -> void:
	if _callable.is_valid() and _signal.is_connected(_callable):
		_signal.disconnect(_callable)

static func connect_if_not_connected(_signal: Signal, _callable: Callable) -> void:
	if not _callable.is_valid() or _signal.is_connected(_callable):
		return
	
	_signal.connect(_callable)

static func connect_to_signal(_source: Signal, _dest: Signal) -> void:
	var callback: Callable = func(_arg1 = null, _arg2 = null, _arg3 = null): _dest.emit()
	_source.connect(callback)

static func get_signal_list_overlap(_extends_class, _base_class) -> Array[Dictionary]:
	var signals: Array[Dictionary] = []

	var _extends = _extends_class.new()
	var _base = _base_class.new()

	signals.assign(difference(_base.get_signal_list(), _extends.get_signal_list()))

	return signals


static func difference(arr1: Array, arr2: Array) -> Array:
	var diff: Array = [] 

	for elem in arr1:
		if arr2.any(func(e): return e.name == elem.name):
			continue	
		
		diff.append(elem)
	
	return diff
