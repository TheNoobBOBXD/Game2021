extends Control


func ready():
	$HealthBar.max_value = Playerinfo.health_max


func _process(delta):
	$HealthBar.value = Playerinfo.health
	$AmmoCount.text = "x " + Playerinfo.get_ammo()
