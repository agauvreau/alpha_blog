require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
    
    def setup
        @category = Category.create(name: "sports")
    end
    
    
    
    #using the http get verb this test will see if the index action is available
    test "Should get categories index" do
        get :index
        assert_response :success
    end

    test "Should get new" do
     get :new
     assert_response :success
    end
    
    #to check the show we need a created category, we use create so as to save it not just a new one
    #then we use the http get verb with the show action and the id, so it has something to show.
    test "Should get show" do
        get(:show, {'id' => @category.id})
        assert_response :success
    end
    
end
