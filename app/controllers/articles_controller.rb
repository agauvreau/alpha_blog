class ArticlesController < ApplicationController
    #this refers to the private method at the bottom of the file, prevents redundancy of code.
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    # will make sure that only a logged user can do the actions. This prevents people from manually typing the address to edit the articles
    before_action :require_user, except: [:index, :show]
    # requires the user who created the article to allow its edition and deletion, this is linked with a private method below.
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        #because of the will_paginate gem we don't use .all after Article. Refer to will_paginate gem docs.
        #default amount of items per page : approxim 20 per_page: lets you choose.
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end
    
    
    def new
        @article = Article.new
    end
    
    def edit
        
    end
    
    
    def create
        @article = Article.new(article_params)
        @article.user = current_user
        #this code catched any isssues with the saving action, ie: incorrect validation.
        if @article.save
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article)
        else
        render 'new'
        end
    
    end
    
    def update
        
        if @article.update(article_params)
        
            flash[:success] = "Article was successfully updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
        
    end
    
    
    def show
        
    end
    
    def destroy
       
        @article.destroy
        flash[:danger] = "Article was successfully deleted"
        redirect_to articles_path
    
    end
    
    
    private
    
    def set_article
        @article = Article.find(params[:id])
    end
    
    
    def article_params
    params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
        # != means not equal.
        if current_user != @article.user
            flash[:danger] = "You can only edit and delete your own articles"
            redirect_to root_path
        end
    end
    
end

