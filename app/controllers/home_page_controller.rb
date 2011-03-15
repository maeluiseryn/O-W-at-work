class HomePageController < ApplicationController

  def home
    if signed_in?
      @title=" Page d'acceuil "
      render 'home'
    else
      @title=' Visiteur'
      render 'visitor'
    end
  end

end
