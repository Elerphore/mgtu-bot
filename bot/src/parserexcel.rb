require './bot/src/funcDay.rb'
require './bot/src/DefaultArrayComponent'
require './bot/src/CheckAgendaDate.rb'


def funcToday(selectedGroup, selectedDay, groupTitle)
@selectedGroupId = selectedGroup.id
@selectedDay = selectedDay;

	if $weekNumber == 1 

		case @selectedDay
		when 1
			return funcListPars($arraysWeek[0].title, @selectedGroupId, groupTitle);
		when 2
			return funcListPars($arraysWeek[1].title, @selectedGroupId, groupTitle);
		end

	elsif $weekNumber == 2

		case @selectedDay
		when 1
			return funcListPars($arraysWeek[1].title, @selectedGroupId, groupTitle);
		when 2
			return funcListPars($arraysWeek[2].title, @selectedGroupId, groupTitle);
		end

	elsif $weekNumber == 3

		case @selectedDay
		when 1
			return funcListPars($arraysWeek[2].title, @selectedGroupId, groupTitle);
		when 2
			return funcListPars($arraysWeek[3].title, @selectedGroupId, groupTitle);
		end

	elsif $weekNumber == 4

		case @selectedDay
		when 1
			return funcListPars($arraysWeek[3].title, @selectedGroupId, groupTitle);
		when 2
			return funcListPars($arraysWeek[4].title, @selectedGroupId, groupTitle);
		end

	elsif $weekNumber == 5

		case @selectedDay
		when 1
			return funcListPars($arraysWeek[4].title, @selectedGroupId, groupTitle);
		when 2
			return funcListPars($arraysWeek[5].title, @selectedGroupId, groupTitle);
		end

	elsif $weekNumber == 6

		case @selectedDay
		when 1
			return funcListPars($arraysWeek[5].title, @selectedGroupId, groupTitle);
		when 2
			return "Tomorrow will be sunday!"
		end


	elsif $weekNumber == 7
		
		case @selectedDay
		when 1
			return "Today is sunday. Just chill bro.";
		when 2
			return funcListPars($arraysWeek[0].title, @selectedGroupId, groupTitle);		
		end

	end
end