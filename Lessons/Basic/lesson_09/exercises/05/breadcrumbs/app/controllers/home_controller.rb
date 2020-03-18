class HomeController < ApplicationController
  before_action :set_breadcrumbs

  def ping
  end

  def pong
  end

  def index
  end

  private

  def set_breadcrumbs
    if session[:breadcrumbs]
      @breadcrumbs = session[:breadcrumbs]
    else
      @breadcrumbs = Array.new
    end

    @breadcrumbs.push(request.url)
    if @breadcrumbs.count > 4
      # shift removes the first element
      @breadcrumbs.shift
    end

    session[:breadcrumbs] = @breadcrumbs
  end
end
