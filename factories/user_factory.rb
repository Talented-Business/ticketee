FactoryGirl.define do
	factory :user do |user|
		user.sequence(:email) { |n| "user#{n}@ticketee.com" }
		user.password "password"
		user.password_confirmation "password"
	end
end