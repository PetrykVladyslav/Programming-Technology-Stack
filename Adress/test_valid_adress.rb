require 'minitest/autorun'
require_relative 'valid_adress'

class TestValidIPv4 < Minitest::Test
  def test_valid_addresses
    assert_equal true, valid_ipv4?('192.168.1.1')
    assert_equal true, valid_ipv4?('0.0.0.0')
    assert_equal true, valid_ipv4?('127.0.0.1')
    assert_equal true, valid_ipv4?('255.255.255.255')
  end

  def test_invalid_addresses
    assert_equal false, valid_ipv4?('')
    assert_equal false, valid_ipv4?(nil)
    assert_equal false, valid_ipv4?('wer.tqe.wew.rio')
    assert_equal false, valid_ipv4?('123.356/223.2')
    assert_equal false, valid_ipv4?('198.51.100.0/33')
    assert_equal false, valid_ipv4?('123.356223.2')
    assert_equal false, valid_ipv4?('256.256.256.256')
    assert_equal false, valid_ipv4?('192.168.1')
    assert_equal false, valid_ipv4?('127. 0.0.1')
    assert_equal false, valid_ipv4?('192.168.01.1')
    assert_equal false, valid_ipv4?('192.168.1.300')
    assert_equal false, valid_ipv4?('192.168.1.1.1')
    assert_equal false, valid_ipv4?('192.168.one.1')
    assert_equal false, valid_ipv4?('192.168.1.a')
    assert_equal false, valid_ipv4?('280.100.92.101')
    assert_equal false, valid_ipv4?('127.0.0.0[')
    assert_equal false, valid_ipv4?('127.0.0.0/8')
    assert_equal false, valid_ipv4?('5555..555')
  end
end