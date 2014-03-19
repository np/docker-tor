FROM d.ail/arch

RUN pacman --noconfirm -Syu tor &&\
    pacman -D --asdeps `pacman -Qqet` &&\
    pacman -D --asexplicit tor pacman &&\
    pacman --noconfirm -Ru `pacman -Qqd` &&\
    pacman --noconfirm -Scc &&\
    chown tor:tor /var/lib/tor

USER     tor
ENV HOME /var/lib/tor
WORKDIR  /var/lib/tor

ADD start.sh /start.sh
CMD /start.sh

EXPOSE 9001 9050
