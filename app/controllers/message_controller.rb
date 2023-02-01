class MessageController < ApplicationController
    def index
        begin
        @messages = Message.organized_content

        rescue Exception => e
            @messages[:error] = {:exception => e }
        end
    end

    def message_post
        response_data = { :status => false, :result => {}, :error => nil }
       
        begin
            require_params = params.permit!.require([:user_id, :message])
    
            if require_params.present?
                post = Message.message_create(params)
                response_data[:status] = true
                response_data[:result] = post[:result]
            else
                response_data[:error] = "Error encountered."
            end

        rescue Exception => e
            response_data[:error] = {:exception => e}
        end
       
        render :json => response_data
    end

    def message_delete
        response_data = { :status => false, :result => {}, :error => nil }
        
        begin
            require_params = params.permit!.require([:message_id, :message_user_id])

            if require_params.present?
                message_del = Message.message_delete(params)
                response_data[:status] = true
                response_data[:result] = message_del[:result]
            else
                response_data[:error] = "Error encountered."
            end

        rescue Exception => e
            response_data[:error] = {:exception => e}
        end
        
        render :json => response_data
    end

end
