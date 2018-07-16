class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy, :complete]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /submissions/1/complete
  def complete

    etd = Etd.new
    etd.depositor = current_user.user_key
    etd.email = [current_user.email] #??? do we currently store e-mail & is this the right thing to do?

    # loop through copying attributes
    etd.title = [@submission.title]
    etd.graduation_date = [@submission.graduation_date]
    etd.keyword = [@submission.keyword]
    etd.post_graduation_email = [@submission.post_graduation_email]
    etd.files_embargoed = true # need to adjust for multiple embargo types
    etd.abstract_embargoed = false # need to adjust for multiple embargo types
    etd.toc_embargoed = false # need to adjust for multiple embargo types
    etd.embargo_length = @submission.embargo_length
    etd.department = [@submission.department]
    etd.school = [@submission.school]
    etd.subfield = [@submission.subfield]
    etd.degree = [@submission.degree]
    etd.abstract = [@submission.abstract]
    etd.creator = [@submission.creator]
    etd.language = [@submission.language]
    etd.other_copyrights = @submission.copyrights
    etd.requires_permissions = @submission.requires_permissions
    etd.patents = @submission.patents
    etd.partnering_agency = [@submission.partnering_agency]
    etd.research_field = [@submission.research_field]
    etd.submitting_type = [@submission.submitting_type]
    etd.table_of_contents = [@submission.table_of_contents]

    etd.committee_chair.build(name: [@submission.committee_chair], affiliation: ["Emory University"])
    etd.committee_members.build(name: [@submission.committee_members], affiliation: ["Emory University"])

    file1_path = @submission.primary_pdf_file.current_path
    file2_path = @submission.supplemental_file.current_path

    etd.save

    byebug

    ability = ::Ability.new(current_user)
    # file1_path = "#{::Rails.root}/spec/fixtures/joey/joey_thesis.pdf"
    # file2_path = "#{::Rails.root}/spec/fixtures/miranda/image.tif"
    upload1 = File.open(file1_path) { |file1|
      Hyrax::UploadedFile.create(user: current_user, file: file1, pcdm_use: 'primary')
    }
    upload2 = File.open(file2_path) { |file2|
      Hyrax::UploadedFile.create(
          user: current_user,
          file: file2,
          pcdm_use: 'supplementary',
          description: 'Description of the supplementary file',
          file_type: 'Image'
      )
    }

    attributes_for_actor = { uploaded_files: [upload1.id, upload2.id] }
    env = Hyrax::Actors::Environment.new(etd, ability, attributes_for_actor)
    middleware = Hyrax::DefaultMiddlewareStack.build_stack.build(Hyrax::Actors::Terminator.new)
    middleware.create(env)

    # @submission.delete #if the full middleware was successful - this maybe needs to be added to the actor stack :(

  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit( Submission::SAVED_ATTRIBUTES )
    end
end
