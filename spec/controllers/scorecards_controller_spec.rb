require 'spec_helper'

describe ScorecardsController do

  describe "GET :show" do
    let(:scorecard) { create :scorecard }
    let(:round) { create :round, :scorecard => scorecard }
    before(:each) do
      sign_in round.user
      get :show, :round_id => round.id
    end

    it { should respond_with :success }
    it { should assign_to(:scorecard).with scorecard }
  end

  describe "GET :new" do
    let(:round) { create :round }
    before(:each) do
      sign_in round.user
      get :new, :round_id => round.id
    end

    it { should respond_with :success }
    it { should assign_to(:scorecard).with_kind_of Scorecard }
  end

  describe "POST :create" do
    let(:round)     { create :round }
    let(:scorecard) { attributes_for :scorecard }
    before(:each) do
      sign_in round.user
      post :create, :round_id => round.id, :scorecard => scorecard
    end

    it { should respond_with :redirect }

    it "creates a new scorecard" do
      created = assigns :scorecard
      created.should be_persisted
      created.round.should == round
      created.score.should == scorecard[:score]
    end
  end

end
