require 'rails_helper'

RSpec.describe DeliveryPaymentCostType, type: :model do
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:description) }
  it { should have_many(:purchases) }
end