module ApplicationHelper

  def present object, builder
    klass = "#{object.class}Presenter".constantize
    presenter = klass.new object, builder, self
    yield presenter
  end

end
