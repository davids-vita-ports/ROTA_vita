extends CanvasLayer

onready var gem_label : Label = $Control/Gems/Label

onready var zoom_notch := $Control/Top/Zoom/Slider/Notch
onready var zoom_circle := $Control/Top/Zoom/Circle
var zoom_from := 0.0
var zoom_to := 0.0

var gem = EaseMover.new()
var top = EaseMover.new()
var menu = EaseMover.new()
var zoom = EaseMover.new()

func _ready():
	Shared.connect("scene_changed", self, "scene_changed")
	
	gem_label.text = str(Shared.gem_count)
	
	gem.node = $Control/Gems
	gem.to = gem.node.rect_position
	gem.from = gem.to - Vector2(0, 120)
	gem.show = false
	
	top.node = $Control/Top
	top.to = top.node.rect_position
	top.from = top.to - Vector2(0, 125)
	
	zoom.time = 0.25
	zoom_circle.scale = Vector2.ZERO
	
	menu.node = $Control/Menu
	menu.to = menu.node.rect_position
	menu.from = menu.to + Vector2(0, 80)
	menu.show = false
	
	gem_label.text = str(Shared.gem_count)

func _physics_process(delta):
	var p = MenuPause.is_open
	gem.move(delta, gem.show or p)
	top.move(delta, p)
	menu.move(delta)
	
	if zoom.clock != zoom.time:
		zoom.count(delta)
		zoom_circle.scale = Vector2.ONE * lerp(zoom_from, zoom_to, zoom.frac())

func set_zoom(frac := 0.0):
	zoom_notch.position.y = lerp(8, 56, frac)
	
	zoom_from = zoom_circle.scale.x
	zoom_to = lerp(0.0, 1.0, frac)
	zoom.clock = 0

func scene_changed():
	UI.gem.clock = 0.0

func menu_keys(accept := "", cancel := ""):
	var c = $Control/Menu/Items.get_children()
	
	# accept
	var is_a = accept != ""
	c[0].visible = is_a # label
	c[0].text = accept
	c[1].visible = is_a # key
	
	# cancel
	var is_c = cancel != ""
	c[2].visible = is_c # spacer
	c[3].visible = is_c # label
	c[3].text = cancel
	c[4].visible = is_c # key
	
