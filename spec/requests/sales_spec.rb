# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Sales", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product, quantity: 10, price: 5.0) }
  let!(:sale) { FactoryBot.create(:sale, user: user, product: product, quantity: 2) }

  before { sign_in user }

  describe "POST /sales" do
    context "with valid parameters" do
      it "creates a new sale and decrements product quantity" do
        expect {
          post sales_path, params: { sale: { product_id: product.id, quantity: 2 } }
        }.to change(Sale, :count).by(1)
        expect(product.reload.quantity).to eq(6)
        expect(response).to redirect_to(sales_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a sale with quantity greater than quantity" do
        expect {
          post sales_path, params: { sale: { product_id: product.id, quantity: 20 } }
        }.not_to change(Sale, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

    describe "GET /sales" do
    it "renders the index page with sales" do
      get sales_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(product.name)
    end
  end

  describe "GET /sales/:id" do
    it "renders the show page for a sale" do
      get sale_path(sale)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(product.name)
      expect(response.body).to include(sale.quantity.to_s)
    end
  end
end
