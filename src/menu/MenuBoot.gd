extends MenuBase

export var sub_path : NodePath
onready var main_menu = get_node_or_null(sub_path)

var pos = [Vector2(1800, 650), Vector2(1650, 650)]

func _ready():
	UI.menu.show = true
	
	Cam.rotation = 0
	Cam.target_pos = pos[0]
	Cam.position = Cam.target_pos
	
	Shared.save_slot = -1

func _exit_tree():
	UI.menu.show = false

func _input(event):
	menu_input(event)

func accept():
	audio_accept()
	sub_menu(main_menu)
	Cam.target_pos = pos[1]

func sub_close(arg):
	.sub_close(arg)
	Cam.target_pos = pos[0]
