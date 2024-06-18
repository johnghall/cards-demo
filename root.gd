extends Node2D

@export var card_scene: PackedScene 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var card_pool: Array[int] = get_card_pool()
	card_pool.shuffle()
	var pool_size = card_pool.size() 
	var p1_deck = card_pool.slice(0, pool_size / 2)
	var p2_deck = card_pool.slice(pool_size / 2, pool_size)
	
	var i = 0
	while (p1_deck.size() > 0 && p2_deck.size() > 0):
		print('P1 has ', p1_deck.size(), ' cards')
		print('P2 has ', p2_deck.size(), ' cards')
		i += 1
		print('Playing Round', i)
		var round_successful = play_round(p1_deck, p2_deck)
		if (i > 1000 || !round_successful):
			print('Oops, tie')
			break
	
	if (p1_deck.size() > p2_deck.size()):
		print('P1 wins!')
	else:
		print('P2 wins!')
	
func get_card_pool() -> Array[int]:
	var deck: Array[int] = []	
	for i in 20:
		deck.push_back((i % 5) + 1)
	return deck

func play_round(deck_1: Array[int], deck_2: Array[int]):
	var val_1 = deck_1.pop_front()
	var val_2 = deck_2.pop_front()
	var winner_deck
	if (val_1 > val_2):
		print('P1 wins', val_1, ' > ', val_2)
		winner_deck = deck_1
	# Ties will be a P2 victory, arbitrarily
	else: 
		print('P2 wins', val_2, ' >= ', val_1)
		winner_deck = deck_2
	
	winner_deck.push_back(val_1)
	winner_deck.push_back(val_2)
	return 1
	
