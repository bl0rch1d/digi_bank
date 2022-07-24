# frozen_string_literal: true

class BankAccountsController < ApplicationController
  before_action :authenticate_user!

  def show
  end
end
