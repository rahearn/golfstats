module ImportLegacy

  def show_import?
    true
  end

  def import_legacy(file)
    @success = false
  end

  def import_successful?
    @success
  end
end
