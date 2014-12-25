require 'minitest/autorun'
require 'rest_client'
require 'json'
require 'test_helper'

# TODO: Teste every endpoint to ensure email is required (to be moved to auth token for better security)
class APITest < MiniTest::Unit::TestCase

  def self.initialize_user
    user = User.find_or_create_by!(email: 'test@test.com') do |user|
             user.password = '12345678'
             user.password_confirmation = '12345678'
    end
  end

  def setup
    @user = APITest.initialize_user
    # TODO: move this into a config
    @url_base = "http://localhost:3000"
    @contact = nil
  end

  def test_get_contacts_without_email
    url = @url_base + "/api/v1/user/contacts"
      @response = RestClient.get(url, 
      {
         "Content-Type" => "application/json",
      }
    ) 
    assert_equal 401, @response.code
  end

  # TODO: test different json request body
  # TODO: test invalid request body types, e.g., bad phone number, bad phone type, address...
  def test_post_contact_for_user
    url = @url_base + "/api/v1/user/contact/new"
    phone_numbers = Array.new(2,Hash.new)
      @response = RestClient.post(url, 
        {
          :contact => {
              :first_name => "aaaaaa", 
              :last_name => "alskjdalksd"
          },

          :phone_number => [{:phone_type => "mobile",:phone_number => "+1-321-3211"}, {:phone_type => "home",:phone_number => "+1-111-3211"}]

          #:addresses => [
          #    {
          #      :street => "sss",
          #      :city => "new york",
          #      :country => "CA",
          #      :region => "BC",
          #      :postal_code => "M5R 1K2"
          #    }]
        },
      {
         "Content-Type" => "application/json",
         "X-User-Email" => "test@test.com"
      }
    ) 
    assert assert_equal 201, @response.code
  end


  # helper to share code between tests for now
  # TODO: validate response data, e.g., list of contacts
  def get_contacts_request
    url = @url_base + "/api/v1/user/contacts"
      @response = RestClient.get(url, 
      {
         "Content-Type" => "application/json",
         "X-User-Email" => "test@test.com"
      }
    ) 
    @data = JSON.parse @response.body
    @contact = @data.first
  end

  def test_get_contacts_with_valid_email
    get_contacts_request
    assert_equal 200, @response.code
    refute_nil @contact
  end

  # TODO: get the id from the get request, of the previous test some how
  # TODO: test invalid contact id, contact id user doesn't own
  def test_delete_contact_with_valid_email
    get_contacts_request
    url = @url_base + "/api/v1/user/contact/" + @contact['id'].to_s
      @response = RestClient.delete(url, 
      {
         "Content-Type" => "application/json",
         "X-User-Email" => "test@test.com"
      }
    )
    assert_equal 200, @response.code 
  end

  # TODO: test invalid inputs (e.g., invalid contact id, 
  #      id user doesn't own, blank first and last name)
  # TODO: validate response body, returns all fields of the contact id
  def test_edit_contact_with_valid_email
    get_contacts_request
    url = @url_base + "/api/v1/user/contact/" + @contact['id'].to_s
    @response = RestClient.put(url, 
          {
          :contact => {
              :first_name => "edited name", 
              :last_name => "edited last name"
            }
          },
      {
         "Content-Type" => "application/json",
         "X-User-Email" => "test@test.com"
      })
     assert_equal 200, @response.code
  end
end