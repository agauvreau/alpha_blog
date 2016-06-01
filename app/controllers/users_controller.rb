class UsersController < ApplicationController
    #before action avoids repeating yourself
    before_action :set_user, only: [:edit, :update, :show]
    
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    before_action :require_admin, only: [:destroy]
    
    def index
        #to paginate we remove .all and add the paginate method
        @users = User.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            #the session code logs you in automatically
            session[:user_id] = @user.id
            flash[:success] = "Welcome to the Alpha blog #{@user.username}"
            redirect_to user_path(@user)
        else
            render 'new'
        end
        
    end
    
    def edit
     #@user = User.find(params[:id]) this was replaced by the set_user before_action and private method.
     
    end
    
    def update
         #@user = User.find(params[:id]) this was replaced by the set user set_user before_action and private method.
         
        if @user.update(user_params)
            flash[:success] = "Your account was succesfully updated #{@user.username}"
            redirect_to articles_path
        else
            render 'edit'
        end
    
    end
    
    def show
        
        #@user = User.find(params[:id]) this was replaced by the set_user before_action and private method.
        
        #provide an instance variable to allow pagination in the user's article show page
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "User and all article created by user have been deleted"
        redirect_to users_path
    
    end
    
    private
    def user_params #this whitelists the parameters required to create a user. 
       params.require(:user).permit(:username, :email, :password) 
    end
    
    #defining set_user to avoid repeating the same code too often for no reasons
    def set_user
        @user = User.find(params[:id])
    end
    
    def require_same_user
        # checks your id so as to avoid you editing someone else's account
        if current_user != @user and !current_user.admin?
            flash[:danger] = "You can only edit your own account"
            redirect_to root_path
        end
    end
    
    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Only admin user can perform that action"
            redirect_to root_path
        end
    end
    
    
end 