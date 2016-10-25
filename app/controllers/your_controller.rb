class YourController < ApplicationController

  def showpic
    @path = File.join(Rails.root, params[:path]) # or similar
  end

  def show
  end


end