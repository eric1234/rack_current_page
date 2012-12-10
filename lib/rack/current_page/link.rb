# Provide us with just enough understanding about a link tag to
# accomplish our mission.
class Rack::CurrentPage::Link

  def initialize tag
    @tag = tag
  end

  # Will determine if the path given is the destination of the link
  def points_to? path
    href = @tag.scan(/href=\"([^"]*)\"/)[0][0]
    unless href.start_with? '/'
      href = URI(href).send :path_query rescue nil
    end
    href == path
  end

  # Add the class. Is smart enough to handle the following setups:
  #
  # * The class attribute already exists and we just need to add to it
  # * The class attribute does not exist and we need to add it
  # * The class has already be added to the class attribute.
  def append_class! klass
    return if already_marked? klass
    if has_class_attribute?
      add_class_to_attribute klass
    else
      add_class_and_attribute klass
    end
  end

  # Print the link
  def to_s
    @tag
  end

  private

  def already_marked? klass
    @tag =~ /class=\"[^"]*#{klass}[^"]*\"/
  end

  def has_class_attribute?
    @tag =~ /class=\"[^"]*\"/
  end

  def add_class_and_attribute klass
    @tag.sub! '<a', "<a class=\"#{klass}\""
  end

  def add_class_to_attribute klass
    @tag.sub! 'class="', "class=\"#{klass} "
  end

end
