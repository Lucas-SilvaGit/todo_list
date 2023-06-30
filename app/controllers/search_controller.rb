class SearchController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @query = Task.ransack(params[:q])
    @tasks = @query.result(distinct: true)
  end
end
