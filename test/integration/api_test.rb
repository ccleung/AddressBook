require 'minitest/autorun'
require 'rest_client'
require 'json'

class APITest < MiniTest::Unit::TestCase

  def self.initialize_user
    user = User.find_or_create_by!(email: 'test@test.com') do |user|
             user.password = '12345678'
             user.password_confirmation = '12345678'
    end
  end

  def setup
    @user = APITest.initialize_user
    response = RestClient.get("https://applicationname-api-sbox02.herokuapp.com/api/v1/users", 
      {
         "Content-Type" => "application/json",
         "Authorization" => "token 4d012314b7e46008f215cdb7d120cdd7",
         "Manufacturer-Token" => "8d0693ccfe65104600e2555d5af34213"
      }
    ) 
    @data = JSON.parse response.body
  end

  def test_id_correct
    assert_equal 4, @data['id']
  end
end