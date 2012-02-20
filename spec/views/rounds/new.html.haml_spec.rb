require 'spec_helper'

describe "rounds/new" do

  let(:course) { create :course }
  before(:each) do
    view.stub(:current_user).and_return build_stubbed(:user)
    assign :course, course
    assign :round, Round.new
    render
  end

  it "has a form for entering a new round" do
    rendered.should include(
      %|<form accept-charset="UTF-8" action="/courses/#{course.id}/rounds" class="new_round" id="new_round" method="post">|
    )
  end

  it "has select boxes for date" do
    rendered.should include '<select id="round_date_1i" name="round[date(1i)]">'
    rendered.should include '<select id="round_date_2i" name="round[date(2i)]">'
    rendered.should include '<select id="round_date_3i" name="round[date(3i)]">'
  end

  it "has an input box for score" do
    rendered.should include '<input id="round_score" min="1" name="round[score]" type="number" />'
  end

  it "has a text area for notes" do
    rendered.should include '<textarea cols="40" id="round_notes" name="round[notes]" rows="4">'
  end

  it "renders the scorecard partial" do
    view.should render_template(:partial => "scorecards/_form")
  end
end
