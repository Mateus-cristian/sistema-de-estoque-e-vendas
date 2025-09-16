# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home Page", type: :system do
  let(:user) { create(:user) }
  before do
    driven_by(:rack_test)
    sign_in user
  end

  it "incrementa o contador" do
    visit root_path
    expect(page).to have_content("Contador: 0")
    click_button "Incrementar"
    expect(page).to have_content("Contador: 1")
  end
end
