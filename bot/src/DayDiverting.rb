require './bot/src/ScheduleParsing.rb'
require './bot/src/DefaultVariables.rb'
require './bot/src/CheckAgendaDate.rb'

def funcToday(selectedGroup, selectedDay, groupTitle)
	@currNumber = Time.now.strftime("%u").to_i
	if selectedDay == 1
		@currNumber -= 1
	end
	return funcListParse($arraysWeek[@currNumber], selectedGroup.id, groupTitle)
end
