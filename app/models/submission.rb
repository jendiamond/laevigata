class Submission < ApplicationRecord
  mount_uploader :primary_pdf_file, EtdFileUploader
  mount_uploader :supplemental_file, EtdFileUploader

  SAVED_ATTRIBUTES = [
      [:about_me, [
      :creator,
      :graduation_date,
      :school,
      :post_graduation_email]],

      [:my_program, [
      :department,
      :subfield,
      :partnering_agency,
      :degree,
      :submitting_type]],

      [:my_advisor, [
      :committee_chair,
      :committee_members]],

      [:abstract, [
      :title,
      :language,
      :abstract,
      :table_of_contents]],

      [:keywords, [
      :research_field,
      :keyword,
      :requires_permissions,
      :copyrights,
      :patents]],

      [:my_files, [
      # handle these separately
      :primary_pdf_file,
      :supplemental_file]],

      [:embargo, [
      :embargo_length,
      :embargo_type]],

      [:review, [
      :agreement]]
  ].freeze

  steps = Submission::SAVED_ATTRIBUTES.map{ |step, fields| step }.freeze

end
