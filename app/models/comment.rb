class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :message
    include :: QueryHelper

    def self.comment_create(params)
        response_data = { :status => false, :result => {}, :error => nil }
        
        begin
            comment_post = query_insert([
                "INSERT INTO comments (user_id,message_id, comment, created_at, updated_at)
                VALUES (?, ?, ?, NOW(), NOW());", params[:user_id], params[:message_id], params[:comment]
            ])

            response_data[:result] = comment_post
            response_data[:status] = true

        rescue Exception => e
            response_data[:error] = e
        end

        return response_data
    end

    def self.comment_delete(params)
        response_data = { :status => false, :result => {}, :error => nil }
        
        begin
            comment_del = query_delete([
                "DELETE FROM comments where id = ? and user_id = ?", params[:comment_id], params[:comment_user_id]
            ])

            response_data[:result] = comment_del
            response_data[:status] = true

        rescue Exception => e
            response_data[:error] = e
        end

        return response_data
    end
end
