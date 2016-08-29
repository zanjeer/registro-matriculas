module ApplicationHelper
  def human_boolean(boolean)
    if boolean == true
      "Si"
    else
      "No"
    end
  end
end
