module Croudia
  module API
    module Utils

    private

      def get_status_id(status_id)
        case status_id
        when String, Integer
        when Croudia::Status
          status_id = status_id.id_str
        else
          raise ArgumentError, 'status_id is invalid'
        end

        status_id
      end

      def merge_user!(params, user)
        case user
        when Hash
          params.merge!(user)
        when String
          params[:screen_name] = user
        when Integer
          params[:user_id] = user
        when Croudia::User
          params[:user_id] = user.id_str
        else
          raise ArgumentError, 'user must be a String, Integer or User'
        end

        params
      end

      def objectify_statuses(statuses)
        statuses.map { |status| Croudia::Status.new(status) }
      end
    end
  end
end
