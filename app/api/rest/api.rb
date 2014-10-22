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
	  	@email_address = headers['X-User-Email']
	    Rails.logger.info "Completed in #{headers}"
	    @user = User.find_by_email(@email_address)
	    if (@user.nil?)
	      error!('User does not exist', 404)
	    end
	    @contacts = @user.contacts
	  end
    end

      get do
      end

   end
end