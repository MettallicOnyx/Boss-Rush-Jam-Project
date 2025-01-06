extends Node2D

@export var ammo_amount: int = 5

func item_ability(player: Player):
	player.weapon_list[0].current_ammo += 5
