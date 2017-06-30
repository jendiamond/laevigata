require 'etd_factory'

desc "Build sample data"
task :sample_data do
  sample_data = [:sample_data, :sample_data_with_everything_embargoed, :sample_data_with_only_files_embargoed]
  sample_data.each do |s|
    etd_factory = EtdFactory.new
    etd = FactoryGirl.create(s)
    primary_pdf_file = "#{::Rails.root}/spec/fixtures/joey/joey_thesis.pdf"
    etd_factory.etd = etd
    etd_factory.primary_pdf_file = primary_pdf_file
    etd_factory.attach_primary_pdf_file
    puts "Created #{etd.id}"
  end
end
