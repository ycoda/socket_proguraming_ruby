require 'socket'

socket = UDPSocket.open()
socket.bind("0.0.0.0", 9000)

loop do
    msg, addr_info = socket.recvfrom(4096)
    port = addr_info[1]
    ip   = addr_info[3]
    msg = msg.force_encoding("UTF-8")
    puts "[受信] #{msg}"

    print "返信 > "
    reply = gets&.chomp
    break if reply.nil? || reply == "exit"
    sock_addr = Socket.sockaddr_in(port, ip)
    socket.send(reply.encode("UTF-8"), 0, sock_addr)
end

socket.close
