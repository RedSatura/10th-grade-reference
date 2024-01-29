extends Node2D

enum TournamentState {
	QUARTERFINALS,
	WINNER_SEMIFINALS,
	LOSER_SEMIFINALS,
	LOSER_FINALS,
	FINALS,
	FINALS2,
	FINISHED
}

var tournament_state = TournamentState.QUARTERFINALS

onready var paths = [$RedPath, $YellowPath, $GreenPath, $BluePath, $Loser1Path, $Loser2Path, $Loser3Path, $FinalLoserPath]
onready var path_follows = [$RedPath/RedPathFollow2D, $YellowPath/YellowPathFollow2D, $GreenPath/GreenPathFollow2D, $BluePath/BluePathFollow2D,
$Loser1Path/PathFollow2D, $Loser2Path/PathFollow2D, $Loser3Path/PathFollow2D, $FinalLoserPath/PathFollow2D]
onready var teams = [$RedPath/RedPathFollow2D/Red, $YellowPath/YellowPathFollow2D/Yellow,  $GreenPath/GreenPathFollow2D/Green, $BluePath/BluePathFollow2D/Blue]
onready var tween = $Tween
onready var button = $Button

var winners = []

func _ready():
	randomize()
	
func _draw():
	for x in paths:
		if x == $FinalLoserPath:
			draw_polyline(x.curve.get_baked_points(), Color(0.41, 0.41, 0.41, 0.3), 2, true)
		else:
			draw_polyline(x.curve.get_baked_points(), Color.dimgray, 2, true)

func play_match(guarantee: int = 0):
	var match_result = round(randf() * 100)
	
	if guarantee == 1:
		return 0
	elif guarantee == 2:
		return 1
	
	if match_result < 50:
		return 0
	elif match_result > 50:
		return 1
	else:
		play_match()

func play_quarterfinals():
	if play_match():
		tween.interpolate_property(path_follows[0], "offset", 0, 110, 3)
		tween.start()
		teams[1].queue_free()
		winners.append(path_follows[0])
		var team = load("res://scenes/team.tscn").instance()
		team.color = Color(255, 255, 0)
		path_follows[4].add_child(team)
	else:
		tween.interpolate_property(path_follows[1], "offset", 0, 110, 3)
		tween.start()
		teams[0].queue_free()
		winners.append(path_follows[1])
		var team = load("res://scenes/team.tscn").instance()
		team.color = Color(255, 0, 0)
		path_follows[4].add_child(team)
		
	if play_match():
		tween.interpolate_property(path_follows[2], "offset", 0, 110, 3)
		tween.start()
		teams[3].queue_free()
		winners.append(path_follows[2])
		var team = load("res://scenes/team.tscn").instance()
		team.color = Color(0, 0, 255)
		path_follows[5].add_child(team)
	else:
		tween.interpolate_property(path_follows[3], "offset", 0, 110, 3)
		tween.start()
		teams[2].queue_free()
		winners.append(path_follows[3])
		var team = load("res://scenes/team.tscn").instance()
		team.color = Color(0, 255, 0)
		path_follows[5].add_child(team)
		
func play_winner_semifinals():
	if play_match():
		tween.interpolate_property(winners[0], "offset", 110, 240, 3)
		tween.start()
		winners[1].get_child(0).queue_free()
		winners.append(winners[0])
		var team = load("res://scenes/team.tscn").instance()
		team.color = winners[1].get_child(0).color
		path_follows[6].add_child(team)
	else:
		tween.interpolate_property(winners[1], "offset", 110, 240, 3)
		tween.start()
		winners[0].get_child(0).queue_free()
		winners.append(winners[1])
		var team = load("res://scenes/team.tscn").instance()
		team.color = winners[0].get_child(0).color
		path_follows[6].add_child(team)
		
