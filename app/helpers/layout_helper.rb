module LayoutHelper

  def copyright
    raw("&copy;#{[2015, Date.today.year].uniq.join(" - ")} DrawAList")
  end

  def page_body_class
    "#{params[:controller]}-#{params[:action]}"
  end

end