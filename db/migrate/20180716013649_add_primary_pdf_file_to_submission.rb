class AddPrimaryPdfFileToSubmission < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :primary_pdf_file, :string
  end
end
