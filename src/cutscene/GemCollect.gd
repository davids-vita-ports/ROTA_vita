extends Node

func act():
	Cutscene.is_playing = true
	Shared.player.spr_easy.show = false
	var d = Shared.door_in
	d.clock.visible = false
	d.gem.visible = true
	d.gem_color()
	if Wipe.is_wipe:
		yield(Wipe, "complete")
	
	d.gem_fade()
	Audio.play("gem_collect", 0.8)
	UI.up.show = true
	yield(get_tree().create_timer(1.0), "timeout")
	
	UI.gem_label.text = str(Shared.gem_count)
	yield(get_tree().create_timer(0.5), "timeout")
	
	Shared.player.spr_easy.show = true
	UI.up.show = false
	Cutscene.is_playing = false
	
	Cutscene.scene_changed()






