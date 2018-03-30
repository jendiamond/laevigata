# Generated via
#  `rails generate hyrax:work Etd`
require 'rails_helper'

include Warden::Test::Helpers

RSpec.feature 'Create an Etd' do
  let(:user) { create :user }

  context 'a logged in user' do
    before do
      login_as user
      visit("/concern/etds/new")
    end

    scenario "'about me and my program' has all its inputs" do
      # expect(current_path).to include(new_hyrax_etd_url)
      expect(page).to have_css('#about_me input#etd_creator')
      expect(page).to have_css('#about_me select#etd_graduation_date')
      expect(page).to have_css('#about_me input#etd_post_graduation_email')
      expect(page).to have_css('#about_me select#etd_school')
      expect(page).to have_css('#about_me select#etd_degree')
      expect(page).to have_css('#about_me select#etd_department')
      expect(page).to have_css('#about_me select#etd_subfield')
      expect(page).to have_css('#about_me select#etd_submitting_type')
      expect(page).to have_content("Committee Chair/Thesis Advisor's Affiliation")
      expect(page).to have_content("Committee Chair/Thesis Advisor")

      expect(page).to have_content('Add another Committee Chair/Thesis Advisor')

      expect(page).to have_css('#about_me select#etd_committee_members_attributes_0_affiliation_type')
      expect(page).to have_content('Committee Member')
      expect(page).to have_content('Add another Committee Member')
      expect(page).to have_css('#about_me select#etd_partnering_agency')
    end

    scenario "validates 'about me and my program'", js: true unless continuous_integration? do
      fill_in 'Student Name', with: 'Eun, Dongwon'
      select("Spring 2018", from: "Graduation Date")
      fill_in "Post Graduation Email", with: "graduate@done.com"
      select("Laney Graduate School", from: "School")
      select("Religion", from: "Department")
      select("Ethics and Society", from: "Sub Field")
      select('MS', from: "Degree")
      select("Honors Thesis", from: "Submission Type")
      fill_in "Committee Chair/Thesis Advisor", with: "Diane Arbus"

      fill_in "etd[committee_members_attributes][0][name][]", with: "Joan Didion"

      expect(page).to have_css('li#required-about-me.complete')
    end

    scenario "'about me' has an invalid post graduation email", js: true unless continuous_integration? do
      fill_in "Post Graduation Email", with: "graduate@done"
      wait_for_ajax
      expect(page).to have_css('input#etd_post_graduation_email.red_input')
    end

    scenario "'about me' has a valid post graduation email", js: true unless continuous_integration? do
      fill_in "Post Graduation Email", with: "graduate@done.com"
      wait_for_ajax
      expect(page).not_to have_css('input#etd_post_graduation_email.red_input')
    end

    scenario "'about me' has no committee affiliation field when affiliation type Emory is selected", js: true unless continuous_integration? do
      select('Non-Emory Committee Chair', from: "Committee Chair/Thesis Advisor's Affiliation")
      affiliation = find_field(id: 'etd[committee_chair_attributes][0]_affiliation')
      expect(affiliation).not_to be_disabled
      select('Emory Committee Chair', from: "Committee Chair/Thesis Advisor's Affiliation")
      expect(affiliation).to be_disabled
      expect(affiliation.value).to eq 'Emory'
    end

    scenario "'about me' committee affiliation accepts user input when Non-Emory is selected", js: true unless continuous_integration? do
      select('Non-Emory Committee Member', from: "Committee Member's Affiliation")
      wait_for_ajax
      fill_in "etd[committee_members_attributes][0]_affiliation", with: "MOMA"
      expect(find_field("etd[committee_members_attributes][0]_affiliation").value).to eq("MOMA")
    end

    scenario "'about me' no committee members selected", js: true unless continuous_integration? do
      page.check('#no_committee_members')
      wait_for_ajax
      affiliation_type = find_field(id: 'etd_committee_members_attributes_0_affiliation_type')
      affiliation = find_field(id: 'etd[committee_chair_attributes][0]_affiliation')
      member_name = find_field(id: 'etd[committee_members_attributes][0]_name')
      add_member = find_field(id: 'add-another-member')
      expect(affiliation_type).to be_disabled
      expect(affiliation).to be_disabled
      expect(member_name).to be_disabled
      expect(add_member).to be_disabled
      expect(affiliation.value).to eq ''
      expect(affiliation_type.value).to eq ''
      expect(member_name.value).to eq ''
    end

    scenario "'about me' adds and removes committee members", js: true unless continuous_integration? do
      click_on("Add another Committee Member")
      wait_for_ajax

      click_on("Add another Committee Member")
      wait_for_ajax

      expect(all('select.committee-member-select').count).to eq(3)

      click_on("Remove Committee Member", match: :first)
      wait_for_ajax
      expect(all('select.committee-member-select').count).to eq(2)

      click_on("Remove Committee Member", match: :first)
      wait_for_ajax

      expect(all('select.committee-member-select').count).to eq(1)
    end
    # the add code works only for committee members right now

    scenario "'about me' hides partnering agencies unless the Rollins school is selected", js: true unless continuous_integration? do
      select("Laney Graduate School", from: "School")

      expect(page).not_to have_css('div#rollins_partnering_agencies')
    end

    scenario "'about me' select a graduation date from the dropdown", js: true do
      select("Summer 2018", from: "Graduation Date")

      expect(page).to have_select('etd_graduation_date', selected: 'Summer 2018')
    end

    scenario "'about me' displays partnering agencies when Rollins is the selected school", js: true do
      select("Rollins School of Public Health", from: "School")
      wait_for_ajax
      expect(page).to have_css('div#rollins_partnering_agencies')
    end

    scenario "display indicates incomplete 'about me and my program' data", js: true unless continuous_integration? do
      visit("/concern/etds/new")

      select('Emory Committee Chair', from: "Committee Chair/Thesis Advisor's Affiliation")
      fill_in 'etd[committee_chair_attributes][0]_name', with: "Diane Arbus"
      select('Non-Emory Committee Member', from: "Committee Member's Affiliation")
      expect(page).to have_content('Committee Member')
      fill_in "etd[committee_members_attributes][0][name][]", with: "Joan Didion"

      expect(page).not_to have_css('li#required-about-me.complete')
    end
  end
end
