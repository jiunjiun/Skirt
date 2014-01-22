class IndexController < ApplicationController
  def index
    @url = Url.new
  end

  def goto
    redirect_to Url.verifyCode(params[:code])
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      @render_url = root_url + @url.code
    else
      @render_url = root_url + Url.where(:url=> @url.url).first.code
    end
    respond_to do |format|
      # format.xml { render :xml => {:surl => @render_url }}
      format.json { render :json => {:surl => @render_url }}
    end
  end

  private
  def url_params
    params.require(:url).permit(:url)
  end
end
