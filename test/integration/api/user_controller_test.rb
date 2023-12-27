require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
    def test_login
        assert_equal 200, status
      end
end