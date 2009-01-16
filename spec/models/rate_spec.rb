require File.dirname(__FILE__) + '/../spec_helper'

module RateSpecHelper
  def rate_valid_attributes
    { 
      :user => mock_model(User),
      :project => mock_model(Project),
      :date_in_effect => Date.new(Date.today.year, 1, 1),
      :amount => 100.50
    }
  end
end

describe Rate do
  include RateSpecHelper
  
  it 'should be valid with a user' do
    rate = Rate.new(rate_valid_attributes)
    rate.should be_valid
  end

  it 'should be valid with a project' do
    rate = Rate.new(rate_valid_attributes)
    rate.should be_valid
  end
  
  it 'should be valid without a project' do
    rate = Rate.new(rate_valid_attributes.except(:project))
    rate.should be_valid
  end

  it 'should not be valid without a user' do
    rate = Rate.new(rate_valid_attributes.except(:user))
    rate.should_not be_valid
    rate.should have(1).error_on(:user_id)
  end
  
  it 'should not be valid without a date_in_effect' do
    rate = Rate.new(rate_valid_attributes.except(:date_in_effect))
    rate.should_not be_valid
    rate.should have(1).error_on(:date_in_effect)
  end
end

describe Rate, 'associations' do
  it 'should have many time entries' do
    Rate.should have_association(:time_entries, :has_many)
  end

  it 'should belong to a single user' do
    Rate.should have_association(:user, :belongs_to)
  end

  it 'should belong to a single project' do
    Rate.should have_association(:project, :belongs_to)
  end

end

