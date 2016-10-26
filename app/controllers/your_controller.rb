class YourController < ApplicationController

  def showpic
    @path = File.join(Rails.root, params[:image]) # or similar
  end

  def show
  end


end