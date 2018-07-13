require 'rails_helper'

RSpec.describe "submissions/show", type: :view do
  before(:each) do
    @submission = assign(:submission, Submission.create!(
      :creator => "Creator",
      :submission_type => "Submission Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Creator/)
    expect(rendered).to match(/Submission Type/)
  end
end
