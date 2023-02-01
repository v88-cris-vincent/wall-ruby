class UserController < ApplicationController
    def index
    end

    def register
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            require_params = params.permit!.require([:first_name, :last_name, :email_address, :password])

            if require_params.present?
                user = User.user_get(params[:email_address])

                if user[:status] && user[:result].length
                    response_data[:error] = "Email Address already exists."
                elsif params[:password] != params[:confirm_password]
                    response_data[:error] = "Password and Confirm Password does not match."
                else
                    user_create = User.user_create(params)

                    if user_create[:status]
                        response_data[:status] = true
                        response_data[:result] = user_create[:result]
                    else
                        response_data[:error] = "Error encountered in creating user."
                    end
                end
            else
                response_data[:result] = params
            end

        rescue Exception => e
            response_data[:error] = {:exception => e}            
        end
        puts response_data
        render :json => response_data
    end

    def login
        response_data = { :status => false, :result => {}, :error => nil }
        puts "1"
        begin
            require_params = params.permit!.require([:email_address, :password])
            puts "2"
            if require_params.present?
                user = User.user_authenticate([params[:email_address], params[:password]])
                puts "3"
                if user[:status] && user[:result].length
                    puts "4"
                    response_data[:status] = true
                    session[:user_id] = user[:result]["id"]
                    session[:first_name] = user[:result]["first_name"]
                    session[:last_name] = user[:result]["last_name"]
                else
                    puts "5"
                    response_data[:status] = false
                    response_data[:error] = "Incorrect Email / Password, please try again."
                end

            else
                puts "6"
                response_data[:result] = params
                response_data[:error] = "Please fill up the missing fields."
            end

        rescue Exception => e
            response_data[:error] = {:exception => e}            
        end
        puts response_data
        render :json => response_data
    end

    def logout
        reset_session
        redirect_to "/"
    end

    def session_exists?
        redirect_to "/wall" if session[:user_id].present?
    end
end
