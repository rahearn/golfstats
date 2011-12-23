require 'spec_helper'

describe "courses/_course.html.haml" do

  let(:course) { build_stubbed :course }
  it "displays the course name and location" do
    render :partial => "course", :locals => {:course => course}
    rendered.should include "#{course.name} (#{course.location})"
  end
end
