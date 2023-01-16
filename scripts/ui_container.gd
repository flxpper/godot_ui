extends ui_element
class_name ui_container

# vars
var order_type="evenly_spaced"


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
					if len(list)>0:
						list[randi()%len(list)-1].queue_free()
				elif event.button_index==BUTTON_MIDDLE:
					sort_children()
#

func adopted(_node):
	sort_children()

func unadopted(_node):
	sort_children()

func sort_children():
	var x=border
	var y=border
	var _x_spacing=padding
	var y_spacing=padding
	var child_list=get_children()
	
	if order_type=="evenly_spaced":
		var total_child_height=0
		for child in child_list:
			total_child_height+=child.size.y
		
		y_spacing=max(1,floor((size.y-total_child_height)/max(1,len(child_list))))
	
	for child in child_list:
		child.position=Vector2(x,y)
		#x+=child.size.x+x_spacing
		#if x+child.size.x>size.x:
		#x=border
		
		y+=child.size.y+y_spacing


