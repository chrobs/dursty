require 'spec_helper'

describe KasseController do

  describe "GET 'kassenstand'" do
    it "returns http success" do
      get 'kassenstand'
      response.should be_success
    end
  end

end
