class TopController < ApplicationController
  def index
    @tops = Url.order(count: :desc).limit(100).paginate(:page => params[:page], :per_page => 20)
  end
end
