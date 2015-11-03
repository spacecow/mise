module ActiveRecord
  class Base
    def self.mount_uploader col, obj; end
  end
end unless defined?(ActiveRecord)
class ImageUploader; end
require './app/models/image'
