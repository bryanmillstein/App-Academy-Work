require 'rails_helper'

RSpec.describe "FriendlyForwardings", :type => :request do
    
  describe "GET /friendly_forwardings" do
    it "works! (now write some real specs)" do
      get friendly_forwardings_path
      expect(response).to have_http_status(200)
    end
  end
end
