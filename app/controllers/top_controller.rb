class TopController < ApplicationController
  def index
    @tops = Url.order(count: :desc).paginate(:page => params[:page], :per_page => 20)
  end
end
