class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user!, except: [ :health ]

  def health
    render json: {
      status: "ok",
      message: "KataUser API is running",
      timestamp: Time.current,
      version: "1.0.0"
    }
  end

  private

  def paginate(collection)
    collection.page(params[:page]).per(params[:per_page] || 25)
  end

  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count,
      per_page: collection.limit_value
    }
  end
end
