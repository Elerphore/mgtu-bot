require 'roo'
require './bot/src/CheckSubsLesson'
$countY = 3;

def funcListPars(day, groupId, groupTitle)
@parsArray = [];     
@mainArray = [];
$countX = 1;

CheckBaseAgendaExist(groupTitle)
$xlsx = Roo::Excelx.new("./bot/xlsx/BaseAgendaFiles/#{groupTitle}.xlsx");

$xlsx.each_row_streaming.to_a.flatten.find do |row|
	if row.inspect.include?(day.title); 
		@mainArray.push(row);
		@NumberOne = @mainArray[0];
		@numberTwo = @mainArray[1];
	end
end

if Time.now.strftime("%U").to_i.even? == false;
	@currentWeek = @NumberOne;
else
	@currentWeek = @numberTwo;
end
      while 
         $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 1) != nil ||
         $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 3) != nil
         if groupId == 1
         	@lessonRoom = nil;
         	if $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 1) != nil
         		if $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 2) != nil
         			@lessonRoom = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 2)
         		else
         			@lessonRoom = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 4);
         		end
         		@lessonCount = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1]);
         		@lessonTeacher = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 1);
         		@lessonTitle = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + 1);
         		@class = Hash.new;
         		@class = {:room => @lessonRoom, :count => @lessonCount, :teacher => @lessonTeacher, :title => @lessonTitle};
         		@parsArray.push(@class);
         	end
         elsif groupId == 2
         		@class = Hash.new;
           if $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + $countY) == nil &&
             	$xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + $countY + 1) != nil
             	@lessonTitle = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + $countY - 2);
         			@lessonCount = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1]);
         			@lessonTeacher = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 1);
         			@lessonRoom = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + 4);
	         		@class = {:room => @lessonRoom, :count => @lessonCount, :teacher => @lessonTeacher, :title => @lessonTitle};
             	@parsArray.push(@class)
            else 
            @lessonTitle = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1] + $countY);
         		@lessonRoom = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + $countY + 1);
         		@lessonTeacher = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX + 1, @currentWeek.coordinate[1] + $countY);
						@lessonCount = $xlsx.sheet(0).cell(@currentWeek.coordinate[0] + $countX, @currentWeek.coordinate[1]);
	         	@class = {:room => @lessonRoom, :count => @lessonCount, :teacher => @lessonTeacher, :title => @lessonTitle};

            @parsArray.push(@class);
            end
         end
         $countX = $countX + 2;
      end
			if File.exist?('./bot/xlsx/changeAgenda.xlsx')
				subsLessonFunc(groupTitle).each do |lesson|
					if lesson[:dayTitle] == day.title;
							@parsArray.delete_at(lesson[:count] - 2);
							@parsArray.insert(lesson[:count] - 2, lesson);
					end
				end
			end
			@string = '';
			@parsArray.each do |less|
				if less[:title] != nil
					@string =  @string + "#{less[:count]}. #{less[:title]} #{less[:teacher]} #{less[:room]} " + "\n";
				end
		end
		@poststring = "Расписание группы: #{groupTitle} на #{day.subtitle}: \n\n"
	return @poststring + @string;
end