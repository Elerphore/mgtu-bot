require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'fileutils'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

$arrayGroupses = [];

$currentDate = Time.now.strftime "%m-%d";
def ChangeOldFile 
	if File.exist?("./bot/xlsx/changeAgenda.xlsx") 
		@FilesOld =	File.open("./bot/xlsx/changeAgenda.xlsx")
		@oldFile = @FilesOld.mtime().strftime "%m-%d"
		else 
		@oldFile = nil
	end
	if !(@oldFile == $currentDate)
		@FilesOld.close if File.exist?("./bot/xlsx/changeAgenda.xlsx");
		File.delete("./bot/xlsx/changeAgenda.xlsx") if File.exist?("./bot/xlsx/changeAgenda.xlsx");
		begin
			content = Nokogiri::HTML(open('https://newlms.magtu.ru/mod/folder/view.php?id=573034'));
		rescue OpenURI::HTTPError => error
				errorFunc();
				p 'test2'
				return nil;
		end

		@lenghtArrayCSS = content.css('.fp-filename').children.length;
		if @lenghtArrayCSS != 0
			(0...@lenghtArrayCSS).each do |i| 
			@ContentCss = content.css('.fp-filename').children[i].text
				case /\d{2}\.\d{2}\.\d{2} - \d{2}\.\d{2}\.\d{2}\.xlsx/.match?(@ContentCss)
					when true
					$agendaFile = "https://newlms.magtu.ru/pluginfile.php/1160930/mod_folder/content/0/#{@ContentCss}"
					encoded_url = URI.encode($agendaFile)
					encoded_pars = URI.parse(encoded_url)
					begin
						download = open(encoded_pars);
						rescue OpenURI::HTTPError => error
							if error
								errorFunc();
								return nil;
							end
					end
					if !File.exist?("./bot/xlsx")
						FileUtils.mkdir_p './bot/xlsx'
					end
					IO.copy_stream(download, "./bot/xlsx/changeAgenda.xlsx");
				end
			end
		else
			return true;
		end
	else
		return true;
	end
end

def CheckBaseAgendaExist(group)
	@arrayGroupses = [];
	if File.exist?("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx")
		@oldFile = File.open("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx").mtime().strftime "%m-%d";
	else
		@oldFile = nil;
	end

	if !(File.exist?("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx") && @oldFile == $currentDate)
		@id = 573029;
		@path = 1160925;

			while !File.exist?("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx")
				begin
					content = Nokogiri::HTML(URI.open("https://newlms.magtu.ru/mod/folder/view.php?id=#{@id}"));
				rescue OpenURI::HTTPError => error
					if error
						errorFunc();
						return nil;
					end
				end
				@lenghtArrayCSS = content.css('.fp-filename').children.length;
				(0...@lenghtArrayCSS).each do |i| 
					@ContentCss = content.css('.fp-filename').children[i].text;
					@arrayGroupses.push(@ContentCss);
				end
				@changeTitle = nil;
				@arrayGroupses.each do |tera|
					if tera.match?(/#{group} изм. с \d{2}.\d{2}.\d{2}.xlsx/) && @changeTitle == nil
						 @changeTitle = tera;
					end
				end


				if @arrayGroupses.include?("#{group}.xlsx") 
					link = "https://newlms.magtu.ru/pluginfile.php/#{@path}/mod_folder/content/0/#{group}.xlsx"
					encoded_url = URI.encode(link)
					encoded_pars = URI.parse(encoded_url)
					if !File.exist?("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx")
						FileUtils.mkdir_p './bot/xlsx/BaseAgendaFiles'
					end
					if group != nil
					begin
						download = open(encoded_pars);
						rescue OpenURI::HTTPError => error
							if error
								errorFunc();
								return nil;
							end
					end
						IO.copy_stream(download, "./bot/xlsx/BaseAgendaFiles/#{group}.xlsx")
					end
				elsif @changeTitle != nil
					link = "https://newlms.magtu.ru/pluginfile.php/#{@path}/mod_folder/content/0/#{@changeTitle}"
					encoded_url = URI.encode(link)
					encoded_pars = URI.parse(encoded_url)
						
					if !File.exist?("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx")
						FileUtils.mkdir_p './bot/xlsx/BaseAgendaFiles'
					end

					if group != nil
					begin
						download = open(encoded_pars);
						rescue OpenURI::HTTPError => error
							if error
								errorFunc();
								return;
							end
					end
						IO.copy_stream(download, "./bot/xlsx/BaseAgendaFiles/#{group}.xlsx")
					end
				else
					@id = @id + 1;
					@path = @path + 1;
				end
			end
	end






end