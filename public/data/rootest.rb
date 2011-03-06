require 'rubygems'
   require 'roo'
   
  
class Obj
attr_accessor :a, :b, :c, :d
def initialize a,b,c,d
  @a=a
  @b=b
  @c=c
  @d=d
end
end
   
   
   
   
   
   
   HOURLY_RATE = 123.45
   
   oo = Openoffice.new("Desktop/Ntest.ods")
   oo.default_sheet = oo.sheets.first
   arr = []
   4.upto(12) do |line|
    date       = oo.cell(line,'A')
    start_time = oo.cell(line,'B')
    end_time   = oo.cell(line,'C')
    pause      = oo.cell(line,'D')
    o=Obj.new(date,start_time,end_time,pause)
    
   if date
     puts "#{date}\t#{end_time}\t#{ start_time}\t#{ pause}"
   
   
   end
   arr << o
  end
  arr.each do |ob|
    ob
  end  
  
  
  
  #!/usr/bin/env ruby

RAILS_ENV = 'production'

require File.dirname(__FILE__) + '/../config/environment'
require "spreadsheet/excel" 



  file = "Desktop/Ntest.xls" 
  workbook = Spreadsheet::Excel.new("test/#{file}")

 newer
 
 require 'spreadsheet'

workbook = Spreadsheet::Workbook.new()
worksheet = workbook.create_worksheet()
worksheet[0, 0] = "Hello, World!"
workbook.write("test.xls")
