module ImportLegacy

  def show_import?
    !import_done?
  end

  def import_legacy(file)
    @success = false
  end

  def import_successful?
    @success
  end
end
