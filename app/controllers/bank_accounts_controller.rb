# frozen_string_literal: true

class BankAccountsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def show
    operation = ::DigiBank::BankAccount::Operation::Show.call(current_user: current_user, params: params)

    @operation_result = operation[:result]
  end
end
