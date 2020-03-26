require 'roo'
require './DefaultArrayComponent'


def subsLessonFunc
@agenda = Roo::Spreadsheet.open('./changeAgenda.xlsx') if File.exist?('./changeAgenda.xlsx')

	$i = 1;
	$arrayLessons = [];

	@agenda.sheet(0).column('V').each do |row|
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