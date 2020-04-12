require './bot/src/funcDay.rb'
require './bot/src/DefaultArrayComponent'
require './bot/src/CheckAgendaDate.rb'

def funcToday(selectedGroup, selectedDay, groupTitle)
@currNumber = Time.now.strftime("%u").to_i;
p @currNumber;
if selectedDay == 1
	@currNumber = Time.now.strftime("%u").to_i - 1;
end
p $arraysWeek[@currNumber];
	return funcListPars($arraysWeek[@currNumber].title, selectedGroup.id, groupTitle);
end