class BasePresenter

  def initialize object, template
    @object = object
    @template = template
  end

  private

    def self.presents name
      define_method(name){ @object }
    end

    def h; @template end 

end
