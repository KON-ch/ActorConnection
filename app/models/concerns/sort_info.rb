module SortInfo
  def sort_info(sort_order, page)
    case sort_order[:sort]
    when 'updated_at_asc'
      order(updated_at: :asc).display_list(page)
    when 'updated_at_desc'
      order(updated_at: :desc).display_list(page)
    when 'start_date_asc'
      order(start_date: :asc).display_list(page)
    when 'start_date_desc'
      order(start_date: :desc).display_list(page)
    when 'end_date_asc'
      order(end_date: :asc).display_list(page)
    when 'end_date_desc'
      order(end_date: :desc).display_list(page)
    when 'production_asc'
      order(production: :asc).display_list(page)
    when 'production_desc'
      order(production: :desc).display_list(page)
    else
      order(updated_at: :desc).display_list(page)
    end
  end
end
