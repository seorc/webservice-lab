require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase

  test 'the credit card user name must have at least 10 chars' do
    cc = CreditCard.new owner_name: '123456789'

    refute cc.valid?
    assert_match /too short/, cc.errors.get(:owner_name).join('|')

    cc.owner_name += '0'
    cc.valid?
    refute_match /too short/, (cc.errors.get(:owner_name) || []).join('|')

  end

  test 'the credit card BIN is validated to be 6 chars long' do
    cc = CreditCard.new bin: '66666'
    refute cc.valid?
    assert_match /wrong length/,  cc.errors.get(:bin).join('|')

    cc.bin += '6'
    cc.valid?
    refute_match /wrong length/, (cc.errors.get(:bin) || []).join('|')
  end

  test 'last_four validates to have exactly 4 chars' do
    cc = CreditCard.new last_four: '44444'
    refute cc.valid?
    assert_match /wrong length/,  cc.errors.get(:last_four).join('|')

    cc.last_four = '4444'
    cc.valid?
    refute_match /wrong length/, (cc.errors.get(:last_four) || []).join('|')
  end

  test 'last_four and bin are validated to be a sequence of digits' do
    cc = CreditCard.new last_four: '6633.1', bin: 'bad123'
    refute cc.valid?
    assert_match /not a number/, cc.errors.get(:bin).join('|')
    assert_match /must be an integer/, cc.errors.get(:last_four).join('|')
  end

  test 'scheme must be one of the accepted values' do
    cc = CreditCard.new scheme: 'MLM'
    refute cc.valid?
    assert_match /not included/, cc.errors.get(:scheme).join('|')
  end

  test 'brand must be one of the accepted values' do
    cc = CreditCard.new brand: 'BADBRAND'
    refute cc.valid?
    assert_match /not included/, cc.errors.get(:brand).join('|')
  end

  test 'all attributes are required' do
    cc = CreditCard.new
    refute cc.valid?
    fields = CreditCard.fields.keys.map &:to_sym
    fields.each do |fld|
      next if %i(_id created_at updated_at).include?(fld)
      assert_match /can't be blank/, (cc.errors.get(fld) || []).join('|'), "failed for #{fld}"
    end
  end

  test 'the card is invalid if it is expired' do
    skip 'todo'
  end

  test 'bin is calculated from number' do
    skip 'todo'
  end

  test 'last_four is calculated from number' do
    skip 'todo'
  end

  test 'number is never persisted' do
    skip 'todo'
  end

  test 'cvc is never persisted' do
    skip 'todo'
  end

  test 'expiration_date has a valid format' do
    skip 'todo'
  end
end
