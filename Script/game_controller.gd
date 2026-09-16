extends Node

var total_coins: int = 0

func coin_collected(value: int):
	total_coins += value
	EventController.emit_signal("coin_collected", total_coins)
	
func bomb_touched(value: int):
	total_coins -= value
	if total_coins < 0:
		total_coins = 0
	EventController.emit_signal("coin_collected", total_coins)
