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

  context "with custom selects" do
    #         К9
    #         /
    #  A1----B2----C3----D4
    #   \     \     \
    #   J8    F6    E5
    #          \
    #           G7
    let!(:a) { create :budgie, name:"A", id:1,  father_id:0, mother_id:0, gender:true }
    let!(:m) { create :budgie, name:"M", id:99, father_id:0, mother_id:0, gender:false }

    let!(:b) { create :budgie, name:"B", id:2, father_id:1, mother_id:99, gender:true }
    let!(:c) { create :budgie, name:"C", id:3, father_id:2, mother_id:99, gender:true }
    let!(:d) { create :budgie, name:"D", id:4, father_id:3, mother_id:99, gender:true }
    let!(:e) { create :budgie, name:"E", id:5, father_id:3, mother_id:99, gender:true }
    let!(:f) { create :budgie, name:"F", id:6, father_id:2, mother_id:99, gender:true }
    let!(:g) { create :budgie, name:"G", id:7, father_id:6, mother_id:99, gender:true }
    let!(:j) { create :budgie, name:"J", id:8, father_id:1, mother_id:99, gender:true }
    let!(:k) { create :budgie, name:"K", id:9, father_id:2, mother_id:99, gender:true }

    it "returns correct descendents" do
      expect(a.descendents).to match_array [b, c, d, e, f, g, j, k]
      expect(b.descendents).to match_array [c, d, e, f, g, k]
      expect(c.descendents).to match_array [d, e]
      expect(f.descendents).to match_array [g]
      expect(e.descendents).to match_array []
    end

    it "returns correct ancestors" do
      expect(a.ancestors).to match_array []
      expect(b.ancestors).to match_array [a, m]
      expect(c.ancestors).to match_array [a, b, m]
      expect(e.ancestors).to match_array [a, b, c, m]
      expect(g.ancestors).to match_array [a, b, f, m]
    end
  end

end
