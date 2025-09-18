# frozen_string_literal: true


require 'rails_helper'

RSpec.describe "Sales", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product, quantity: 10, price: 5.0) }

  before { sign_in user }

  describe "POST /sales" do
    context "with valid parameters" do
      it "creates a new sale and decrements product quantity" do
        expect {
          post sales_path, params: { sale: { product_id: product.id, quantity: 2 } }
        }.to change(Sale, :count).by(1)
        expect(product.reload.quantity).to eq(8)
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
end
