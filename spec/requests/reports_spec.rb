# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Reports", type: :request do
  let(:admin) { FactoryBot.create(:user, role: :admin) }

  before { sign_in admin }

  it "renders the report page" do
    get admin_reports_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Relatório de Vendas")
  end

  it "filters sales by period" do
    product1 = FactoryBot.create(:product, name: "Produto no período")
    product2 = FactoryBot.create(:product, name: "Produto fora do período")

    sale1 = FactoryBot.create(:sale, product: product1, user: admin, created_at: 2.days.ago)
    sale2 = FactoryBot.create(:sale, product: product2, user: admin, created_at: 10.days.ago)

    get admin_reports_path, params: { start_date: 3.days.ago.to_date, end_date: Date.today }

    expect(response.body).to include("Produto no período")
    expect(response.body).not_to include("Produto fora do período")
  end

  it "redirects guest to login" do
    sign_out admin
    get admin_reports_path
    expect(response).to redirect_to(new_user_session_path)
  end
end
