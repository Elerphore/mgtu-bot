require 'roo'
require './CheckSubsLesson'
$countX = 1;
$countY = 3;

def funcListPars(day, groupId, groupTitle)
@parsArray = [];     
@mainArray = [];

CheckBaseAgendaExist(groupTitle)
$xlsx = Roo::Excelx.new("BaseAgendaFiles/#{groupTitle}.xlsx");

$xlsx.each_row_streaming.to_a.flatten.find do |row|
	if row.inspect.include?(day); 
		@mainArray.push(row);
		@NumberOne = @mainArray[0];
		@numberTwo = @mainArray[1];
	end
end

if $weekCount.even? == false;
	@currentWeek = @NumberOne;
else
	@currentWeek = @numberTwo;
end

      while 
         $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 1) != nil ||
         $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 3) != nil

         if groupId == 1
            @parsArray.push($xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 1));

         elsif groupId == 2
           if $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + $countY) == nil &&
               $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + $countY + 1) != nil
               
               @parsArray.push($xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + $countY - 2))
            else 
            @parsArray.push($xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + $countY));      
            end
         end
         $countX = $countX + 2;
      end
      $countX = 1;
			if File.exist?('./changeAgenda.xlsx')
				@arraySubsLess = subsLessonFunc(groupTitle); 
				@arraySubsLess.each do |lesson|
					if lesson.day == day;
							@parsArray.delete_at(lesson.number - 1);
							@parsArray.insert(lesson.number - 1, lesson.title);
					end
				end
			end
			@parsedArray = [];
			@string = '';
			@parsArray.each do |less|
				if less == nil || /\d.\-{2,10}/.match?(less) || /\-{2,10}/.match?(less)
					less = "Пары нет"
				end
				
				@string =  @string + "\n" + "#{less}";
			end
			
			p @string;
      return @string;
end