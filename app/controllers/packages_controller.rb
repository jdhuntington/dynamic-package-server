class PackagesController < ApplicationController
  def search
    b = Backend.new
    result = b.search(params[:q])
    render :json => result
  end

  def detail
    b = Backend.new
    result = b.detail(params[:q])
    render :json => result
  end
end
