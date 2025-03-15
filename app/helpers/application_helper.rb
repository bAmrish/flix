module ApplicationHelper
  def nav_link_to(text, link)
    if current_page?(link)
      link_to text, link, class: "active"
    else
      link_to text, link
    end
  end
end
