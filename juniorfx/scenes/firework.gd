extends Node2D

@onready var particle: CPUParticles2D = $CharacterBody2D/CPUParticles2D

func _ready():
	particle.emitting = true
