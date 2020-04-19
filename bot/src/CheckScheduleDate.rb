require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'fileutils'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

$arrayGroups = []

$currentDate = Time.now.strftime "%m-%d"
def ChangeOldFile
	if File.exist?("./bot/xlsx/changeSchedule.xlsx")
		@FilesOld =	File.open("./bot/xlsx/changeSchedule.xlsx")
		@oldFile = @FilesOld.mtime().strftime "%m-%d"
	else
		@oldFile = nil
	end
	if !(@oldFile == $currentDate)
		@FilesOld.close if File.exist?("./bot/xlsx/changeSchedule.xlsx")
		File.delete("./bot/xlsx/changeSchedule.xlsx") if File.exist?("./bot/xlsx/changeSchedule.xlsx")
		begin
			content = Nokogiri::HTML(open('https://newlms.magtu.ru/mod/folder/view.php?id=573034'))
		rescue OpenURI::HTTPError => error
			errorFunc()
			return nil
		end
		
		@lengthArrayCSS = content.css('.fp-filename').children.length
		if @lengthArrayCSS != 0
			(0...@lengthArrayCSS).each do |i|
				@ContentCss = content.css('.fp-filename').children[i].text
				case /\d{2}\.\d{2}\.\d{2} - \d{2}\.\d{2}\.\d{2}\.xlsx/.match?(@ContentCss)
				when true
					$scheduleFile = "https://newlms.magtu.ru/pluginfile.php/1160930/mod_folder/content/0/#{@ContentCss}"
					encoded_url = URI.encode($scheduleFile)
					encoded_parse = URI.parse(encoded_url)
					begin
						download = open(encoded_parse)
					rescue OpenURI::HTTPError => error
						if error
							errorFunc()
							return nil
						end
					end
					if !File.exist?("./bot/xlsx")
						FileUtils.mkdir_p './bot/xlsx'
					end
					IO.copy_stream(download, "./bot/xlsx/changeSchedule.xlsx")
				end
			end
		else
			return true
		end
	else
		return true
	end
end

def CheckBaseScheduleExist(group)
	@arrayGroups = []
	if File.exist?("./bot/xlsx/BaseScheduleFiles/#{group}.xlsx")
		@oldFile = File.open("./bot/xlsx/BaseScheduleFiles/#{group}.xlsx").mtime().strftime "%m-%d"
	else
		@oldFile = nil
	end
	
	if !(File.exist?("./bot/xlsx/BaseScheduleFiles/#{group}.xlsx") && @oldFile == $currentDate)
		@id = 573029
		@path = 1160925
		
		while !File.exist?("./bot/xlsx/BaseScheduleFiles/#{group}.xlsx")
			begin
				content = Nokogiri::HTML(URI.open("https://newlms.magtu.ru/mod/folder/view.php?id=#{@id}"))
			rescue OpenURI::HTTPError => error
				if error
					errorFunc()
					return nil
				end
			end
			@lengthArrayCSS = content.css('.fp-filename').children.length
			(0...@lengthArrayCSS).each do |i|
				@ContentCss = content.css('.fp-filename').children[i].text
				@arrayGroups.push(@ContentCss)
			end
			@changeTitle = nil
			@arrayGroups.each do |tera|
				if tera.match?(/#{group} изм. с \d{2}.\d{2}.\d{2}.xlsx/) && @changeTitle == nil
					@changeTitle = tera
				end
			end
			
			if @arrayGroups.include?("#{group}.xlsx")
				link = "https://newlms.magtu.ru/pluginfile.php/#{@path}/mod_folder/content/0/#{group}.xlsx"
				encoded_url = URI.encode(link)
				encoded_parse = URI.parse(encoded_url)
				if !File.exist?("./bot/xlsx/BaseScheduleFiles/#{group}.xlsx")
					FileUtils.mkdir_p './bot/xlsx/BaseScheduleFiles'
				end
				if group != nil
					begin
						download = open(encoded_parse)
					rescue OpenURI::HTTPError => error
						if error
							errorFunc()
							return nil
						end
					end
					IO.copy_stream(download, "./bot/xlsx/BaseScheduleFiles/#{group}.xlsx")
				end
			elsif @changeTitle != nil
				link = "https://newlms.magtu.ru/pluginfile.php/#{@path}/mod_folder/content/0/#{@changeTitle}"
				encoded_url = URI.encode(link)
				encoded_parse = URI.parse(encoded_url)
				
				if !File.exist?("./bot/xlsx/BaseScheduleFiles/#{group}.xlsx")
					FileUtils.mkdir_p './bot/xlsx/BaseScheduleFiles'
				end
				
				if group != nil
					begin
						download = open(encoded_parse)
					rescue OpenURI::HTTPError => error
						if error
							errorFunc()
							return nil
						end
					end
					IO.copy_stream(download, "./bot/xlsx/BaseScheduleFiles/#{group}.xlsx")
				end
			else
				@id = @id + 1
				@path = @path + 1
			end
		end
	end
end
