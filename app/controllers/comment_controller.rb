class CommentController < ApplicationController

    def comment_post
        response_data = { :status => false, :result => {}, :error => nil }
       
        begin
            require_params = params.permit!.require([:user_id, :comment])
    
            if require_params.present?
                post = Comment.comment_create(params)
                response_data[:status] = true
                response_data[:result] = post[:result]
            else
                response_data[:error] = "Error encountered."
            end

        rescue Exception => e
            response_data[:error] = {:exception => e}
        end
        puts response_data
        render :json => response_data
    end

    def comment_delete
        response_data = { :status => false, :result => {}, :error => nil }
        
        begin
            require_params = params.permit!.require([:comment_id, :comment_user_id])

            if require_params.present?
                comment_del = Comment.comment_delete(params)
                response_data[:status] = true
                response_data[:result] = comment_del[:result]
            else
                response_data[:error] = "Error encountered."
            end

        rescue Exception => e
            response_data[:error] = {:exception => e}
        end
        
        render :json => response_data
    end
end
