require 'rails_helper'

RSpec.describe HomeController, type: :controller do


  describe "GET index" do
    it "renders the faq template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET faq" do
    it "renders the faq template" do
      get :forum
      expect(response).to render_template("forum")
    end
  end

  describe "GET faq" do
    it "renders the faq template" do
      get :faq
      expect(response).to render_template("faq")
    end
  end

end
