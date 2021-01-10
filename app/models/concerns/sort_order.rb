module SortOrder
  def sort_order(sort_order, page)
    order(sort_order[:sort]).display_list(page)
  end
end