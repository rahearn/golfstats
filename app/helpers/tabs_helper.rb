module TabsHelper

  def current_tab
    (params[:tab] || (current_user.rounds.any? ? :activity : :add_round)).to_sym
  end

  def tab_class(current, tested)
    current == tested ? 'current' : ''
  end

end
