Feature: Creating Tickets
In order to create tickets for projects
As a user
I want to be able to select a project and do that
Background:
	Given there is a project called "Internet Explorer"
	And there are the following users:
		| email				| password	|
		| user@ticketee.com | password	|
	And "user@ticketee.com" can view the "Internet Explorer" project	
	And "user@ticketee.com" can create tickets in the "Internet Explorer" project
	And I am signed in as them
	When I follow "Internet Explorer"
	Then I should see "New Ticket"
	When I follow "New Ticket"
Scenario:Creating a ticket
	When I fill in "Title" with "Non-standards compliance"
	And I fill in "Description" with "My pages are ugly!"
	And I press "Create Ticket"
	Then I should see "Ticket has been created."
Scenario:Creating a ticket without valid attributes fails
	When I press "Create Ticket"
	Then I should see "Ticket has not been created."
	And I should see "Title can't be blank"
	And I should see "Description can't be blank"
Scenario:Description must be longer than 10 characters
	When I fill in "Title" with "Non-standards compliance"
	And I fill in "Description" with "it sucks"
	And I press "Create Ticket"
	Then I should see "Ticket has not been created."
	And I should see "Description is too short"
	Then I should see "user@ticketee.com"
@javascript
Scenario:Creating a ticket with an attachment
	When I fill in "Title" with "Add documentation for blink tag"
    And I fill in "Description" with "The blink tag has an undocumented speed attribute"
    And I attach the file "spec/fixtures/speed.txt" to "File #1"
    And I follow "Add another file"
    And I attach the file "spec/fixtures/spin.txt" to "File #2"
    And I press "Create Ticket"
    Then I should see "Ticket has been created."
