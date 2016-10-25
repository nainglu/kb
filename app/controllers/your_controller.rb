class YourController < ApplicationController

  def showpic
    @path = image_url(params[:image]);
  end

  def show
  end


end