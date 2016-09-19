class QueriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def new
  end

  def create
    query_string = params[:query]
    # pry
    result = Api::Query::Schema.execute(query_string)
    render json: result
  end
end