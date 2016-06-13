require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    #this is a key method, the system will run this first them onto the test
    def setup
    @category = Category.new(name: "sports")
    end
    
    #checks if you can add a category
    test "Category should be valid" do
    assert @category.valid?    
        
    end
    
    #check if an exmpty string in the category name will work
    #it will try to assert the empty string, then check if assert_not is valid (is it working?)
    test "name should be present" do
        @category.name = " "
        assert_not @category.valid?
    end
    
    #check if name is unique, it will save the first (sport) category then try and create a new one. 
    #finally it will check if this assertion was prevented.
    test "name should be unique" do
        @category.save
        category2 = Category.new(name: "sports")
        assert_not category2.valid?
    end
    
    #will insert 26 times "a" in the category name. Checks if too long
    test "name should not be too long" do
        @category.name = "a" * 26
        assert_not @category.valid?
    end
    
    #same principle to above
    test "name should not be too short" do 
        @category.name = "a" * 2
        assert_not @category.valid?
        
    end
    
        
        
end
