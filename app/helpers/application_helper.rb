module ApplicationHelper

  def error_messages_for(*objects)
    objects_in_error = objects.select { |o| o.present? && o.errors.any? }

    content_tag(:div, :class => 'mod notices') do
      content_tag(:div, :class => 'inner bd container') do
        objects_in_error.inject("") do |msgs, object|
          name = object.class.name.demodulize.titleize.downcase
          msgs << content_tag(:h2, "#{pluralize(object.errors.count, 'error')} prohibited this #{name} from being saved:")
          msgs << content_tag(:ul) do
            object.errors.full_messages.map { |m| content_tag(:li, m) }.join.html_safe
          end
        end.html_safe
      end
    end if objects_in_error.any?
  end

  def profile_link_text
    current_user.name || current_user.email || 'Profile'
  end
end
