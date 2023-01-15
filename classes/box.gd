extends Node2D
class_name box


# objs
var _owner

# vars
var force_update=false
var size=Vector2(64,64)
var rect=Rect2(0,0,1,1)
var hover=false
var function

# last
var last_size
var last_hover


func process(mouse_pos=Vector2(0,0)):
	if last_size!=size:
		last_size=size
		size_changed()
	
	hover=false
	if rect.has_point(mouse_pos):
		hover=true
	
	if last_hover!=hover:
		last_hover=hover
		call_return_obj_func()

func size_changed():
	rect=Rect2(0,0,size.x,size.y)
	call_return_obj_func()

func call_return_obj_func():
	if function!=null:
		function.call_func()
