# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "StockReport", type: :request do
  let(:admin) { FactoryBot.create(:user, role: :admin) }

  before { sign_in admin }

  it "renders the stock report page" do
    get admin_stock_report_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Relatório de Estoque Baixo")
  end

  it "shows only products with low stock" do
    low_stock = FactoryBot.create(:product, name: "Produto Crítico", quantity: 2)
    normal_stock = FactoryBot.create(:product, name: "Produto Ok", quantity: 10)

    get admin_stock_report_path, params: { threshold: 5 }
    expect(response.body).to include("Produto Crítico")
    expect(response.body).not_to include("Produto Ok")
  end

  it "redirects guest to login" do
    sign_out admin
    get admin_stock_report_path
    expect(response).to redirect_to(new_user_session_path)
  end
end
