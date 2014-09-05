require 'spec_helper'

describe Brick do

  it { should have_db_column(:quote).of_type(:string) }
  it { should have_db_column(:author).of_type(:string) }
  it { should have_db_column(:order).of_type(:integer) }

  it { should validate_presence_of(:quote) }
  it { should validate_presence_of(:author) }

end

describe Brick, "#next_order" do
  it "should return the maximum of all bricks' orders" do
    create_list :brick, rand(3..7)
    brick = create :brick
    expect(Brick.next_order).to eq (brick.order+1)
  end
  it "should return 1 when no bricks exist" do
    expect(Brick.next_order).to eq 1
  end
end

describe Brick, ".set_order" do
  it "should set the order to maximum order + 1" do 
  end
end
