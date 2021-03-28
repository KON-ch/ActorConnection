# frozen_string_literal: true

module DisplayList
  PER = 12

  def display_list(page)
    page(page).per(PER)
  end
end
