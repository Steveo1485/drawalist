module LayoutHelper

  def copyright
    raw("&copy;#{[2015, Date.today.year].uniq.join(" - ")} DrawAList")
  end

  def page_body_class
    "#{params[:controller]}-#{params[:action]}"
  end

  def title(page_title)
    content_for(:title) { raw(page_title.to_s) }
  end

  def compound_page_title(page_title)
    title = ''
    unless page_title.blank?
      title += "#{page_title} - "
    end
    title += 'DrawAList'
  end

end