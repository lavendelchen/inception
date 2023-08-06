FROM debian:bullseye

#ENTRYPOINT musn’t be started with a command running an infinite
#loope
RUN apt update && apt install mariadb-server -y


#  - WordPress database in one volume
#      - 2 users, one of them admin
#      - admin's username shouldn't contain admin or administrator