require 'roo'

def subsLessonFunc(group)
	@numberColumn = nil
	@agenda = Roo::Spreadsheet.open('./bot/xlsx/changeAgenda.xlsx') if File.exist?('./bot/xlsx/changeAgenda.xlsx')
	@agenda.each_row_streaming.to_a.flatten.find do |row|
		if row.inspect.include?(group)
			@numberColumn = row.coordinate[1]
		end
	end
	@i = 1
	@arrayLessons = []
	@agenda.sheet(0).column(@numberColumn).each do |row|
		@i = @i + 1
		@lesson = Hash.new
		if row != nil && !/.{1,5}-\d{1,5}-\d{1,5}/.match?(row.inspect)
			row.split(/\r\n|\r|\n/).each do |str|
				case str
				when /\W{1,17}.\(\W{1,5}\).{1,2}\W{1}\d{1,5}$/
					str.split('  ').each do |substr|
						case substr
						when /\W{1}\d{1,5}$/
							@lesson[:room] = substr
						else
							@lesson[:title] = substr
						end
					end
				else
					@lesson[:teacher] = str
				end
			end
			@lesson[:count] = @agenda.sheet(0).cell(@i, 'O')
			@lesson[:dayCount] = @i - (@agenda.sheet(0).cell(@i, 'O') - 1)
			@lesson[:dayTitle] = @agenda.sheet(0).cell(@lesson[:dayCount], 'M')
			@arrayLessons.push(@lesson)
		end
	end
	return @arrayLessons
end
