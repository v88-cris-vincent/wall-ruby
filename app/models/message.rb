class Message < ApplicationRecord
    belongs_to :user
    has_many :comments
    include :: QueryHelper

    def self.organized_content
        response_data = { :status => false, :result => {}, :error => nil }
           
        begin
            content = query_select_all([
                "SELECT
                    m.id AS message_id,
                    m.user_id AS user_id,
                    concat(u.first_name, ' ',u.last_name) AS message_sender,
                    m.message AS message,
                    m.created_at AS created_at,
                        (SELECT
                            json_objectagg(
                                c.id,
                                json_object(
                                    'user_id', c.user_id,
                                    'comment_sender', concat(u2.first_name, ' ',u2.last_name),
                                    'comment', c.comment,
                                    'created_at', c.created_at
                                )
                            )
                            FROM comments c
                            LEFT JOIN users u2 on u2.id = c.user_id
                            WHERE m.id = c.message_id
                            ORDER BY c.created_at ASC
                        ) AS comment
                    FROM messages m
                    JOIN users u on u.id = m.user_id
                    GROUP BY m.id
                    ORDER BY m.created_at DESC;"
            ])

            if !content.nil?
                response_data[:result] = content
                response_data[:status] = true
            end

        rescue Exception => e
            response_data[:error] = e
        end

        return response_data
    end

    def self.message_create(params)
        response_data = { :status => false, :result => {}, :error => nil }
           
        begin
            message_post = query_insert([
                "INSERT INTO messages (user_id, message, created_at, updated_at)
                VALUES (?, ?, NOW(), NOW());", params[:user_id], params[:message]
            ])

            response_data[:result] = message_post
            response_data[:status] = true

        rescue Exception => e
            response_data[:error] = e
        end

        return response_data
    end

    def self.message_delete(params)
        response_data = { :status => false, :result => {}, :error => nil }
           
        begin
            message_del = query_delete([
                "DELETE FROM messages where id = ? and user_id = ?", params[:message_id], params[:message_user_id]
            ])

            response_data[:result] = message_del
            response_data[:status] = true

        rescue Exception => e
            response_data[:error] = e
        end

        return response_data
    end
end
