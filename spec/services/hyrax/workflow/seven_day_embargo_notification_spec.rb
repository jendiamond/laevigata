libdir = File.expand_path('../../../../', __FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)
require 'rails_helper'
require 'active_fedora/cleaner'
require 'workflow_setup'
require 'database_cleaner'

RSpec.describe Hyrax::Workflow::SevenDayEmbargoNotification do
  before :all do
    ActiveFedora::Cleaner.clean!
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    w = WorkflowSetup.new("#{fixture_path}/config/emory/superusers.yml", "#{fixture_path}/config/emory/candler_admin_sets.yml", "/dev/null")
    w.setup
  end
  let(:user) { FactoryGirl.create(:user) }
  let(:etd) { FactoryGirl.create(:seven_day_expiration, depositor: user.user_key, school: ["Candler School of Theology"]) }
  let(:ability) { ::Ability.new(user) }
  let(:recipients) do
    { 'to' => [FactoryGirl.create(:user), FactoryGirl.create(:user)] }
  end
  let(:notification) do
    attributes_for_actor = { admin_set_id: etd.admin_set.id }
    actor = Hyrax::CurationConcern.actor(etd, ability)
    actor.create(attributes_for_actor)
    work_global_id = etd.to_global_id.to_s
    entity = Sipity::Entity.where(proxy_for_global_id: work_global_id).first
    described_class.new(entity, '', user, recipients)
  end
  it "can instantiate" do
    expect(notification).to be_instance_of(described_class)
  end
  it "can find depositor" do
    expect(notification.depositor).to be_instance_of(::User)
    expect(notification.depositor.uid).to eq user.uid
  end
  it "sends notifications to the depositor and no one else" do
    expect(notification.recipients["to"].pluck(:uid)).to contain_exactly(user.uid)
  end
end