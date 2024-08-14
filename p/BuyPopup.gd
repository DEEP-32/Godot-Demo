extends Control
class_name BuyPopup

signal pop_up_closed

@onready var levelLabel : Label = $PopupContent/CurentLevelLabel
@onready var hundredTimesCoinAmountLabel : Label = $"100XCoinAmount"
@onready var twoHundredTimesCoinAmountLabel : Label = $"200XCoinAmount"
@onready var gemAmountLabelHundred = $TextureButton/GemAmountLabel
@onready var gemAmountLabelTwoHundred = $TextureButton2/GemAmountLabel
@onready var coinLabel : Label = $CurrentCoinLabel
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var timer : Timer = $Timer

func InitializeUI(currentLevel : int,currentCoin : int,hundredXBuyAmount : int , twoHundredXBuyAmount : int):
	print("CURRENT COIN : " + str(currentCoin) + " 100 x: " + str(currentCoin * 100) + " 200 x : " + str(currentCoin * 200))
	levelLabel.set_text("Level " + str(currentLevel))
	gemAmountLabelHundred.set_text(str(hundredXBuyAmount))
	gemAmountLabelTwoHundred.set_text(str(twoHundredXBuyAmount))
	coinLabel.set_text(Globals.FormatNumber(currentCoin))
	hundredTimesCoinAmountLabel.set_text(Globals.FormatNumber(currentCoin * 100))
	twoHundredTimesCoinAmountLabel.set_text(Globals.FormatNumber(currentCoin * 200))
	

func OnCloseButtonPressed():
	visible = false
	pop_up_closed.emit()


func OnHundredXButtonPressed():
	timer.stop()
	if Globals.UseResource(Globals.ResourceType.GEMS,Globals.GetBuyAmount(0)):
		Globals.SetNewCoin(Globals.GetResource(Globals.ResourceType.COIN) * 100)
		visible = false
		pop_up_closed.emit()
	else:
		animationPlayer.play("Gems Toaster")


func OnTwoHundredXButtonPressed():
	timer.stop()
	if Globals.UseResource(Globals.ResourceType.GEMS,Globals.GetBuyAmount(1)):
		Globals.SetNewCoin(Globals.GetResource(Globals.ResourceType.COIN) * 200)
		visible = false
		pop_up_closed.emit()
	else:
		animationPlayer.play("Gems Toaster")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Gems Toaster":
		timer.start(0.5)
		await timer.timeout
		print("TIMER timeouts")
		animationPlayer.play("Gems Toaster Back")
