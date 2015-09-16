#!/bin/ruby

require 'open-uri'
require 'csv'

$url = 'https://docs.google.com/spreadsheets/d/1ZaT_hW_yDMdzrRDaOoGDomF4FgJpwuViC4rUERg2Qno/export?format=csv&id=1ZaT_hW_yDMdzrRDaOoGDomF4FgJpwuViC4rUERg2Qno&gid=0'
$destination_folder = ARGV.first

def create_lang_files(folder = './')
	file = File.new("#{folder}/lang.de", 'w+')
	file = File.new("#{folder}/lang.fr", 'w+')
	file = File.new("#{folder}/lang.it", 'w+')
	file = File.new("#{folder}/lang.gsw", 'w+')
	file = File.new("#{folder}/lang.en", 'w+')
end

def get_csv_from_url(url = $url)
	CSV.new(open(url), :headers => :first_row)
end

def split_csv_into_files(csv)
	csv.each do |row|
	 	if portal?(row)
			business_units(row)
		end
	end
end

def portal?(row)
	row['Portal'] == 'yes' && row['Key Web'] ? true : false 
end

def business_units(row)
	srf(row)
	rts(row)
	rsi(row)
	rtr(row)
	swi(row)
end

def srf(row)
	write_tranlation_file('lang.de', 'de (SRF)', row)
end

def rts(row)
	write_tranlation_file('lang.fr', 'fr (RTS)', row)
end

def rsi(row)
	write_tranlation_file('lang.it', 'it (RSI)', row)
end

def rtr(row)
	write_tranlation_file('lang.gsw', 'rm (RTR)', row)
end

def swi(row)
	write_tranlation_file('lang.en', 'en (SWI)', row)
end

def write_tranlation_file(file, bu_key, row)
	File.open(%(#{$destination_folder}/#{file}), 'a+') do |f| 
		key = row["Key Web"].to_s
		translation = format(row[bu_key].to_s)
    translation = key if translation.empty? and !row[bu_key].to_s.include?('EMPTY')
		f.write(%{#{key} = "#{translation}" \n}) 
	end
end

def format(string)
    string.gsub(/\n/, '').gsub(/EMPTY/, '');
end

def run
	create_lang_files($destination_folder)
	split_csv_into_files(get_csv_from_url)
end

run
