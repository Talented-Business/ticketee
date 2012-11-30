Feature:Signing up
In order to be attributed for my work
As a user
I want to be able to sign up
Scenario:Signing up
	Given I am on the homepage
	When I follow "Sign up"
	And I fill in "user_email" with "user@ticketee.com"
	And I fill in "user_password_confirmation" with "password"
	And I fill in "user_password" with "password"
	And I press "Sign up"
	Then I should see "You have signed up successfully."