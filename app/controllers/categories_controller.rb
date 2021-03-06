class CategoriesController < ApplicationController
    #this before_action prevents non admin users from creating and deleting categories
    before_action :require_admin, except: [:index, :show]
    
    
    def index
        # the paginate after Category is for the paginate gem, otherwise it would be ".all".
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @category = Category.new
    end
    
    def create

        @category = Category.new(category_params)

        if @category.save
    
        flash[:success] = "Category was created successfully"
        redirect_to categories_path
        else
        render 'new'
        end
    
    end
    
    def edit
        @category = Category.find(params[:id])        
    end
    
    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:success] = "Category was successfully updated"
            redirect_to category_path(@category)
        else
           render 'edit' 
        end
    end
    
    
    def show
        #this show action allows us to display each articles retlated to a specific category.
        #this code also includes the will paginate per page info
        
        @category = Category.find(params[:id])
        @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
    end
    
    
    private
    def category_params
        params.require(:category).permit(:name)
    end
    #is the user logged in? and a admin user.
    def require_admin
        if !logged_in? || (logged_in? and !current_user.admin?)
            flash[:danger] = "Only admins can perfomed that action"
            redirect_to categories_path
        end
    end
    

end
