extends Node

signal level_up

enum ResourceType{
	COIN,
	GEMS
}

var defaultXpValue : int = 0
var defaultMaxXpValue : int = 100
var defaultCoinValue : int = 1000
var defaultGemValue : int = 500
var defaultLevelValue : int = 1



var maxXpIncreament : float = .5 
var coinIncreament : int = 100

var buyAmount : Array = [
	50,
	100
]

var _currentXpValue : int
var _currentCoinValue : int
var _currentGemValue : int
var _currentXpMaxValue : int
var _currentLevelValue : int


func _ready():
	_currentXpValue = defaultXpValue
	_currentCoinValue = defaultCoinValue
	_currentGemValue = defaultGemValue
	_currentXpMaxValue = defaultMaxXpValue
	_currentLevelValue = defaultLevelValue


func UseResource(resourceType : ResourceType , usedAmt : int):
	match resourceType:
		ResourceType.COIN:
			if usedAmt <= _currentCoinValue:
				_currentCoinValue = DecreaseResource(_currentCoinValue,usedAmt)
		ResourceType.GEMS:
			if usedAmt <= _currentGemValue:
				_currentGemValue = DecreaseResource(_currentGemValue,usedAmt)
		_:
			pass




func DecreaseResource(currentCount : int , amount : int):
	return currentCount - amount

func IncreaseCoin(amount : int):
	_currentCoinValue += amount


func GetResource(resourceType : ResourceType) -> int:
	match resourceType:
		ResourceType.COIN:
			return _currentCoinValue
		ResourceType.GEMS:
			return _currentGemValue
		_:
			return 0



func GetCurrentXp():
	return _currentXpValue

func GetCurrentMaxXp():
	return _currentXpMaxValue

func GetCurrentLevel():
	return _currentLevelValue

func GainXp(xp : int):
	_currentXpValue += xp
	if _currentXpValue >= _currentXpMaxValue:
		#Setting xp on level up
		print("GLOBALS : new max xp : " + str(_currentXpMaxValue))
		level_up.emit()

func GetBuyAmount(index : int):
	
	if index < 0 || index > buyAmount.size() - 1:
		return 0
	
	
	return buyAmount[index]

func PostLevelUp():
	_currentXpValue = 0
	_currentLevelValue += 1
	var increament = _currentXpMaxValue * maxXpIncreament
	_currentXpMaxValue += increament


func FormatNumber(n: int) -> String:
	if n >= 1_000_000_000_000:
		var i:float = snapped(float(n)/1_000_000_000_000, .01)
		return str(i).replace(",", ".") + "B"
	elif n >= 1_000_000:
		var i:float = snapped(float(n)/1_000_000, .01)
		return str(i).replace(",", ".") + "M"
	elif n >= 1_000:
		var i:float = snapped(float(n)/1_000, .01)
		return str(i).replace(",", ".") + "k"
	else:
		return str(n)


func GetCoinFormated():
	FormatNumber(_currentCoinValue)
