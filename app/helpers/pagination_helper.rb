module PaginationHelper

  def resultset_info(result)
    t 'pagination_helper.resultset_info_html',
      count: result.count,
      total: result.total_count,
      current_page: result.current_page,
      total_pages: result.total_pages
  end

end
