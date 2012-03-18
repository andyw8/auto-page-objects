Given /^the following HTML fragment:$/ do |string|
  @html = string
end

Given /^an empty HTML fragment$/ do
  @html = ''
end

Then /^the page should have the representation:$/ do |string|
  expected = eval(string)
  Capybara.string(@html).data.should == expected
end
