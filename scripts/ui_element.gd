extends Node2D
class_name ui_element


# objs
var box_rect

# vars
var force_update=false
var size=Vector2(100,100)
var border=4
var padding=2
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
	
	draw_rounded_rect(box_rect.rect,8,_color)

func _notification(what):
	if what==NOTIFICATION_PARENTED:
		if get_parent().has_method("adopted"):
			get_parent().adopted(self)

func box_updated():
	force_update=true

func _exit_tree():
	if get_parent().has_method("unadopted"):
		get_parent().call_deferred("unadopted",self)


func draw_rounded_rect(_rect,_radius,_color=Color.white):
	var _x=_rect.position.x
	var _y=_rect.position.y
	var _w=_rect.size.x
	var _h=_rect.size.y
	var points = []
	_radius=min(_radius,int(min(_w,_h)/2))
	
	points.append(Vector2(_x+_radius,_y))
	points.append(Vector2(_x+_w-_radius,_y))
	points.append(Vector2(_x+_w,_y+_radius))
	points.append(Vector2(_x+_w,_y+_h-_radius))
	points.append(Vector2(_x+_w-_radius,_y+_h))
	points.append(Vector2(_x+_radius,_y+_h))
	points.append(Vector2(_x,_y+_h-_radius))
	points.append(Vector2(_x,_y+_radius))
	draw_colored_polygon(points,_color)
	
	if _radius>2:
# [TODO] optimize point count if total area is very small
		
		draw_circle_partial(Vector2(_x+_radius,_y+_radius),_radius,_color,180,270)
		draw_circle_partial(Vector2(_x+_w-_radius,_y+_radius),_radius,_color,270,360)
		draw_circle_partial(Vector2(_x+_w-_radius,_y+_h-_radius),_radius,_color,0,90)
		draw_circle_partial(Vector2(_x+_radius,_y+_h-_radius),_radius,_color,90,180)

func draw_circle_partial(_position,radius,color,angle_from,angle_to,point_count=8):
	var points=PoolVector2Array()
	
	angle_from=deg2rad(angle_from)
	angle_to=deg2rad(angle_to)
	var step=(angle_to-angle_from)/int(point_count)
	for i in range(point_count+1):
		var angle = angle_from + step * i
		var x=_position.x+radius*cos(angle)
		var y=_position.y+radius*sin(angle)
		points.append(Vector2(x,y))
	draw_colored_polygon(points,color)




