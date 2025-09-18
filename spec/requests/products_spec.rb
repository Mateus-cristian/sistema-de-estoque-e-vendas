# frozen_string_literal: true
require "rails_helper"

RSpec.describe "Products", type: :request do
  let(:admin) { FactoryBot.create(:user, role: :admin, password: "password") }
  let(:product) { FactoryBot.create(:product) }
  
  let(:valid_attributes) do
    {
      name: "Sample Product",
      price: 19.99,
      quantity: 100
    }
  end

  let(:invalid_attributes) do
    {
      name: "",
      price: -10,
      quantity: -5
    }
  end

  context "when logged in as admin" do
    before { sign_in admin }

    context "HTML requests" do
      it "lists all products" do
        product = FactoryBot.create(:product)
        get products_path
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(product.name)
      end

      it "creates a product with valid attributes" do
        expect {
          post products_path, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
        expect(response).to redirect_to(products_path)
        follow_redirect!
        expect(response.body).to include("Produto criado com sucesso")
      end

      it "does not create a product with invalid attributes" do
        expect {
          post products_path, params: { product: invalid_attributes }
        }.not_to change(Product, :count)
        expect(response.body).to include("Quantity must be greater than or equal to 0")
      end
    end

    context "Turbo Stream requests" do
      it "creates a product and returns turbo_stream" do
        expect {
          post products_path,
               params: { product: valid_attributes },
               headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to change(Product, :count).by(1)

        expect(response).to have_http_status(:ok)
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(response.body).to include("turbo-stream")
      end

      it "renders errors with turbo_stream when invalid" do
        expect {
          post products_path,
               params: { product: invalid_attributes },
               headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.not_to change(Product, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Quantity must be greater than or equal to 0")
      end
    end

    describe "PATCH /products/:id" do
      it "updates a product with valid attributes" do
        patch product_path(product), params: {
          product: { name: "Updated Name" }
        }
        expect(response).to redirect_to(products_path)
        follow_redirect!
        expect(response.body).to include("Produto atualizado com sucesso")
        expect(product.reload.name).to eq("Updated Name")
      end

      it "does not update with invalid attributes" do
        patch product_path(product), params: {
          product: { price: -10 }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(product.reload.price).not_to eq(-10)
      end
    end

    describe "DELETE /products/:id" do
      it "destroys the product" do
        product 
        expect {
          delete product_path(product)
        }.to change(Product, :count).by(-1)
        expect(response).to redirect_to(products_path)
        follow_redirect!
        expect(response.body).to include("Produto removido com sucesso")
      end
    end
  end

  context "with guest user" do
    it "redirects to login page when trying to access products" do
      get products_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
