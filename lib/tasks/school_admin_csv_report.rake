require 'csv'

namespace :emory do
  desc "csv reports for ETD admins, format rake emory:csv_report[star_academic_year, end_academic year, school, degree]"

  task :csv_report, [:year_start, :year_end, :school, :degree] => [:environment] do |task, args|
    puts 'Loading environment...'
    puts 'Starting export...'

    etds = Etd.where(degree: args.degree, school: args.school)
    academic_year = ['Fall ' + args.year_start.to_s, 'Spring ' + args.year_end.to_s, 'Summer ' + args.year_end.to_s, 'Fall ' + args.year_end.to_s]
    CSV.open("csv_report.csv", "wb", write_headers: true,
                                     headers: ["Creator", "Advisor", "Committee Members", "Date", "Program"]) do |csv|
      etds.each do |etd|
        creator = etd.creator.to_a
        chair = etd.committee_chair_name.to_a.join("; ")
        members = etd.committee_members_names.to_a.join("; ")
        date =  etd.date_uploaded.to_date
        program = etd.research_field.to_a
        if academic_year.include? etd.graduation_year
          puts etd.title
          csv << [creator.first, chair, members, date, program.first]
        end
      end
    end
    puts 'export complete.'
  end
end
