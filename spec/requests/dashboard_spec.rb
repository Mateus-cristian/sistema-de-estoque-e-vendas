# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Dashboard", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, role: :admin) }

  before { sign_in admin }

  it "renders the dashboard page" do
    get admin_dashboard_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Dashboard")
  end

  it "shows total sales and low stock products" do
    product1 = FactoryBot.create(:product, quantity: 2, name: "Low Stock Product")
    product2 = FactoryBot.create(:product, quantity: 10, name: "Normal Product")
    FactoryBot.create(:sale, product: product1, user: admin, quantity: 1)
    FactoryBot.create(:sale, product: product2, user: admin, quantity: 2)

    get admin_dashboard_path
    expect(response.body).to include("Low Stock Product")
    expect(response.body).to include("Total de vendas")
  end

  it "redirects guest to login" do
    sign_out admin
    get admin_dashboard_path
    expect(response).to redirect_to(new_user_session_path)
  end
end
