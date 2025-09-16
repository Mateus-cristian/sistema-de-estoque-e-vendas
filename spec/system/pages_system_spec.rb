require "rails_helper"

RSpec.describe "Home Page", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "incrementa o contador" do
    visit root_path
    expect(page).to have_content("Contador: 0")
    click_button "Incrementar"
    expect(page).to have_content("Contador: 1")
  end
end