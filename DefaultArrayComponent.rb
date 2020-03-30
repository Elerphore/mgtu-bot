$weekCount = Time.now.strftime("%U").to_i;
$weekNumber = Time.now.strftime("%u").to_i;

class Group
  def initialize(id, text)
    @id = id;
    @text = text;
  end

  attr_reader :id, :text
end

$firstGroup = Group.new(1, "First Group");
$secondGroup = Group.new(2, "Second Group");

class WeekDay
	def initialize(id, title)
		@id = id;
		@title = title;
	end
	attr_reader :id, :title
end

$Monday = WeekDay.new(1, "Понедельник");
$Tuesday = WeekDay.new(2, "Вторник");
$Wednesday = WeekDay.new(3, "Среда");
$Thursday = WeekDay.new(4, "Четверг");
$Friday = WeekDay.new(5, "Пятница");
$Saturday = WeekDay.new(6, "Суббота");
$Sunday = WeekDay.new(7, "Воскресенье");

$arraysWeek = [$Monday, $Tuesday, $Wednesday, $Thursday, $Friday, $Saturday, $Sunday];

class SubLesson
	def initialize(number, title, day)
		@number = number;
		@title = title;
		@day = day;
	end
	attr_reader :number, :title, :day
end


$cookies = Hash.new;