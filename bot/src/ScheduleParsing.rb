require 'roo'

require './bot/src/CheckSubsLesson'

$countY = 3

def funcListParse(groupTitle, groupId, day)
	groupId += 1
	
	@parseArray = []
	@mainArray = []
	$countX = 1
	
	CheckBaseAgendaExist(groupTitle)
	$xlsx = Roo::Excelx.new("./bot/xlsx/BaseAgendaFiles/#{groupTitle}.xlsx")
	
	$xlsx.each_row_streaming.to_a.flatten.find do |row|
		if row.inspect.include?(day[:title])
			@mainArray.push(row)
			@NumberOne = @mainArray[0]
			@numberTwo = @mainArray[1]
		end
	end
	
	if Time.now.strftime("%U").to_i.even? == false
		@currentWeek = @NumberOne
	else
		@currentWeek = @numberTwo
	end
	
	while $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 1) != nil ||
	$xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 3) != nil
		if groupId == 1
			@classRoom = nil
			if $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 1) != nil
				if $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 2) != nil
					@classRoom = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 2)
				else
					@classRoom = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 4)
				end
				@classCount = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1])
				@classTeacher = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 1)
				@classTitle = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 1)
				@class = Hash.new
				@class = {:room => @classRoom, :count => @classCount, :teacher => @classTeacher, :title => @classTitle}
				@parseArray.push(@class)
			end
		elsif groupId == 2
			@class = Hash.new
			if $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + $countY) == nil &&
			$xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + $countY + 1) != nil
				@classTitle = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + $countY - 2)
				@classCount = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1])
				@classTeacher = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 1)
				@classRoom = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 4)
				@class = {:room => @classRoom, :count => @classCount, :teacher => @classTeacher, :title => @classTitle}
				@parseArray.push(@class)
			else
				@classTitle = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + $countY)
				@classRoom = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + $countY + 1)
				@classTeacher = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + $countY)
				@classCount = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1])
				@class = {:room => @classRoom, :count => @classCount, :teacher => @classTeacher, :title => @classTitle}
				
				@parseArray.push(@class)
			end
		end
		$countX = $countX + 2
	end
	
	if File.exist?('./bot/xlsx/changeAgenda.xlsx')
		subsClassFunc(groupTitle).each do |class|
			if class[:dayTitle] == day[:title]
				@parseArray[class[:count] - 1] = class
			end
		end
	end
	@string = ''
	@parseArray.each do |less|
		if less[:title] != nil
			@string =  @string + "#{less[:count]}. #{less[:title]} #{less[:teacher]} #{less[:room]} " + "\n"
		end
	end
	@poststring = "Расписание группы: #{groupTitle} на #{day[:subtitle]}: \n\n"
	return @poststring + @string
end
