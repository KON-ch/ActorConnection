module DisplayList

  PER = 15

  def  display_list(page)
    page(page).per(PER)
  end
end