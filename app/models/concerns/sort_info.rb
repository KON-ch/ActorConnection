module SortInfo
  def sort_info(sort_order, page)
    order(sort_order[:sort]).display_list(page)
  end
end