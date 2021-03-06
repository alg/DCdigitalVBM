require 'spec_helper'

describe PagesController do

  it "should display the front page" do
    get :front
    response.should render_template(:front)
  end

  describe "when going to overview page" do
    it "should just show whatever it is" do
      get :overview
      response.should render_template(:overview)
    end

    it "should switch to digital" do
      get :overview, :voting_type => "digital"
      response.should render_template(:overview)
      @controller.voting_type.should == "digital"
    end
    
    it "should switch to physical" do
      get :overview, :voting_type => "physical"
      response.should render_template(:overview)
      @controller.voting_type.should == "physical"
    end
  end
  
  describe "when checking in" do
    it "should display form" do
      get :check_in
      response.should render_template(:check_in)
    end
    
    it "should return to the check in form if record wasn't found" do
      post :check_in, :registration => { :pin => "unknown" }
      response.should render_template(:check_in)
      assigns(:registration).should be_nil
    end
    
    it "should move on to the confirm page when record was found" do
      r = Factory(:registration, :pin => "1234")
      post :check_in, :registration => { :pin => "1234", :name => r.name, :zip => r.zip, :voter_id => r.voter_id }
      response.should redirect_to(confirm_url)
    end
  end
  
  describe "when confirming" do
    it "should render the page" do
      stub_registration
      get :confirm
      response.should render_template(:confirm)
    end
  end

  describe "when completing" do
    it "should render the page" do
      stub_registration
      get :complete
      response.should render_template(:complete)
    end
  end
  
  describe "when sending ballot" do
    before do
      stub_registration
    end

    it "should return to the same form if ballot is invalid and can't be saved" do
      @controller.stubs(:save_ballot).returns(false)
      post :return
      response.should render_template(:return)
    end
    
    it "should render the thanks page if all is good" do
      @controller.stubs(:save_ballot).returns(true)
      post :return
      response.should redirect_to(thanks_path)
    end
  end

  describe "when viewing thanks" do
    it "should render the page" do
      stub_registration
      get :thanks
      response.should render_template(:thanks)
    end
  end
  
  def stub_registration
    @r = Factory(:registration)
    session[:rid] = @r.id
  end
end
