# Controller for static pages
class PagesController < ApplicationController
  def home
   #if the user is logged in they will be redirected to the articles page.
   redirect_to articles_path if logged_in?
   
  end

  def about
      
  end
  
end