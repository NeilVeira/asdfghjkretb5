module ApplicationHelper

  def sort(column)
    title = column.titleize
	column = column.downcase
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end

end
