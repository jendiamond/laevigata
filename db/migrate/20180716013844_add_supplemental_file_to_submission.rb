class AddSupplementalFileToSubmission < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :supplemental_file, :string
  end
end
