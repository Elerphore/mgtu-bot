require 'roo'
require './CheckSubsLesson'

$xlsx = Roo::Excelx.new("./parsers.xlsx");

def funcListPars(day, groupId)
@daySelected = day;
@parsArray = [];     
$NumberOne = 0;
$NumberTwo = 0;
$mainArray = [];
$countX = 1;
$countY = 3;

$xlsx.each_row_streaming.to_a.flatten.find do |row|
   if row.inspect.include?(day); 
      $mainArray.push(row);
      $NumberOne = $mainArray[0];
      $NumberTwo = $mainArray[1];
   end
end


   if $weekCount.even? == false

      while 
         $xlsx.sheet('week').cell($NumberOne.coordinate[0] + $countX, $NumberOne.coordinate[1] + 1) != nil ||
         $xlsx.sheet('week').cell($NumberOne.coordinate[0] + $countX, $NumberOne.coordinate[1] + 3) != nil

         if groupId == 1
            @parsArray.push($xlsx.sheet('week').cell($NumberOne.coordinate[0] + $countX, $NumberOne.coordinate[1] + 1));

         elsif groupId == 2
           if 
            $xlsx.sheet('week').cell($NumberOne.coordinate[0] + $countX, $NumberOne.coordinate[1] + $countY) == nil &&
            $xlsx.sheet('week').cell($NumberOne.coordinate[0] + $countX + 1, $NumberOne.coordinate[1] + $countY + 1) != nil
               @parsArray.push($xlsx.sheet('week').cell($NumberOne.coordinate[0] + $countX, $NumberOne.coordinate[1] + $countY - 2))
            else 
            @parsArray.push($xlsx.sheet('week').cell($NumberOne.coordinate[0] + $countX, $NumberOne.coordinate[1] + $countY));      
            end
            
         end
         $countX = $countX + 2;
         
      end
         $countX = 1;
					if File.exist?('./changeAgenda.xlsx')
						@arraySubsLess = subsLessonFunc; 
						@arraySubsLess.each do |lesson|
							if lesson.day == @daySelected;
									@parsArray.delete_at(lesson.number - 1);
									@parsArray.insert(lesson.number - 1, lesson.title);
							end
						end
					end
         return @parsArray;

      else
      while 
         $xlsx.sheet('week').cell($NumberTwo.coordinate[0] + $countX, $NumberTwo.coordinate[1] + 1) != nil ||
         $xlsx.sheet('week').cell($NumberTwo.coordinate[0] + $countX, $NumberTwo.coordinate[1] + 3) != nil

         if groupId == 1
            @parsArray.push($xlsx.sheet('week').cell($NumberTwo.coordinate[0] + $countX, $NumberTwo.coordinate[1] + 1));

         elsif groupId == 2
           if $xlsx.sheet('week').cell($NumberTwo.coordinate[0] + $countX, $NumberTwo.coordinate[1] + $countY) == nil &&
               $xlsx.sheet('week').cell($NumberTwo.coordinate[0] + $countX + 1, $NumberTwo.coordinate[1] + $countY + 1) != nil
               
               @parsArray.push($xlsx.sheet('week').cell($NumberTwo.coordinate[0] + $countX, $NumberTwo.coordinate[1] + $countY - 2))
            else 
            @parsArray.push($xlsx.sheet('week').cell($NumberTwo.coordinate[0] + $countX, $NumberTwo.coordinate[1] + $countY));      
            end
         end
         $countX = $countX + 2;
      end
      $countX = 1;
			if File.exist?('./changeAgenda.xlsx')
				@arraySubsLess = subsLessonFunc; 
				@arraySubsLess.each do |lesson|
					if lesson.day == @daySelected;
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
end


