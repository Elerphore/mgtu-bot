require 'roo'
require './DefaultArrayComponent'


def subsLessonFunc(group)
@numberColumn = nil;

@agenda = Roo::Spreadsheet.open('./changeAgenda.xlsx') if File.exist?('./changeAgenda.xlsx')
@agenda.each_row_streaming.to_a.flatten.find do |row|
	if row.inspect.include?(group); 
		p row.coordinate;
		@numberColumn = row.coordinate[1];
	end
end

p @numberColumn;


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