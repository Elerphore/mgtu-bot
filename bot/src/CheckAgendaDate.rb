require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'fileutils'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
$arrayGroupses = [];

$currentDate = Time.now.strftime "%m-%d";
def ChangeOldFile 
	if File.exist?("./bot/xlsx/changeAgenda.xlsx") 
		@FilesOld = File.open("./bot/xlsx/changeAgenda.xlsx")
		@oldFile = @FilesOld.mtime().strftime "%m-%d";
		else 
		@FilesOld = nil
	end

	if !(@oldFile == $currentDate);
		@FilesOld.close if File.exist?("./bot/xlsx/changeAgenda.xlsx");
		File.delete("./bot/xlsx/changeAgenda.xlsx") if File.exist?("./bot/xlsx/changeAgenda.xlsx");
		content = Nokogiri::HTML(open('https://newlms.magtu.ru/mod/folder/view.php?id=573034'));
		@lenghtArrayCSS = content.css('.fp-filename').children.length;
		(0...@lenghtArrayCSS).each do |i| 

		@ContentCss = content.css('.fp-filename').children[i].text

		case /\d{2}\.\d{2}\.\d{2} - \d{2}\.\d{2}\.\d{2}\.xlsx/.match?(@ContentCss)
			when true
			$agendaFile = "https://newlms.magtu.ru/pluginfile.php/1160930/mod_folder/content/0/#{@ContentCss}"
			encoded_url = URI.encode($agendaFile)
			encoded_pars = URI.parse(encoded_url)
			download = open(encoded_pars);
			IO.copy_stream(download, "./bot/xlsx/changeAgenda.xlsx");
		end

		end
	else
		p 'it work!'
	end
end

def CheckBaseAgendaExist(group)
	# p group;
	@arrayGroupses = [];
	if File.exist?("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx")
		@File = File.open("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx");
		@oldFile = @File.mtime().strftime "%m-%d";
	else
		@oldFile = nil;
	end

	if !(File.exist?("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx") && @oldFile == $currentDate)
		@id = 573029;
		@path = 1160925;

		while !File.exist?("./bot/xlsx/BaseAgendaFiles/#{group}.xlsx")
		content = Nokogiri::HTML(URI.open("https://newlms.magtu.ru/mod/folder/view.php?id=#{@id}"));
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
				download = open(encoded_pars);
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
				download = open(encoded_pars);
				IO.copy_stream(download, "./bot/xlsx/BaseAgendaFiles/#{group}.xlsx")
			end
		else
			@id = @id + 1;
			@path = @path + 1;
		end
		end
	else
		p 'Da'		
	end
end