# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string           not null
#  encrypted_password  :string           not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { SecureRandom.hex(Devise.password_length.min) }
  end
end
