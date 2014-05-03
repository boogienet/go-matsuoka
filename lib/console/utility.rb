module GoMatsuoka
  module Console
    class Utility
      def self.shift (obj, params)
        start_date = obj.start_date

        movement = params[:forward]
        if movement.nil?
          movement = params[:backward]
        end
        
        direction = "-"
        if params.has_key? :forward
          direction = "+"
        end
        
        new_start_date = eval "start_date #{direction} movement"
        
        obj.move_start_date(new_start_date)
      end
    end
  end
end
