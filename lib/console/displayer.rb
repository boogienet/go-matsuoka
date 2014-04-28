
module GoMatsuoka
  module Console
    class Displayer
      def self.show_me (model_param, params = nil)
        model = model_param.camelize.singularize
        obj = Object::const_get(model)
        obj.all
      end
    end
  end
end
