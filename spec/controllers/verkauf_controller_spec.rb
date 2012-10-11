require 'spec_helper'

describe VerkaufController do

  describe "GET 'shop'" do
    it "returns http success" do
      get 'shop'
      response.should be_success
    end
  end

  describe "GET 'konto'" do
    it "returns http success" do
      get 'konto'
      response.should be_success
    end
  end

end
