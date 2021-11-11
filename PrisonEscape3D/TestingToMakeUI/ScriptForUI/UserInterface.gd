extends Control


func ready():
	$HealthBar.max_value = Playerinfo.health_max


func _process(delta):
	$HealthBar.value = Playerinfo.health
	$LifeCounter.text = "x " + Playerinfo.get_lives()
	$AmmoCount.text = "x " + Playerinfo.get_ammo()
