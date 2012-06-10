module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "AppDorm"
    if @page_title.nil? || @page_title.empty?
      base_title
    else
      "#{base_title} | #{@page_title}"
    end
  end

end
