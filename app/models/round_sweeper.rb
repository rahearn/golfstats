class RoundSweeper < ActionController::Caching::Sweeper
  observe Round

  def after_update(round)
    expire_fragment(
      controller: 'pages',
      action: 'home',
      action_suffix: "round_#{round.id}"
    )
  end

end
