require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
    
    def setup
        @category = Category.create(name: "sports")
        #creates a user
        @user = User.create(username:"John", email: "john@example.com", password: "password", admin: true)
        
    end
    
    
    
    #using the http get verb this test will see if the index action is available
    test "Should get categories index" do
        get :index
        assert_response :success
    end
   #simulates a user
    test "Should get new" do
    session[:user_id] = @user.id
     get :new
     assert_response :success
    end
    
    #to check the show we need a created category, we use create so as to save it not just a new one
    #then we use the http get verb with the show action and the id, so it has something to show.
    test "Should get show" do
        get(:show, {'id' => @category.id})
        assert_response :success
    end
    #this test checks if the amount of categories is the same after an unlogged user tries to add the sports category. 
    #it should not work and return the user to the category index page.
    test "Should redirect create when admin not logged in" do
       assert_no_difference 'Category.count' do
           post :create, category: {name: "sports"}
       end
       assert_redirected_to categories_path
    end
end
