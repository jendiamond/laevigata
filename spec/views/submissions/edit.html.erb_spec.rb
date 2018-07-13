require 'rails_helper'

RSpec.describe "submissions/edit", type: :view do
  before(:each) do
    @submission = assign(:submission, Submission.create!(
      :creator => "MyString",
      :submission_type => "MyString"
    ))
  end

  it "renders the edit submission form" do
    render

    assert_select "form[action=?][method=?]", submission_path(@submission), "post" do

      assert_select "input[name=?]", "submission[creator]"

      assert_select "input[name=?]", "submission[submission_type]"
    end
  end
end
