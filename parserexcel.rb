require 'roo'

def funcToday
	xlsx = Roo::Spreadsheet.open('./parsers.xlsx')
	xlsx = Roo::Excelx.new("./parsers.xlsx")
	listExec = [xlsx.sheet("week").cell('D',24), xlsx.sheet("week").cell('D',26), xlsx.sheet("week").cell('B',28), xlsx.sheet("week").cell('B',30)]
	# print(listExec);
	return listExec
end

def funcTomorrow
	xlsx = Roo::Spreadsheet.open('./parsers.xlsx')
	xlsx = Roo::Excelx.new("./parsers.xlsx")
	listExec = [xlsx.sheet("week").cell('D',24), xlsx.sheet("week").cell('D',26), xlsx.sheet("week").cell('B',28), xlsx.sheet("week").cell('B',30)]
	# print(listExec);
	return listExec
end

