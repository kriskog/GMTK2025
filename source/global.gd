extends Node

enum Stats { MAX_HEALTH, HEALTH, MAX_MANA, MANA, STRENGTH, DEXTERITY, SPEED, MAGIC }

enum Target { ALLY, ENEMY }

enum Status { NONE, SHIELD, PROVOKE, BLESS, HEX, DAMN, HASTE }
enum TargetNumber { ONE, ALL, SELF }

const MAX_DAMAGE = 9999

const MAIN_MENU_SCENE = "res://source/scenes/ui/menus/main_menu.tscn"
const CREDITS_SCENE = "res://source/scenes/ui/elements/creditsscreen.tscn"
const GAME_SCENE = "res://source/scenes/game/game.tscn"
const DEATH_SCENE = "res://source/scenes/ui/menus/death_screen.tscn"

var current_loop = 0
