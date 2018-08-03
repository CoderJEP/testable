# frozen_string_literal: true
module Models
  class User
    attr_accessor :name, :email, :password

    def initialize(name:, email:, password: '123456')
      @name = name
      @email = email
      @password = password
    end

    def to_s
      "Name: #{@name}\n" + "Email: #{@email}\n" + "Password: #{@password}\n"
    end
  end
end
