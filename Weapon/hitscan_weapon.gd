extends Node3D

##Rate of fire
@export var fire_rate := 14.0
##Recoil of wepon
@export var recoil := 0.05
##Mesh of wepon
@export var wepon_mesh: Node3D
##Damage of wepon
@export var wepon_damage := 15
##Muzzle flash of wepon
@export var muzzle_flash: GPUParticles3D
##Wepon sparking partical 
@export var sparks: PackedScene

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var cooldown_timer: Timer = $CooldownTimer

var wepon_position: Vector3
var spark_spowned := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if wepon_mesh:
		if muzzle_flash:
			muzzle_flash.lifetime = 1 / fire_rate
		wepon_position = wepon_mesh.position


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
		if muzzle_flash:
			muzzle_flash.restart()
			var spark = sparks.instantiate()
			print("SPARK SPAWNED ", Time.get_ticks_msec())
			add_child(spark)
			spark.global_position = ray_cast_3d.get_collision_point()
			if spark.global_position != ray_cast_3d.get_collision_point():
				spark.queue_free()
			spark.start("Spark")

	
