require 'rails_helper'

RSpec.describe "submissions/index", type: :view do
  before(:each) do
    assign(:submissions, [
      Submission.create!(
        :creator => "Creator",
        :submission_type => "Submission Type"
      ),
      Submission.create!(
        :creator => "Creator",
        :submission_type => "Submission Type"
      )
    ])
  end

  it "renders a list of submissions" do
    render
    assert_select "tr>td", :text => "Creator".to_s, :count => 2
    assert_select "tr>td", :text => "Submission Type".to_s, :count => 2
  end
end
