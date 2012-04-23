# Feature switching


feature :legacy_import do |user|
  user.show_import? &&
    %w(
      ryan@coshx.com ryan.c.ahearn@gmail.com
    ).include?(user.email)
end
