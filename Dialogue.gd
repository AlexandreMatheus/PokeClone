extends CanvasLayer

var dialogue = []
var current_dialogue_id = 0
var d_active = false
var m_active = false

func _ready():
	$NinePatchRect.visible = false
	Utils.get_memorial().visible = false

func start(dialogue_passed):
	if d_active:
		return
	Utils.get_player().stop_input = true
	d_active = true
	$NinePatchRect.visible = true
	dialogue = dialogue_passed
	current_dialogue_id = -1
	next_script()

func _input(event):
	if (
		event.is_action_pressed("x")
		and m_active
	):
		Utils.get_player().stop_input = false
		Utils.get_memorial().visible = false
		m_active = false
	if (
		event.is_action_pressed("z") 
		and not m_active 
		and Utils.get_player_collision().has_interaction_collision()
		and Utils.get_player_collision().get_name() == 'Memorial'
	):
		Utils.get_player().stop_input = true
		Utils.get_memorial().visible = true
		m_active = true
		return
	if event.is_action_pressed("z") and not d_active and Utils.get_player_collision().has_interaction_collision():
		var name = Utils.get_player_collision().get_name()
		if name == 'BlockedPassage' and Utils.get_game_manager().get_quantity_item_inventory('Pokebolas') >= 5:
			Utils.get_game_manager().call_dialogue('CatchSnorlax')
			Utils.get_player_collision().delete_item()
			return
		elif Utils.get_game_manager().has_name_at_list(name):
			Utils.get_game_manager().call_dialogue(name)
			return
	elif not d_active:
		return
	elif event.is_action_pressed("z"):
		next_script()

func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue):
		Utils.get_player().stop_input = false
		d_active = false
		$NinePatchRect.visible = false
		var manager = Utils.get_game_manager()
		if (
			Utils.get_player_collision().is_item()
			and manager.has_inventory_item_name(Utils.get_player_collision().get_name())
		):
			manager.add_inventory_item(Utils.get_player_collision().get_name())
			if (manager.can_get(Utils.get_player_collision().get_name())):
				Utils.get_player_collision().delete_item()
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Chat.text = dialogue[current_dialogue_id]['text']
