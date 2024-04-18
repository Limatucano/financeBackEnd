class UserController < ApplicationController

      def sign_in
            return render_field_error("E-mail") if params[:email].blank?
            return render_field_error("Senha") if params[:password].blank?

            user = User.where(email: params[:email], password: params[:password]).first

            if user.nil?
                  render json: {
                        message: "Usuário ou Senha inválida, tente novamente!"
                  }, status: 400
            else
                  render json: {
                        account_id: user[:id],
                        name: user[:name],
                        email: user[:email],
                        created_at: user[:created_at]
                  }
            end
      end

      def sign_up            
            return render_field_error("E-mail") if params[:email].blank?
            return render_field_error("Nome") if params[:name].blank?
            return render_field_error("Senha") if params[:password].blank?

            begin
                  @user = User.new(
                        name: params[:name],
                        email: params[:email],
                        password: params[:password]
                  )
                  @user.save
                  render json: @user, status: :created
            rescue Exception => e
                  render json: {
                        message: "Erro Desconhecido, tente novamente mais tarde",
                        error: e
                  }, status: 400
            end
      end
end
