require 'roo'
$xlsx = Roo::Excelx.new("./parsers.xlsx");

def funcListPars(day, groupId)
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
      return @parsArray;
end
end


