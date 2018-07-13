require 'rails_helper'

RSpec.describe "submissions/new", type: :view do
  before(:each) do
    assign(:submission, Submission.new(
      :creator => "MyString",
      :submission_type => "MyString"
    ))
  end

  it "renders new submission form" do
    render

    assert_select "form[action=?][method=?]", submissions_path, "post" do

      assert_select "input[name=?]", "submission[creator]"

      assert_select "input[name=?]", "submission[submission_type]"
    end
  end
end
