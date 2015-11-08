module ApplicationHelper

  def present object
    klass = "#{object.class}Presenter".constantize
    presenter = klass.new object, self
    yield presenter
  end

end
