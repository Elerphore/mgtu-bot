require 'roo'
require './bot/src/DefaultArrayComponent'

def subsLessonFunc(group)
@numberColumn = nil;

@agenda = Roo::Spreadsheet.open('./xlsx/changeAgenda.xlsx') if File.exist?('./xlsx/changeAgenda.xlsx')
@agenda.each_row_streaming.to_a.flatten.find do |row|
	if row.inspect.include?(group); 
		@numberColumn = row.coordinate[1];
	end
end
	$i = 1;
	$arrayLessons = [];

	@agenda.sheet(0).column(@numberColumn).each do |row|
		$i = $i + 1;
		if row != nil && !/.{1,5}-\d{1,5}-\d{1,5}/.match?(row.inspect)
		@numLess = @agenda.sheet(0).cell($i, 'O');
		@dayCount = $i - (@agenda.sheet(0).cell($i, 'O') - 1) ;
		@dayTitle = @agenda.sheet(0).cell(@dayCount, 'M');
		@lesson = SubLesson.new(@numLess, row, @dayTitle);
		$arrayLessons.push(@lesson)
		end
	end
	return $arrayLessons;
end