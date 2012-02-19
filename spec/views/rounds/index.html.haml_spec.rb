require 'spec_helper'

describe "rounds/index" do

  it "renders _round partial for each round" do
    assign :rounds, [build_stubbed(:round), build_stubbed(:round)]
    render
    view.should render_template(:partial => '_round', :count => 2)
  end

end
