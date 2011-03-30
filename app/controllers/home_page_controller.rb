class HomePageController < ApplicationController

  def home
    if signed_in?
      @model=UploadedFile.first
      @title=" Page d'acceuil "
      render 'home'
    else
      @title=' Visiteur'
      render 'visitor'
    end
  end
  def test
   #File.open('fuckyu.txt', "wb") { |f| f.write(render :test=>'hello'.humanize) }
  end
end
