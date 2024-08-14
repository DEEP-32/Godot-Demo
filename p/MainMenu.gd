extends Control
class_name MainMenu

@export var xpIncreamentAmount : int =20

@onready var levelLabel : Label = $BG/LevelLabel
@onready var coinLabel : Label = $BG/CoinLabel
@onready var gemsLabel : Label = $BG/GemLabel
@onready var levelProgressBar : TextureProgressBar = $BG/ProgressBar
@onready var buyPopup : BuyPopup = $BuyPopup


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.level_up.connect(OnLevelUp)
	InitializeUI(
		Globals.GetResource(Globals.ResourceType.COIN),
		Globals.GetResource(Globals.ResourceType.GEMS),
		Globals.GetCurrentXp(),
		Globals.GetCurrentLevel(),
		Globals.GetCurrentMaxXp()
	)
	
	buyPopup.InitializeUI(
		Globals.GetCurrentLevel(),
		Globals.GetResource(Globals.ResourceType.COIN),
		Globals.GetBuyAmount(0),
		Globals.GetBuyAmount(1)
	)


func InitializeUI(coinQuantity : int, gemsQuantity : int,xp : int,level : int,maxXP : float):
	coinLabel.set_text(Globals.FormatNumber(coinQuantity))
	gemsLabel.set_text(str(gemsQuantity))
	levelProgressBar.value = xp
	levelProgressBar.max_value = maxXP
	levelLabel.set_text(str(level))





func OnXpButtonPressed():
	Globals.GainXp(xpIncreamentAmount)
	levelProgressBar.value += xpIncreamentAmount


func OnLevelUp():
	buyPopup.InitializeUI(
		Globals.GetCurrentLevel(),
		Globals.GetResource(Globals.ResourceType.COIN),
		Globals.GetBuyAmount(0),
		Globals.GetBuyAmount(1)
	)
	
	buyPopup.animationPlayer.play("RESET")
	coinLabel.set_text(Globals.FormatNumber(Globals.GetResource(Globals.ResourceType.COIN)))
	
	buyPopup.visible = true



func OnBuypopupClosed():
	
	Globals.PostLevelUp()
	
	InitializeUI(
		Globals.GetResource(Globals.ResourceType.COIN),
		Globals.GetResource(Globals.ResourceType.GEMS),
		Globals.GetCurrentXp(),
		Globals.GetCurrentLevel(),
		Globals.GetCurrentMaxXp()
	)
	
