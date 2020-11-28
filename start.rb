require_relative 'near_earth_objects'
require_relative 'display'

puts "________________________________________________________________________________________________________________________________"
puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
puts "Please enter a date in the following format YYYY-MM-DD."
print ">>"

@date = gets.chomp

column_labels = Display.column_labels
column_data = Display.column_data(@date)

header = Display.header(@date)
divider = Display.divider(@date)

 # format_row_data = Display.format_row_data(row_data, column_info)

def format_row_data(row_data, column_info)
  row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
  puts "| #{row} |"
end

def create_rows(astroid_data, column_info)
  rows = astroid_data.each { |astroid| format_row_data(astroid, column_info) }
end

formated_date = DateTime.parse(@date).strftime("%A %b %d, %Y")
puts "______________________________________________________________________________"
puts "On #{formated_date}, there were #{NearEarthObjects.total_number_of_astroids(@date)} objects that almost collided with the earth."
puts "The largest of these was #{NearEarthObjects.largest_astroid_diameter(@date)} ft. in diameter."
puts "\nHere is a list of objects with details:"
puts divider
puts header
create_rows(NearEarthObjects.formatted_astroid_data(@date), Display.column_data(@date))
puts divider
