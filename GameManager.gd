extends Node2D

var inventory = {
	"Pokebolas": {"quantidade": 5, "max": 5}
}

var listDialogue = {
	"Janela" : [{"name": "Eu", "text": "Um pouco embassada, mas da pra ver o lado de dentro."}],
	"CaixaCorreio" : [{"name": "Eu", "text": "Há varias cartas, mas nenhuma para mim"}],
	"BlockedPassage" : [
		{"name": "Eu", "text": "Parece que um snorlax está atrapalhando o caminho."},
		{"name": "Eu", "text": "Infelizmente eu nao tenho a pokeflaute para acordá-lo."},
		{"name": "Eu", "text": "Talvez se eu juntar 5 pokebolas eu consiga capturalo na sorte."}
	],
	"NotDev": [{"name": "System", "text": "Ainda não desenvolvido, volte mais tarde!"}],
	"PlacaFlores": [{"name": "Placa", "text": "Parque das flores."}],
	"PlacaReforma": [{"name": "Placa", "text": "Em reforma, novas flores a caminho."}],
	"PokebolasOak": [{"name": "Eu", "text": "Já fiz minha escolha a muito tempo."}],
	"AreaTrabalho": [{"name": "Maquinas", "text": "Nhek ... nhenhek ... nhok."}],
	"EggOakLab": [{"name": "Eu", "text": "Um ovo raro de pokemon, espero conseguir ver o que é quando chocar."}],
	"ExtractorLab": [{"name": "Maquina", "text": "Plak Plak Plak ... Plak Plak Plak ..."}],
	"BooksLabs": [{"name": "Eu", "text": "Uma pilha de livros e arquivos jogados no chao."}],
	"Arvores": [{"name": "Eu", "text": "Algumas plantas para deixar o clima zen."}],
	"Oak": [
		{"name": "Prof. Oak", "text": "Olá, obrigado por me passar os dados de sua pokedex"},
		{"name": "Prof. Oak", "text": "foi de extrema ajuda para minha pesquisa."}
	],
	"Pokebolas": get_text_pokebolas(),
	"CatchSnorlax": [{"name": "System", "text": "Snorlax capturado! movido para o pc do bill."}],
}

var inventory_list = [
	'Pokebolas'
]

func get_text_pokebolas():
	if inventory and inventory['Pokebolas'].quantidade >= 10:
		return [{"name": "Eu", "text": "Uau, uma pokebola, infelizmente ja tenho muitas."}]
	
	return  [
		{"name": "Eu", "text": "Uau, uma pokebola, irei colocar no meu inventário."},
		{"name": "System", "text": "Pokebola foi adicionada ao inventário."}
	]

func _ready():
	Utils.get_pokeball_count().bbcode_text = ('[center]' + str(inventory['Pokebolas'].quantidade) + '[/center]')
	pass 

func has_name_at_list(name: String):
	return listDialogue.has(name);

func att_dialogue(name: String):
	if name == 'Pokebolas':
		listDialogue[name] = get_text_pokebolas()

func call_dialogue(name: String):
	att_dialogue(name)
	Utils.get_dialogue().start(listDialogue[name])

func has_inventory_item_name(name: String):
	return inventory_list.has(name)

func add_inventory_item(name: String):
	if inventory_list.has(name) and inventory[name].quantidade < 10:
		inventory[name].quantidade += 1
		if name == 'Pokebolas':
			Utils.get_pokeball_count().bbcode_text = ('[center]' + str(inventory[name].quantidade) + '[/center]')

func can_get(name: String) -> bool:
	if (has_name_at_list(name)):
		return inventory[name].quantidade < inventory[name].max
	return false

func get_quantity_item_inventory(name: String):
	if inventory_list.has(name):
		return inventory[name].quantidade
	return 0
