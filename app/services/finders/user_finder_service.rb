class Finders::UserFinderService

  def initialize(params)
    @query = params[:query]
  end

  def search
    if @query.present?
      search = User.ransack(email_or_full_name_or_metadata_eq: @query)
      search.sorts = ['created_at desc']
      search.result
    else
      User.order(created_at: :desc)
    end
  end
end