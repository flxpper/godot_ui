extends Node2D
class_name ui_element


# objs
var box_rect

# vars
var force_update=false
var size=Vector2(100,100)
var border=8
var padding=4
var draw_size=false

# debug
var color_size=Color.red


func _ready():
	box_rect=box.new()
	box_rect._owner=self
	box_rect.size=size
	box_rect.function=funcref(self,"box_updated")

func _process(_delta):
	box_rect.process(get_local_mouse_position())
	
	if force_update:
		force_update=false
		update()

func _draw():
	if !draw_size:
		return
	
	var _color=color_size
	if box_rect.hover:
		_color=lerp(_color,Color.white,.2)
	
	draw_rect(box_rect.rect,_color)

func _notification(what):
	if what==NOTIFICATION_PARENTED:
		if get_parent().has_method("adopted"):
			get_parent().adopted(self)

func box_updated():
	force_update=true

func _exit_tree():
	if get_parent().has_method("unadopted"):
		get_parent().call_deferred("unadopted",self)
