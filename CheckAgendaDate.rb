require 'nokogiri'
require 'open-uri'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def ChangeOldFile 

if File.exist?("./changeAgenda.xlsx") 
	@FilesOld = File.open("./changeAgenda.xlsx")
	@oldFile = @FilesOld.ctime().strftime "%m-%d";
	else 
	p 'it not exist'

	@FilesOld = nil
end

date = Time.now.strftime "%m-%d";

if !(@oldFile == date);
	@FilesOld.close if File.exist?("./changeAgenda.xlsx");
	File.delete('./changeAgenda.xlsx') if File.exist?("./changeAgenda.xlsx");

	content = Nokogiri::HTML(open('https://newlms.magtu.ru/mod/folder/view.php?id=573034'));
	$lenghtArrayCSS = content.css('.fp-filename').children.length;
	(0...$lenghtArrayCSS).each do |i| 

	$ContentCss = content.css('.fp-filename').children[i].text

	case /\d{2}\.\d{2}\.\d{2} - \d{2}\.\d{2}\.\d{2}\.xlsx/.match?($ContentCss)
		when true
		$agendaFile = "https://newlms.magtu.ru/pluginfile.php/1160930/mod_folder/content/0/#{$ContentCss}"
		encoded_url = URI.encode($agendaFile)
		encoded_pars = URI.parse(encoded_url)
		download = open(encoded_pars);
		IO.copy_stream(download, './changeAgenda.xlsx')
	end

	end
else
	p 'it work!'
end

# case @oldFile == date
# when false
# @FilesOld.close if File.exist?("./changeAgenda.xlsx");
# File.delete('./changeAgenda.xlsx') if File.exist?("./changeAgenda.xlsx");

# content = Nokogiri::HTML(open('https://newlms.magtu.ru/mod/folder/view.php?id=573034'));
# $lenghtArrayCSS = content.css('.fp-filename').children.length;
# 	(0...$lenghtArrayCSS).each do |i| 

# 	$ContentCss = content.css('.fp-filename').children[i].text

# 		case /\d{2}\.\d{2}\.\d{2} - \d{2}\.\d{2}\.\d{2}\.xlsx/.match?($ContentCss)
# 		when true
# 		$agendaFile = "https://newlms.magtu.ru/pluginfile.php/1160930/mod_folder/content/0/#{$ContentCss}"
# 		encoded_url = URI.encode($agendaFile)
# 		encoded_pars = URI.parse(encoded_url)
# 		download = open(encoded_pars);
# 		IO.copy_stream(download, './changeAgenda.xlsx')
# 		end
# 	end

# 	when true
# 		p 'normalek'
# end
end