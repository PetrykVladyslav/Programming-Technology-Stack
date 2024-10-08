def valid_ipv4?(ip)
  return false if ip.nil? || ip.strip.empty?

  ip_parts = ip.split('/')
  return false if ip_parts.length > 2

  ip_address = ip_parts[0]
  subnet_mask = ip_parts[1] if ip_parts.length == 2

  elements = ip_address.split('.')
  return false if elements.length != 4

  elements.each do |element|
    element.each_char do |char|
      return false unless char >= '0' && char <= '9'
    end

    number = element.to_i

    return false if number < 0 || number > 255

    return false if element.length > 1 && element[0] == '0'
  end

  if subnet_mask
    puts "Адреса містить маску підмережі, а за умовою адреса має бути у канонічному вигляді (без маски)."
    return false
  end

  true
end

def check_user_input
  puts "Введіть IPv4-адресу для перевірки:"
  ip_address = gets.chomp

  if valid_ipv4?(ip_address)
    puts "#{ip_address} є коректною IPv4-адресою."
  else
    puts "#{ip_address} не є коректною IPv4-адресою."
  end
end

check_user_input