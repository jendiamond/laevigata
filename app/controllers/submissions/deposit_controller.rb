class Submissions::DepositController < ApplicationController
  include Wicked::Wizard

  # steps Submission::SAVED_ATTRIBUTES.map{ |step, fields| step }.freeze
  steps :about_me, :my_program, :my_advisor, :abstract, :keywords, :my_files, :embargo, :review

  def show
    @submission = Submission.find(params[:submission_id])
    render_wizard
  end


  def update
    @submission = Submission.find(params[:submission_id])
    @submission.update_attributes(submission_params)
    render_wizard @submission
  end


  def create
    @submission = Submission.create
    redirect_to wizard_path(steps.first, submission_id: @submission.id)
  end

private

  def submission_params
    if params[:submission]
      params.require(:submission).permit( Submission::SAVED_ATTRIBUTES, :primary_pdf_file_cache, :supplemental_file_cache )
    end
  end

end

