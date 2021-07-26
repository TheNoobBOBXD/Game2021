extends Sprite3D
#
#onready var bar = $Viewport/HealthBar2D
#
#func update(value, full):
#	bar.update_bar(value, full)
#
#func update_bar(amount, full):
##	$HealthBar3D/Viewport/TextureProgress = bar_green
#	if amount < 0.75 * full:
#		texture_progress = bar_yellow
#	if value < 0.45 * full:
#		texture_progress = bar_red
#	value = amount
#
func _ready():
	pass
	#texture = $Viewpoint.get_texture()
#
#

