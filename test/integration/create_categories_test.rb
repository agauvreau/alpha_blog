require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
   
   #
   
   test "get new category form and create category" do 
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
   
end

