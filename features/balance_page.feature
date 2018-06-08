Feature: balance_page
	In order to see a balance page with each line contains its value and the last line is their sum
	As a business client
	I want to see each value in currency format and the last line is their correct total.
		
	Scenario: balance_page
		Given I have many values
		When I goto "https://desolate-cove-74830.herokuapp.com/values"	
		Then I should see the right number of values appear on the screen
		And I should see the values on the screen are greater than 0
		And I should see the total balance is correct based on the values listed on the screen
		And I should see the values are formatted as currencies
		And I should see total balance matches the sum of the values
		