func play_loser_semifinals():
	if play_match():
		tween.interpolate_property($Loser1Path.get_child(0), "offset", 0, 110, 3)
		tween.start()
		winners.append($Loser1Path)
	else:
		tween.interpolate_property($Loser2Path.get_child(0), "offset", 0, 110, 3)
		tween.start()
		winners.append($Loser2Path)
		
func play_loser_finals():
	if play_match():
		tween.interpolate_property(winners[3].get_child(0), "offset", 110, 210, 3)
		tween.start()
		winners.append(winners[3])
	else:
		tween.interpolate_property($Loser3Path.get_child(0), "offset", 0, 150, 3)
		tween.start()
		winners.append($Loser3Path)

#winners[2] from the winner's side, winners[4] from the losing side
func play_finals():
	if play_match(2):
		tween.interpolate_property(winners[2], "offset", 240, 460, 3)
		tween.start()
		tournament_state = TournamentState.FINISHED
	else:
		if winners[4] == winners[3]:
			tween.interpolate_property(winners[4].get_child(0), "offset", 210, 423, 3)
			tween.start()
			tournament_state = TournamentState.FINALS2
			winners[2].get_child(0).queue_free()
			var team = load("res://scenes/team.tscn").instance()
			team.color = winners[2].get_child(0).color
			path_follows[7].add_child(team)
			tween.interpolate_property(path_follows[7], "offset", 0, 52, 3)
			tween.start()
		else:
			tween.interpolate_property(winners[4].get_child(0), "offset", 140, 345, 3)
			tween.start()
			tournament_state = TournamentState.FINALS2
			winners[2].get_child(0).queue_free()
			var team = load("res://scenes/team.tscn").instance()
			team.color = winners[2].get_child(0).color
			path_follows[7].add_child(team)
			tween.interpolate_property(path_follows[7], "offset", 0, 52, 3)
			tween.start()
	
func play_finals_2():
	if play_match():
		tween.interpolate_property(path_follows[7], "offset", 52, 172, 3)
		tween.start()
		tournament_state = TournamentState.FINISHED
	else:
		if winners[4] == winners[3]:
			tween.interpolate_property(winners[4].get_child(0), "offset", 423, 531, 3)
			tween.start()
			tournament_state = TournamentState.FINISHED
		else:
			tween.interpolate_property(winners[4].get_child(0), "offset", 345, 466, 3)
			tween.start()
			tournament_state = TournamentState.FINISHED
		
func _on_Tween_tween_all_completed():
	match tournament_state:
		TournamentState.QUARTERFINALS:
			tournament_state = TournamentState.WINNER_SEMIFINALS
			button.text = "Play Winner Semifinals"
			button.disabled = false
		TournamentState.WINNER_SEMIFINALS:
			tournament_state = TournamentState.LOSER_SEMIFINALS
			button.text = "Play Loser Semifinals"
			button.disabled = false
		TournamentState.LOSER_SEMIFINALS:
			tournament_state = TournamentState.LOSER_FINALS
			button.text = "Play Loser Finals"
			button.disabled = false
		TournamentState.LOSER_FINALS:
			tournament_state = TournamentState.FINALS
			button.text = "Play Finals"
			button.disabled = false
		TournamentState.FINALS:
			pass
		TournamentState.FINALS2:
			button.text = "Play Finals 2"
			button.disabled = false
		TournamentState.FINISHED:
			button.text = "Restart"
			button.disabled = false

func _on_Button_pressed():
	match tournament_state:
		TournamentState.QUARTERFINALS:
			button.disabled = true
			play_quarterfinals()
		TournamentState.WINNER_SEMIFINALS:
			button.disabled = true
			play_winner_semifinals()
		TournamentState.LOSER_SEMIFINALS:
			button.disabled = true
			play_loser_semifinals()
		TournamentState.LOSER_FINALS:
			button.disabled = true
			play_loser_finals()
		TournamentState.FINALS:
			button.disabled = true
			play_finals()
		TournamentState.FINALS2:
			button.disabled = true
			play_finals_2()
		TournamentState.FINISHED:
			get_tree().change_scene("res://scenes/world.tscn")
