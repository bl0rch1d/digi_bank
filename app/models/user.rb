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
class User < ApplicationRecord
  STARTER_BALANCE = 10_000_00
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_one :bank_account, dependent: :destroy

  after_create :create_bank_account!
end
