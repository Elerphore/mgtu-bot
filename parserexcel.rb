require 'roo'
require './funcDay'
require './DefaultArrayComponent'

def funcToday(selectedGroup, selectedDay)

@selectedGroupId = selectedGroup.id
@selectedDay = selectedDay;
		p $selectedDay;

	if $weekNumber == 1 

		return parseArrayPars = funcListPars("Понедельник");

	elsif $weekNumber == 2

		return parseArrayPars = funcListPars("Вторник");

	elsif $weekNumber == 3

		return parseArrayPars = funcListPars("Среда");

	elsif $weekNumber == 4

		return parseArrayPars = funcListPars("Четверг");

	elsif $weekNumber == 7

		case @selectedDay
		when 1
			p $arraysWeek[4].title;
			return funcListPars($arraysWeek[4].title, @selectedGroupId);
		when 2
			p $arraysWeek[5].title;
			return funcListPars($arraysWeek[5].title, @selectedGroupId);
		end

	elsif $weekNumber == 6

		case @selectedDay
		when 1
			return funcListPars($arraysWeek[5].title, @selectedGroupId);
		when 2
			return "Tomorrow will be sunday!"
		end


	elsif $weekNumber == 5
		
		case @selectedDay
		when 1
			return "Today is sunday. Just chill bro.";
		when 2
			return funcListPars("Понедельник", @selectedGroupId);		
		end

	end
end