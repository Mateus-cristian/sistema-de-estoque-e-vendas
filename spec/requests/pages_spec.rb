# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Pages", type: :request do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET /" do
    it "responde 200 OK" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end
end
