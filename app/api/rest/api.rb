require 'grape'

module Rest
  class API < Grape::API
  	prefix "api"
  	version 'v1'
  	format :json

  	helpers do
      def current_user_email
        @current_user_email ||= headers['X-User-Email']
        @user = User.find_by_email(@current_user_email)
        !@user.nil?
      end

      # if you aren't in our system then you can't do anything
      def verify_authenticated!
        error!('401 Unauthorized', 401) unless current_user_email
      end
    end

    before do
      verify_authenticated!
    end

  	resource :user do
      get 'contacts' do
        # todo hide user id ?
  	    @contacts = @user.contacts
      end

      get do
        verify_authenticated!
        @user
      end

      # TODO: show which fields were invalid. Add requires parameters
      post 'contact/new' do
        @contact = Contact.new(params[:contact])

        @phone_numbers = params[:phone_numbers]
        @phone_numbers.each do |phone_number|
          @phone_number = PhoneNumber.new
          @phone_number.phone_type = phone_number.phone_type
          @phone_number.number = phone_number.number
          @contact.phone_numbers << @phone_number
        end

        @addresses = params[:addresses]
        @addresses.each do |address|
          @address = Address.new
          @address.street = address.street
          @address.city = address.city
          @address.country = address.country
          @address.region = address.region
          @address.postal_code = address.postal_code
          @contact.addresses << @address
        end

        @user.contacts << @contact
        if (!@user.save)
          error!('Invalid request data', 400)
        end
        @contact
      end

      put 'contact/:id' do
        Rails.logger.info "  Parameters: #{params[:id]}"
        @contact = Contact.find(params[:id])
        if (@contact.nil?)
          error!('Contact does not exist', 404)
        end
        if (@contact.user_id == @user.id)
          error!('Cannot edit', 403)
        else
          error!('Cannot edit contacts that are not yours', 403)
        end
      end

      delete 'contact/:id' do
         Rails.logger.info "  Parameters: #{params[:id]}"
        @contact = Contact.find(params[:id])
        if (@contact.nil?)
          error!('Contact does not exist', 404)
        end
        if (@contact.user_id == @user.id)
          Contact.destroy(params[:id])
        else
          error!('Cannot delete contacts that are not yours', 403)
        end
      end
    end

   end
end