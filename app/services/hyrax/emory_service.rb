# services/emory_service.rb
module Hyrax
  class EmoryService < Hyrax::QaSelectService
    def initialize
      super('emory_programs')
    end
  end
end
