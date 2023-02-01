class User < ApplicationRecord
    include :: QueryHelper
    validates :password, :email, presence: true

    def self.user_get(params)
        response_data = { :status => false, :result => {}, :error => nil }
           
        begin
            user_get_query = query_select_one([
                "SELECT * FROM users WHERE email = ?;", params[:email_address]
            ])

            if user_get_query.length
                response_data[:result] = user_get_query
                response_data[:status] = true
            end

        rescue Exception => e
            response_data[:error] = e
        end

        return response_data
    end

    def self.user_create(params)
        response_data = { :status => false, :result => {}, :error => nil }
   
        begin
            user_insert = query_insert([
                "INSERT INTO users (first_name, last_name, email, password, created_at, updated_at)
                VALUE (?, ?, ?, ?, NOW(), NOW());", params[:first_name], params[:last_name], params[:email_address], params[:password]
            ])

                response_data[:result] = User.last
                response_data[:status] = true
            
        rescue Exception => e
            response_data[:error] = e
        end

        return response_data
    end

    def self.user_authenticate(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            user_get_query = query_select_one([
                "SELECT id, first_name, last_name FROM users WHERE email = ? AND password = ?;", params[0], params[1]
            ])

            unless user_get_query.nil?
                response_data[:result] = user_get_query
                response_data[:status] = true
            end

        rescue Exception => e
            response_data[:error] = e
        end

        return response_data             
    end
end
