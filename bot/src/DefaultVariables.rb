class Group
	def initialize(id, text)
		@id = id
		@text = text
	end

	attr_reader :id, :text
end

$firstGroup = Group.new(1, "First Group")
$secondGroup = Group.new(2, "Second Group")

class WeekDay
	def initialize(id, title, subtitle)
		@id = id
		@title = title
		@subtitle = subtitle
	end
	attr_reader :id, :title, :subtitle
end

$Monday = WeekDay.new(1, "Понедельник", "Понедельник")
$Tuesday = WeekDay.new(2, "Вторник", "Вторник")
$Wednesday = WeekDay.new(3, "Среда", "Среду")
$Thursday = WeekDay.new(4, "Четверг", "Четверг")
$Friday = WeekDay.new(5, "Пятница", "Пятницу")
$Saturday = WeekDay.new(6, "Суббота", "Субботу")
$Sunday = WeekDay.new(7, "Понедельник", "Понедельник")

$arraysWeek = [$Monday, $Tuesday, $Wednesday, $Thursday, $Friday, $Saturday, $Sunday, $Sunday]

class SubLesson
	def initialize(number, title, day)
		@number = number
		@title = title
		@day = day
	end
	attr_reader :number, :title, :day
end

$cookies = Hash.new

$mainKeyBoardButtons = [
	[Telegram::Bot::Types::KeyboardButton.new(text: 'Сегодня 1 группа'),
		Telegram::Bot::Types::KeyboardButton.new(text: 'Сегодня 2 группа')],
		[Telegram::Bot::Types::KeyboardButton.new(text: 'Завтра 1 группа'),
		Telegram::Bot::Types::KeyboardButton.new(text: 'Завтра 2 группа')],
		[Telegram::Bot::Types::KeyboardButton.new(text: 'Изменить группу')]
]
$daySelect = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: $mainKeyBoardButtons, one_time_keyboard: false)

