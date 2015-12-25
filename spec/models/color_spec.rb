require "rails_helper"

describe Color do
  let(:color) { create :color }

  it "have a valid factory" do
    new_color = build :color
    expect(new_color).to be_valid
  end

  it "is invalid without a name" do
    new_color = build :color, name: nil
    new_color.valid?
    expect(new_color.errors[:name]).to include "can't be blank"
  end

  it "is invalid with a duplicate name" do
     color
     new_color = build :color
     new_color.valid?
     expect(new_color.errors[:name]).to include "has already been taken"
   end

end
