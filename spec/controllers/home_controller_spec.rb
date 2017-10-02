require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET forum" do
    it "renders the forums template" do
      get :forum
      expect(response).to render_template("forum")
    end
  end

end
