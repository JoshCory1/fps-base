extends GPUParticles3D

@export var animation_player: AnimationPlayer



func start(string: String) -> void:
	if animation_player && !animation_player.is_playing():
		animation_player.play(string)
	else:
		stop()
func  stop() -> void:
	if animation_player:
		animation_player.stop()
