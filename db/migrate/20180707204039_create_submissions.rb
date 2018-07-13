class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      # About Me
      t.string :creator
      t.string :graduation_date
      t.string :school
      t.string :post_graduation_email

      # My Program
      t.string :department
      t.string :subfield
      t.string :partnering_agency
      t.string :degree
      t.string :submitting_type

      # My Advisor
      t.string :committee_chair
      t.string :committee_members

      # My ETD
      t.string :title
      t.string :language
      t.string :abstract
      t.string :table_of_contents

      # Keywords & Copyright
      t.string :research_field
      t.string :keyword
      t.string :requires_permissions
      t.string :copyrights
      t.string :patents

      # My Files
      # handle these separately

      # Embargo
      t.string :embargo_length
      t.string :embargo_type

      # Submission
      t.string :agreement

      t.timestamps
    end
  end
end
