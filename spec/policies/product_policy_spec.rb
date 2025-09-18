# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductPolicy do
  let(:admin) { FactoryBot.create(:user, role: :admin) }
  let(:user) { FactoryBot.create(:user, role: :user) }
  let(:product) { FactoryBot.create(:product) }

  describe 'index? and show?' do
    it 'allows admin' do
      expect(ProductPolicy.new(admin, product).index?).to be true
      expect(ProductPolicy.new(admin, product).show?).to be true
    end
    it 'allows normal user' do
      expect(ProductPolicy.new(user, product).index?).to be true
      expect(ProductPolicy.new(user, product).show?).to be true
    end
  end

  describe 'create?, new?, update?, edit?, destroy?' do
    it 'allows admin' do
      expect(ProductPolicy.new(admin, product).create?).to be true
      expect(ProductPolicy.new(admin, product).new?).to be true
      expect(ProductPolicy.new(admin, product).update?).to be true
      expect(ProductPolicy.new(admin, product).edit?).to be true
      expect(ProductPolicy.new(admin, product).destroy?).to be true
    end
    it 'denies normal user' do
      expect(ProductPolicy.new(user, product).create?).to be false
      expect(ProductPolicy.new(user, product).new?).to be false
      expect(ProductPolicy.new(user, product).update?).to be false
      expect(ProductPolicy.new(user, product).edit?).to be false
      expect(ProductPolicy.new(user, product).destroy?).to be false
    end
  end
end
