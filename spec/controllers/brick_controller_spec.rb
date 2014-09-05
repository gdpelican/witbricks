require 'spec_helper'

describe BricksController do

  describe 'GET index' do
    it "returns a list of bricks in json" do
      brick1 = create :brick, quote: "QUOTE1"
      brick2 = create :brick, quote: "QUOTE2"
      
      get :index, format: :json

      expect(response_values('quote')).to include "QUOTE1"
      expect(response_values('quote')).to include "QUOTE2"
      expect(response_values('id')).to include brick1.id
      expect(response_values('id')).to include brick2.id
    end
  end

  describe 'GET show' do
    it "returns a brick by its id" do 
      brick = create :brick, quote: "QUOTE", author: "AUTHOR"

      get :show, id: brick.id, format: :json

      expect(json_response['id']).to eq brick.id
      expect(json_response['quote']).to eq "QUOTE"
      expect(json_response['author']).to eq "AUTHOR"
      expect(json_response['order']).to eq brick.order
    end
  end

  describe 'POST create' do
    it "can create a brick" do
      post :create, { brick: { quote: "QUOTE", author: "AUTHOR" }, format: :json }

      created = Brick.last

      expect(created).to be_present
      expect(created.quote).to eq "QUOTE"
      expect(created.author).to eq "AUTHOR"
      expect(created.order).to eq 1
    end
  end

  describe 'PATCH update' do
    it "can update values" do
      brick = create :brick, quote: "OLDQUOTE", author: "OLDAUTHOR"
      old_order = brick.order
    
      put :update, { id: brick.id, brick: { quote: "QUOTE", author: "AUTHOR" }, format: :json }
      brick.reload

      expect(brick.quote).to eq "QUOTE"
      expect(brick.author).to eq "AUTHOR"
      expect(brick.order).to eq old_order
    end

    it "can promote a brick to the top of the queue" do 
      brick1 = create :brick
      brick2 = create :brick

      expect(brick1.order).to be < brick2.order

      put :update, { id: brick1.id, brick: { promote: true }, format: :json }
      brick1.reload

      expect(brick1.order).to be > brick2.order
    end
  end

  describe 'DELETE destroy' do
    it "can destroy a brick" do
      brick = create :brick

      delete :destroy, { id: brick.id, format: :json }

      expect(Brick.count).to be_zero
      expect(response.status).to eq 204
    end
  end

  describe '.actions' do
    it "returns the correct actions" do
      expect(BricksController.actions).to match_array [:index, :show, :create, :update, :destroy]
    end
  end

  private

  def response_values(field)
    json_response.map { |r| r[field] }
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end
