extends Node3D

##Rate of fire
@export var fire_rate := 14.0
##Recoil of wepon
@export var recoil := 0.05
##Mesh of wepon
@export var wepon_mesh: Node3D
##Damage of wepon
@export var wepon_damage := 15

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var cooldown_timer: Timer = $CooldownTimer
#var ray_cast_3d: RayCast3D

var wepon_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if wepon_mesh:
		wepon_position = wepon_mesh.position
	#if ray_cast_3d:
		#ray_cast_3d = $RayCast3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		if cooldown_timer.is_stopped():
			shoot()
	if wepon_mesh:
		wepon_mesh.position = wepon_mesh.position.lerp(wepon_position, delta * 10.0)

func shoot() -> void:
	cooldown_timer.start(1.0 / fire_rate)
	if ray_cast_3d:
		var collider = ray_cast_3d.get_collider()
		printt("Weapon fierd", collider)
		if collider is Enemy:
			collider.hitpoints -= wepon_damage
	if wepon_mesh:
		wepon_mesh.position.z += recoil
