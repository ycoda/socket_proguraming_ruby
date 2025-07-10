require 'socket'

socket = UDPSocket.open()
sock_addr = Socket.sockaddr_in(9000, '127.0.0.1')

print("名前を入力してください\n")
user_name = gets.chomp.encode("UTF-8")

loop do
    print "送信 > "
    input = gets&.chomp
    break if input.nil? || input == "exit"
    message = "[#{user_name}] #{input}"
    socket.send(message.encode("UTF-8"), 0, sock_addr)

    puts "受信待ち..."
    msg, = socket.recvfrom(4096)
    msg = msg.force_encoding("UTF-8")
    puts "[受信] #{msg}"
end

socket.close