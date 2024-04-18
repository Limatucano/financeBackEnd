class ApplicationController < ActionController::API
      def render_field_error(field) 
            render json: {
                  message: "O campo #{field} é obrigatório!"
            }, status: 400
      end
end
