## cucumber, watir, headless chrome

These are cucumber example tests for the balance page Ruby on Rails app.

The link of the balance page app and its output: 
[balance page app](https://desolate-cove-74830.herokuapp.com/values)

##### Values
- Value 1	$566.27	
- Value 2	$23,329.50	
- Value 3	$850,139.99	
- Value 4	$599.00	
- Value 5	$122,365.24	
###### Total Balance $997,000.00

**The objectives for RSpec example tests are:**

- Need to verify the right number of values appear on the screen
- Need to verify the values on the screen are greater than 0
- Need to verify the total balance is correct based on the values listed on the screen
- Need to verify the values are formatted as currencies
- Need to verify the total balance matches the sum of the values
- Create a mockup of what the results would like so a business client would know what was tested

**The cucumber tests are located in:**
```
features/balance_page.feature
features/step_definitions
```
You can download this repository, build and run the tests  

All tests are passed, and this is the output of

```
$ cucumber features/
Feature: balance_page
	In order to see a balance page with each line contains its value and the last line is their sum
	As a business client
	I want to see each value in currency format and the last line is their correct total.

  Scenario: balance_page                                                                   # features/balance_page.feature:6
    Given I have many values                                                               # features/step_definitions/balance_page_steps.rb:104
    When I goto "https://desolate-cove-74830.herokuapp.com/values"                      # features/step_definitions/balance_page_steps.rb:111
    Then I should see the right number of values appear on the screen                      # features/step_definitions/balance_page_steps.rb:118
    And I should see the values on the screen are greater than 0                           # features/step_definitions/balance_page_steps.rb:123
    And I should see the total balance is correct based on the values listed on the screen # features/step_definitions/balance_page_steps.rb:128
    And I should see the values are formatted as currencies                                # features/step_definitions/balance_page_steps.rb:138
    And I should see total balance matches the sum of the values                           # features/step_definitions/balance_page_steps.rb:133

1 scenario (1 passed)
7 steps (7 passed)
0m17.846s
```