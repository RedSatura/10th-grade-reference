extends Node2D

onready var paths = [$Node2D/Red, $Node2D/Yellow, $Node2D/Green, $Node2D/Blue]
onready var path_follows = [$Node2D/Red/PathFollow2D, $Node2D/Yellow/PathFollow2D, $Node2D/Green/PathFollow2D, $Node2D/Blue/PathFollow2D]
onready var tween = $Tween
onready var button = $Button

var finalists = []

enum TournamentState {
	SEMIFINALS, 
	FINALS, 
	FINISHED,
}

var tournament_state = TournamentState.SEMIFINALS

const PATH_SPEED = 0.01

func _ready():
	randomize()

func _draw():
	for x in paths:
		draw_polyline(x.curve.get_baked_points(), Color.dimgray, 2, true)

# warning-ignore:unused_argument
func _physics_process(delta):
	pass
	
func play_semifinals():
	tournament_state = TournamentState.SEMIFINALS
	var games = [play_match(), play_match()]
	if games[0]:
		tween.interpolate_property(path_follows[0], "offset", 0, 190, 3)
		tween.start()
		finalists.append(path_follows[0])
	else:
		tween.interpolate_property(path_follows[1], "offset", 0, 190, 3)
		tween.start()
		finalists.append(path_follows[1])
		
	if games[1]:
		tween.interpolate_property(path_follows[2], "offset", 0, 190, 3)
		tween.start()
		finalists.append(path_follows[2])
	else:
		tween.interpolate_property(path_follows[3], "offset", 0, 190, 3)
		tween.start()
		finalists.append(path_follows[3])

func play_finals():
	var result = play_match()
	#if result > 50, retruns 1 == true, else returns 0 == false
	if result:
			tween.interpolate_property(finalists[0], "offset", 190, 470, 3)
			tween.start()
	else:
		if finalists[1]:
			tween.interpolate_property(finalists[1], "offset", 190, 470, 3)
			tween.start()

func play_match():
	var match_result = round(randf() * 100)
	if match_result < 50:
		return 0
	elif match_result > 50:
		return 1
	else:
		play_match()

func _on_Tween_tween_all_completed():
	match tournament_state:
		TournamentState.SEMIFINALS:
			tournament_state = TournamentState.FINALS
			button.disabled = false
			button.text = "Play Finals"
		TournamentState.FINALS:
			tournament_state = TournamentState.FINISHED
			button.disabled = false
			button.text = "Reset"
		TournamentState.FINISHED:
			pass

func _on_Button_pressed():
	match tournament_state:
		TournamentState.SEMIFINALS:
			play_semifinals()
			button.disabled = true
		TournamentState.FINALS:
			play_finals()
			button.disabled = true
		TournamentState.FINISHED:
			get_tree().reload_current_scene()
