module SortInfo
  def sort_info(sort_order, page)
    if sort_order[:sort] == "updated_at_asc"
      order(updated_at: :asc).display_list(page)
    elsif sort_order[:sort] == "updated_at_desc"
      order(updated_at: :desc).display_list(page)
    elsif sort_order[:sort] == "start_date_asc"
      order(start_date: :asc).display_list(page)
    elsif sort_order[:sort] == "start_date_desc"
      order(start_date: :desc).display_list(page)
    elsif sort_order[:sort] == "end_date_asc"
      order(end_date: :asc).display_list(page)
    elsif sort_order[:sort] == "end_date_desc"
      order(end_date: :desc).display_list(page)
    elsif sort_order[:sort] == "production_asc"
      order(production: :asc).display_list(page)
    elsif sort_order[:sort] == "production_desc"
      order(production: :desc).display_list(page)
    else
      order(updated_at: :desc).display_list(page)
    end
  end

end