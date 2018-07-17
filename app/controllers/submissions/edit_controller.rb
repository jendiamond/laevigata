class Submissions::EditController < ApplicationController
  include Wicked::Wizard

  # steps Submission::SAVED_ATTRIBUTES.map{ |step, fields| step }.freeze
  steps :about_me, :my_program, :my_advisor, :abstract, :keywords, :my_files, :embargo, :review

  def show
    etd = Etd.find(params[:submission_id])

    @submission = Submission.create
    @submission.title = etd.title.first
    @submission.graduation_date = etd.graduation_date.first
    @submission.keyword = etd.keyword.first.first
    @submission.post_graduation_email = etd.post_graduation_email.first
    @submission.embargo_type = "files only"
    @submission.department = etd.department.first
    @submission.school = etd.school.first
    @submission.subfield = etd.subfield.first
    @submission.degree = etd.degree.first
    @submission.abstract = etd.abstract.first
    @submission.creator = etd.creator.first
    @submission.language = etd.language.first
    @submission.copyrights = etd.other_copyrights
    @submission.requires_permissions = etd.requires_permissions
    @submission.patents = etd.patents
    @submission.partnering_agency = etd.partnering_agency.first
    @submission.research_field = etd.research_field.first
    @submission.submitting_type = etd.submitting_type.first
    @submission.table_of_contents = etd.table_of_contents.first

    @submission.committee_chair = etd.committee_chair.first.name
    @submission.committee_members = etd.committee_members.first.name

    @submission.save

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

