require "rails_helper"

describe Budgie do

  it "have a valid factory" do
    new_budgie = build :budgie
    expect(new_budgie).to be_valid
  end

  it "is invalid without a name" do
    new_budgie = build :budgie, name: nil
    new_budgie.valid?
    expect(new_budgie.errors[:name]).to include "can't be blank"
  end

  it "is invalid without a color" do
    new_budgie = build :budgie, color_id: nil
    new_budgie.valid?
    expect(new_budgie.errors[:color_id]).to include "can't be blank"
  end

  it "is invalid without age" do
    new_budgie = build :budgie, age: nil
    new_budgie.valid?
    expect(new_budgie.errors[:age]).to include "can't be blank"
  end

  it "is invalid with age < 0" do
    new_budgie = build :budgie, age: -1
    new_budgie.valid?
    expect(new_budgie.errors[:age]).to include "must be greater than or equal to 0"
  end

end
