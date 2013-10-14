module ApplicationHelper

  def error_messages_for(*objects)
    objects_in_error = objects.select { |o| o.present? && o.errors.any? }

    content_for :error_messages do
      content_tag(:div, :class => 'wrapper notices') do
        content_tag(:div, :class => 'error') do
          objects_in_error.inject("") do |msgs, object|
            name = object.class.name.demodulize.titleize.downcase
            msgs << content_tag(:h3, "#{pluralize(object.errors.count, 'error')} prohibited this #{name} from being saved:")
            msgs << content_tag(:ul) do
              object.errors.full_messages.map { |m| content_tag(:li, m) }.join.html_safe
            end
          end.html_safe
        end
      end
    end if objects_in_error.any?
  end

  def profile_link_text
    return current_user.name  if current_user.name?
    return current_user.email if current_user.email?
    'Profile'
  end

  def esc_limit_text(handicap)
    esc_limit = EquitableStrokeCalculator.esc_limit handicap
    esc_limit == :dbl_bogey ? 'Double Bogey' : esc_limit
  end
end
