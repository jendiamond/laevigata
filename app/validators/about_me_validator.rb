class AboutMeValidator < ActiveModel::Validator
  def validate(record)
    return unless current_tab?(record)
    ::Hyrax::EtdForm.about_me_terms.each do |field|
      record.errors.add(field, "#{field} is required") if parsed_data(record)[field.to_s].empty?
    end
  end

  def parsed_data(record)
    JSON.parse(record.data)
  end

  def current_tab?(record)
    parsed_data(record)['currentTab'] == "About Me"
  end
end
