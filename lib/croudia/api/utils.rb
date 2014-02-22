module Croudia
  module API
    module Utils

    private

      def get_id(id)
        case id
        when String, Integer
          id
        when Croudia::Identity
          id.id_str
        else
          raise ArgumentError, 'id is invalid'
        end
      end

      def merge_file!(params, file, key=:file)
        case file
        when Hash
          params.merge!(file)
        when File
          params[key] = file
        else
          raise ArgumentError, "#{key} must be a File"
        end
        params
      end

      def merge_query!(params, query)
        case query
        when Hash
          params.merge!(query)
        when String
          params[:q] = query
        else
          raise ArgumentError, 'Search query must be a String'
        end
        params
      end

      def merge_user!(params, user, sn_key=:screen_name, user_key=:user_id)
        case user
        when Hash
          params.merge!(user)
        when String
          params[sn_key] = user
        when Integer
          params[user_key] = user
        when Croudia::User
          params[user_key] = user.id_str
        else
          raise ArgumentError, 'user must be a String, Integer or User'
        end

        params
      end

      def merge_users!(params, users)
        user_ids = []
        screen_names = []

        users.each do |user|
          case user
          when Hash
            params.merge!(user)
          when Integer
            user_ids << user
          when String
            screen_names << user
          when Croudia::User
            user_ids << user.id_str
          else
            raise ArgumentError, 'invalid user'
          end
        end

        params[:user_id] = user_ids.join(',') unless user_ids.empty?
        params[:screen_name] = screen_names.join(',') unless screen_names.empty?
        params
      end

      def merge_text!(params, text, key=:status)
        case text
        when Hash
          params.merge!(text)
        else
          params[key] ||= text.to_s
        end

        params
      end

      def merge_id!(params, id, key=:id)
        case id
        when Hash
          params.merge!(id)
        else
          params[key] = get_id(id)
        end

        params
      end

      def objects(klass, array)
        array.map { |hash| klass.new(hash) }
      end
    end
  end
end
