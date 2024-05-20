extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@onready var sprite_2d = $Sprite2D
@onready var healthbar = $Healthbar
@onready var invulnerability_timer = $InvulnerabilityTimer

# Variables for dash trail & timer
@export var dash_trail_node : PackedScene
@onready var dash_trail_timer = $Dash_Trail_Timer

var jump_count = 0
var jump_max = 2

@export var max_health = 3
var health = max_health


# Variables to help deal with many dash bugs
var canDash = true
var isDashing = false


var is_alive: bool = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#movements and animation
func _physics_process(delta):
	# Adding walk animation
	if(velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "walk1"
	else:
		sprite_2d.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor() and !isDashing:
		velocity.y += gravity * delta

		# Adding jumping frame
		sprite_2d.animation = "jumping"
	
	if is_on_floor():
		jump_count = 0


	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count<jump_max:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right") 
	if direction and !isDashing:
		velocity.x = direction * SPEED
	elif !direction and !isDashing:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()
	
	#correct left turn
	var isLeft = velocity.x < 0
	if direction != 0:
		sprite_2d.flip_h = isLeft

#player spawn
func _ready():
	healthbar.init_health(health)

#player death
func _die():
	is_alive = false
	queue_free()
	#emit_signal("died")

#sets healthbar value
func _set_health(value):
	var prev_health = health
	health = clamp(value,0,max_health)
	healthbar.health = health
	if health != prev_health:
		#emit_signal("health_updated",health)
		if health == 0:
			_die()
			#emit_signal("killed")

#calculates damage and updates health
func _damage(amount):
	if invulnerability_timer.is_stopped:
		invulnerability_timer.start()
		_set_health(health - amount)

# Function to add trail to dash
func add_dash_trail():
	var trail = dash_trail_node.instantiate()
	
	# Turning the trail character when facing left
	var turn_left = velocity.x < 0
	if turn_left:
		trail.flip_h = turn_left
	
	trail.set_property(position, sprite_2d.scale)
	get_tree().current_scene.add_child(trail)


func _on_dash_trail_timer_timeout():
	add_dash_trail()

# Dash function
func dash():
	dash_trail_timer.start()
	isDashing = true # Setting true at start to deal with physics conflicts up there
	
	# Gets direction of dash from where the sprite is facing
	if sprite_2d.flip_h: # This spaghetti was the best global facing direction I could find
		velocity = Vector2(SPEED * -2.25, 0) # Only a change in X velocity and not Y
	else:
		velocity = Vector2(SPEED * 2.25, 0)
	
	await get_tree().create_timer(.5).timeout # Timer for trail to get off 5 sprites
	dash_trail_timer.stop()
	isDashing = false 

func _input(event):
	if event.is_action_pressed("dash") and canDash:
		dash()
		canDash = false
		await get_tree().create_timer(1).timeout # Time between dashes
		canDash = true


func _on_spikes_impaled():
	_damage(1)


