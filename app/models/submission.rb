class Submission < ApplicationRecord
  mount_uploader :primary_pdf_file, EtdFileUploader
  mount_uploader :supplemental_file, EtdFileUploader

  SAVED_ATTRIBUTES = [
      ['My ETD', [
      :creator,
      :graduation_date,
      :school,
      :post_graduation_email]],

      ['My Program', [
      :department,
      :subfield,
      :partnering_agency,
      :degree,
      :submitting_type]],

      ['My Advisor', [
      :committee_chair,
      :committee_members]],

      ['My ETD', [
      :title,
      :language,
      :abstract,
      :table_of_contents]],

      ['Keywords & Copyright', [
      :research_field,
      :keyword,
      :requires_permissions,
      :copyrights,
      :patents]],

      ['My Files', [
      # handle these separately
      :primary_pdf_file,
      :supplemental_file
      ]],

      ['Embargo', [
      :embargo_length,
      :embargo_type,

      # Submission
      :agreement]]
  ]
end
