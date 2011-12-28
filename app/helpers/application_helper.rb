module ApplicationHelper

  def error_messages_for(*objects)
    objects_in_error = objects.select { |o| o.errors.any? }

    content_tag(:div, :id => 'error_explanation') do
      objects_in_error.inject("") do |take, object|
        name = object.class.name.demodulize.titleize.downcase
        take << content_tag(:h2, "#{pluralize(object.errors.count, 'error')} prohibited this #{name} from being saved:")
        take << content_tag(:ul) do
          object.errors.full_messages.map { |m| content_tag(:li, m) }.join.html_safe
        end

        take
      end.html_safe
    end if objects_in_error.any?
  end

end
