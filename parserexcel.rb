require 'roo'
require './funcDay'

def funcToday(selectedGroup)

@selectedGroupId = selectedGroup.id

	if $weekNumber == 1 

		return parseArrayPars = funcListPars("Понедельник");

	elsif $weekNumber == 2

		return parseArrayPars = funcListPars("Вторник");

	elsif $weekNumber == 3

		return parseArrayPars = funcListPars("Среда");

	elsif $weekNumber == 4

		return parseArrayPars = funcListPars("Четверг");

	elsif $weekNumber == 5

		return parseArrayPars = funcListPars("Пятница");

	elsif $weekNumber == 6

		return funcListPars("Суббота", @selectedGroupId);

	elsif $weekNumber == 7

		return "Today is sunday. Just chill bro.";

	end


end

def funcTomorrow
	xlsx = Roo::Spreadsheet.open('./parsers.xlsx')
	xlsx = Roo::Excelx.new("./parsers.xlsx")
	listExec = [xlsx.sheet("week").cell('D',24), xlsx.sheet("week").cell('D',26), xlsx.sheet("week").cell('B',28), xlsx.sheet("week").cell('B',30)]
	# print(listExec);
	return listExec
end

