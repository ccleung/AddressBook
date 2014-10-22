require 'grape'

module Rest
  class API < Grape::API
  	prefix "api"
  	version 'v1'
  	format :json

  	helpers do
      def current_user_email
        @current_user_email ||= headers['X-User-Email']
      end

      def verify_authenticated!
        error!('401 Unauthorized', 401) unless current_user_email
      end
    end

  	resource :user do
      get 'contacts' do
        verify_authenticated!
  	    #Rails.logger.info "Completed in #{headers}"
  	    @user = User.find_by_email(@current_user_email)
  	    if (@user.nil?)
  	      error!('User does not exist', 404)
  	    end
        # todo hide user id ?
  	    @contacts = @user.contacts
      end

      get do
        verify_authenticated!
        @user = User.find_by_email(@current_user_email)
        if (@user.nil?)
          error!('User does not exist', 404)
        end
        @user
      end

    end

   end
end