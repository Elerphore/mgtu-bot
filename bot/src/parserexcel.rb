require './bot/src/funcDay.rb'
require './bot/src/DefaultArrayComponent'
require './bot/src/CheckAgendaDate.rb'


def funcToday(selectedGroup, selectedDay, groupTitle)
@currNumber = $weekNumber;
if selectedDay == 1
	@currNumber = $weekNumber - 1;
end
	return funcListPars($arraysWeek[@currNumber].title, selectedGroup.id, groupTitle);
end