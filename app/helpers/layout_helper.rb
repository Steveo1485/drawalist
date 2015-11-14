module LayoutHelper

  def copyright
    raw("&copy;#{[2015, Date.today.year].uniq.join(" - ")} DrawAList")
  end

end