require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
   
   #this will add a few categories so we can test the listing
   def setup
   @category = Category.create(name: "books")
   @category2 = Category.create(name: "programming")
   end
   
   test "should show categories listing" do
       get categories_path
       assert_template 'categories/index'
       #check that the link that should be present does send you to the specific category, either @category or @category2
       assert_select "a[href=?]", category_path(@category)
        assert_select "a[href=?]", category_path(@category2)
   end
   
   
   
end
