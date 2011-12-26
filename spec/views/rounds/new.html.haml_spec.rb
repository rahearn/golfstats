require 'spec_helper'

describe "rounds/new.html.haml" do

  before(:each) do
    assign :round, Round.new
    render
  end

  it "has a form for entering a new round" do
    rendered.should include '<form accept-charset="UTF-8" action="/rounds" class="new_round" id="new_round" method="post">'
  end

  it "has select boxes for date" do
    rendered.should include '<select id="round_date_1i" name="round[date(1i)]">'
    rendered.should include '<select id="round_date_2i" name="round[date(2i)]">'
    rendered.should include '<select id="round_date_3i" name="round[date(3i)]">'
  end

  it "has an input box for score" do
    rendered.should include '<input id="round_score" min="1" name="round[score]" size="30" type="number" />'
  end

  it "has a text area for notes" do
    rendered.should include '<textarea cols="40" id="round_notes" name="round[notes]" rows="20">'
  end

  it "has a hidden field for course" do
    rendered.should include '<input id="round_course_id" name="round[course_id]" type="hidden" />'
  end
end
