require 'roo'

def subsClassFunc(group)
	@numberColumn = nil
	@agenda = Roo::Spreadsheet.open('./bot/xlsx/changeAgenda.xlsx') if File.exist?('./bot/xlsx/changeAgenda.xlsx')
	@agenda.each_row_streaming.to_a.flatten.find do |row|
		if row.inspect.include?(group)
			@numberColumn = row.coordinate[1]
		end
	end
	@i = 1
	@arrayClasses = []
	@agenda.sheet(0).column(@numberColumn).each do |row|
		@i = @i + 1
		@class = Hash.new
		if row != nil && !/.{1,5}-\d{1,5}-\d{1,5}/.match?(row.inspect)
			row.split(/\r\n|\r|\n/).each do |str|
				case str
				when /\W{1,17}.\(\W{1,5}\).{1,2}\W{1}\d{1,5}$/
					str.split('  ').each do |substr|
						case substr
						when /\W{1}\d{1,5}$/
							@class[:room] = substr
						else
							@class[:title] = substr
						end
					end
				else
					@class[:teacher] = str
				end
			end
			@class[:count] = @agenda.sheet(0).cell(@i, 'O')
			@class[:dayCount] = @i - (@agenda.sheet(0).cell(@i, 'O') - 1)
			@class[:dayTitle] = @agenda.sheet(0).cell(@class[:dayCount], 'M')
			@arrayClasses.push(@class)
		end
	end
	return @arrayClasses
end
