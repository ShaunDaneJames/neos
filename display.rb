class Display 

  def self.column_labels
    { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
  end

  def self.column_data(date)
    column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [NearEarthObjects.formatted_astroid_data(date).map { |astroid| astroid[col].size }.max, label.size].max}
    end
  end

  def self.header(date)
    "| #{ column_data(date).map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

  def self.divider(date)
    "+-#{column_data(date).map { |_,col| "-"*col[:width] }.join('-+-') }-+"
  end

  def self.format_row_data(row_data, column_info)
    row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end

  def self.create_rows(astroid_data, column_info)
    rows = astroid_data.each { |astroid| format_row_data(astroid, column_info) }
  end
end
