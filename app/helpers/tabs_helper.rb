module TabsHelper

  def tab_class(current, tested)
    current == tested ? 'current' : ''
  end

end
