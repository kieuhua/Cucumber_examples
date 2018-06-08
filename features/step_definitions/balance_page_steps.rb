# balance_page_steps.rb
# cd /Users/local-kieu/daily/work/2018/workbridge/balance_page_standalone/page_object
require 'active_support'
require 'cucumber/rspec/doubles'
include ActiveSupport::NumberHelper

class BrowserContainer
   def initialze(browser)
      @browser = browser   
   end
end

class BalancePage
   def values_section
    Values.new
   end  
   def total_section
    TotalValues.new
   end   
end

class Values < BrowserContainer  
   def initialize
      @values =[]
      @browser = Watir::Browser.new :chrome, headless: true     
     # @browser.goto "https://salty-savannah-33557.herokuapp.com/values"
      @browser.goto "https://desolate-cove-74830.herokuapp.com/values"
   end
      
   def get_values
     @values = [ 122365.24, 599.00, 850139.99, 23329.50, 566.27]  
   end

   def values_count?     
      page_str = @browser.html
      
      currency_array =  page_str.scan(/\$\d+\,?\d+\.\d{2}/)  
      count_on_screen = currency_array.length - 1  # subtract the last balance value 
      count_on_screen == get_values.length
   end
   
   def valid_values?(value_check)   
      page_str = @browser.html

      currency_array =  page_str.scan(/\$\d+\,?\d+\.\d{2}/)  
      # convert currency array to float
      values_float =[]
      currency_array.each do |cur_val|
         # keep the digits and dot, others to nil
         values_float << cur_val.to_s.gsub(/[^\d\.]/, '').to_f
      end
      values_float.each do  |val| 
         return false unless val > value_check 
      end
      true
   end
   
   def currency_values?    
      page_str = @browser.html
      values = get_values
      values.each do |val| 
         currency_val = number_to_currency(val)
         return false unless page_str.include?(currency_val) 
     end
     true
   end  
end

class TotalValues < BrowserContainer   
   def intialize
      @total_values = 0
   end
   def total_values_onscreen?   
      browser = Watir::Browser.new :chrome, headless: true
      #browser.goto "https://salty-savannah-33557.herokuapp.com/values"
      browser.goto "https://desolate-cove-74830.herokuapp.com/values"
      page_str = browser.html
     
      currency_array =  page_str.scan(/\$\d+\,?\d+\.\d{2}/)  
     # convert currency array to float
     values_float =[]
     currency_array.each do |cur_val|
        # keep the digits and dot, others to nil
        values_float << cur_val.to_s.gsub(/[^\d\.]/, '').to_f
     end
     balance_on_screen = values_float.pop
     sum_values = values_float.reduce(:+)
     sum_values == balance_on_screen
   end
   
   def total_check?(values)
      browser = Watir::Browser.new :chrome, headless: true
      #browser.goto "https://salty-savannah-33557.herokuapp.com/values"
      browser.goto "https://desolate-cove-74830.herokuapp.com/values"
      page_str = browser.html
      
      currency_array =  page_str.scan(/\$\d+\,?\d+\.\d{2}/)
      balance_on_screen = currency_array.pop.to_s.gsub(/[^\d\.]/, '').to_f
      sum_values = values.reduce(:+)
      balance_on_screen == sum_values
   end
end

Given("I have many values") do 
   balance_page = BalancePage.new
   @values_sec = balance_page.values_section
   @total_sec = balance_page.total_section
   @values = @values_sec.get_values
end

When("I goto {string}") do |string|
   # visit root_path, visit "/#{place}"
   browser = Watir::Browser.new :chrome, headless: true
  # @browser = browser.goto "https://salty-savannah-33557.herokuapp.com/values"
   @browser = "https://desolate-cove-74830.herokuapp.com/values"   
end

Then("I should see the right number of values appear on the screen") do 
   valid_count = @values_sec.values_count?
   expect(valid_count).to be_truthy
end

Then("I should see the values on the screen are greater than {int}") do |int|
   valid_values = @values_sec.valid_values?(int)
   expect(valid_values).to be_truthy
end

Then("I should see the total balance is correct based on the values listed on the screen") do
   valid_total_onscreen = @total_sec.total_values_onscreen?
   expect(valid_total_onscreen).to be_truthy
end

Then("I should see total balance matches the sum of the values") do
   valid_total = @total_sec.total_check?(@values_sec.get_values)
   expect(valid_total).to be_truthy
end

Then("I should see the values are formatted as currencies") do
   valid_currency = @values_sec.currency_values?
   expect(valid_currency).to be_truthy
end