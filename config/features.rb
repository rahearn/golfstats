# Feature switching


feature :legacy_import do |user|
  !user.import_done? &&
    %w(
      ryan@coshx.com ryan.c.ahearn@gmail.com
    ).include?(user.email)
end
