# frozen_string_literal: true

shared_examples_for 'invalid contract examples' do
  it 'returns invalid contract' do
    expect(contract).not_to be_valid
  end

  it 'returns an error' do
    contract.validate
    expect(contract.errors.messages).to eq expected_messages
  end
end
