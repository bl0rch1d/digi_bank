# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id         :bigint           not null, primary key
#  from_id    :bigint           not null
#  to_id      :bigint           not null
#  amount     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
