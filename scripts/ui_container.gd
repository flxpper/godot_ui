extends ui_element
class_name ui_container


# signal
signal got_new_child


func _init():
	add_user_signal("got_new_child", [{"name": "child", "type": TYPE_OBJECT}])

func _ready():
	._ready()
	var err=connect("got_new_child",self,"_on_box_container_node_added")
	if err:
		print_stack()
	
	draw_size=true

func box_updated():
	.box_updated()
	force_update=true


#
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if box_rect.hover:
				if event.button_index==BUTTON_LEFT:
					var INST=load("res://objects/ui_element.tscn").instance()
					INST.draw_size=true
					INST.size=Vector2(32,12)
					INST.color_size=Color.blue
					add_child(INST)
#

func got_new_child(node):
	printerr(node)


# todo
func _on_box_container_node_added(_node):
	order_children()

func _on_box_container_node_removed(_node):
	order_children()

func order_children():
	var x=border
	var y=border
	
	for child in get_children():
		child.position=Vector2(x,y)
		x+=child.size.x+padding
		if x+child.size.x>size.x:
			x=border
			y+=child.size.y+padding


