extends ui_element
class_name ui_container


func _ready():
	._ready()
	draw_size=true

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
				elif event.button_index==BUTTON_RIGHT:
					var list=get_children()
					list[randi()%len(list)-1].queue_free()
#

func adopted(_node):
	order_children()

func unadopted(_node):
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


