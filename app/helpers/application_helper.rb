# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Typed translation takes the type of the voting process (physical or digital) into
  # account when creating the key
  def tt(key)
    raw t(tkey(key), :default => t(key))
  end

  # Generates the voting type dependent translation key
  def tkey(key)
    ".#{voting_type}#{key}"
  end
  
  # Generates ul-li list of pipe-separated steps stored in the given key
  def pipe_list(items)
    content_tag(:ul, raw(items.split('|').map { |l| content_tag(:li, l) }.join))
  end
  
  # Displays a standard tip
  def tip(text)
    image_tag "question.gif", :title => text, :class => "tip"
  end
  
  def step_section(options = {})
    step = options[:step]
    icon = options[:icon]
    
    icon_box = nil
    if icon
      icon_link = options[:icon_link]
      box_class = [ "box", "centered" ]
      box_class << "passive" unless icon_link
      icon_box = content_tag(:div, icon_link ? link_to(image_tag(icon), icon_link, :id => options[:icon_id]) : image_tag(icon), :class => box_class.join(' '))
    end
    
    content_tag(:div, raw([
      content_tag(:div, raw([
        content_tag(:h3, tt(".step_#{step}.title")),
        content_tag(:h4, tt(".step_#{step}.instruction") + " " + tip(tt(".step_#{step}.tip"))),
        tt(".step_#{step}.summary") ].join), :class => "main"),
      content_tag(:div, raw([ icon_box ].compact.join), :class => "icon") ].join), :class => 'section')
  end
end
