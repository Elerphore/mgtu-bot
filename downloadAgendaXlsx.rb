require 'open-uri';
require 'openssl'
require 'rufus-scheduler'

ENV['TZ'] = 'Europe/Moscow'

scheduler = Rufus::Scheduler.new
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

$link = 'https://newlms.magtu.ru/pluginfile.php/1160930/mod_folder/content/0/23.03.20 - 25.03.20.xlsx';
encoded_url = URI.encode($link)
encoded_pars = URI.parse(encoded_url)
download = open(encoded_pars);
IO.copy_stream(download, './changeAgenda.xlsx')

TimeHours = Time.now.hour;
TimeMin = Time.now.min;
