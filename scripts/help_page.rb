#!/bin/ruby

require 'open-uri'
require 'pp'
require 'csv'

$url = 'https://docs.google.com/spreadsheets/d/1ZaT_hW_yDMdzrRDaOoGDomF4FgJpwuViC4rUERg2Qno/export?format=csv&id=1ZaT_hW_yDMdzrRDaOoGDomF4FgJpwuViC4rUERg2Qno&gid=0'

def create_files(folder = './')
	file = File.new("#{folder}lang.de", 'w+')
	file = File.new("#{folder}lang.fr", 'w+')
	file = File.new("#{folder}lang.it", 'w+')
	file = File.new("#{folder}lang.gsw", 'w+')
	file = File.new("#{folder}lang.en", 'w+')
end

def csv_from_url(url = $url)
	csv = CSV.new(open(url), :headers => :first_row)
end

def iterate
	csv_from_url.each do |row|
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
	write_tranlation_file('./lang.de', 'de (SRF)', row)
end

def rts(row)
	write_tranlation_file('./lang.fr', 'fr (RTS)', row)
end

def rsi(row)
	write_tranlation_file('./lang.it', 'it (RSI)', row)
end

def rtr(row)
	write_tranlation_file('./lang.gsw', 'rm (RTR)', row)
end

def swi(row)
	write_tranlation_file('./lang.en', 'en (SWI)', row)
end


def write_tranlation_file(file, bu_key, row)
	File.open(file, 'a+') do |f| 
		key = row["Key Web"].to_s
		translation = escape_quotes(row[bu_key].to_s)
		f.write(%{#{key} = "#{translation}" \n}) 
	end
end

def escape_quotes(string)
	string.gsub('"', '\"').gsub(/\n/, '')
end

create_files
iterate
