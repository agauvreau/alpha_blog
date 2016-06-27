require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
   def setup
    #creates a user
        @user = User.create(username:"John", email: "john@example.com", password: "password", admin: true)
        
   
   end
   #
   
   test "get new category form and create category" do 
    #we use sign_in_as which is  in test_helper.rb. This method is available to all tests.
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    #there should be a difference of one once we created a new category (we've added one) 
    assert_difference 'Category.count', 1 do
        #Http post request to the categories path with the new sports category, here sports
        post_via_redirect categories_path, category: {name: "sports"}
    end
    #is the user going back to the listing page
    assert_template 'categories/index'
    #checks if the category name is mentioned in the body of the page.
    assert_match "sports", response.body
   end
   
   test "invalid cate submission results in failure" do
       sign_in_as(@user, "password")
   get new_category_path
    assert_template 'categories/new'
    #there should be no difference of one once we created a new category (invalid so no creation) 
    assert_no_difference 'Category.count'  do
        #Http post request to the categories path with the new sports category, here sports
        post categories_path, category: {name: " "}
    end
    #is the user going back to the new page
    assert_template 'categories/new'
    #checks if error message (no empty title for category) is shown on the page
    # the h2.panel-title is from the _error partial. if these two section are there so is the error message.
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
   end
   
end

