module ApplicationHelper
  FLASH_KEYS = [:notice, :alert]

  def flash_messages
    content = "".html_safe
    FLASH_KEYS.each do |key|
      value = flash[key]
      next if value.blank?
      content << content_tag(:p, value, :id => "flash_#{key}")
    end
    content
  end

  def js(content)
    "\"#{escape_javascript content}\"".html_safe
  end
end
