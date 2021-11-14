extends Control


func ready():
	$HealthBar.max_value = Playerinfo.health_max #max health is 100 (in playerinfo)


func _process(delta): #basic user interface - shows the ammo and the player lives
	$HealthBar.value = Playerinfo.health
	$LifeCounter.text = "x " + Playerinfo.get_lives()
	$AmmoCount.text = "x " + Playerinfo.get_ammo()
