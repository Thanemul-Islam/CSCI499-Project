extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -700.0
@onready var sprite_2d = $Sprite2D
@onready var healthbar = $Healthbar

# Variables for dash trail timer
@export var trail_node : PackedScene
@onready var dash_trail_timer = $Dash_Trail_Timer

var health
var is_alive: bool = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Adding walk animation
	if(velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "walk2"
	else:
		sprite_2d.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		# Adding jumping frame
		sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()
	
	#correct left turn
	var isLeft = velocity.x < 0
	if direction != 0:
		sprite_2d.flip_h = isLeft

func _ready():
	health = 3
	
	healthbar.init_health(health)
	

func _die():
	is_alive = false
	queue_free()

func _set_health(value):
	health = value
	if health <=0 && is_alive:
		_die()
	
	healthbar.health = health


# Function to add trail to dash
func add_trail():
	var trail = trail_node.instantiate()
	
	# Turning the trail character when facing left
	var turn_left = velocity.x < 0
	if turn_left:
		trail.flip_h = turn_left
	
	trail.set_property(position, sprite_2d.scale)
	get_tree().current_scene.add_child(trail)


func _on_dash_trail_timer_timeout():
	add_trail()


# Dash function
func dash():
	dash_trail_timer.start()
	
	var tween = get_tree().create_tween()
	# Had to tweek the position change to only have a change in X axis
	tween.tween_property(self,"position", position + velocity * Vector2(1,0), 0.5)
	
	await tween.finished
	dash_trail_timer.stop()

func _input(event):
	if event.is_action_pressed("dash"):
		dash()
