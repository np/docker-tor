FROM d.ail/arch

RUN pacman --noconfirm -Syu tor &&\
    pacman -D --asdeps `pacman -Qqet` &&\
    pacman -D --asexplicit tor pacman &&\
    pacman --noconfirm -Ru `pacman -Qqd` &&\
    pacman --noconfirm -Scc

ADD torrc /etc/torrc

# Generate a random nickname for the relay
RUN echo "Nickname xndocker$(head -c 16 /dev/random  | sha1sum | cut -c1-10)" >>/etc/torrc  &&\
    echo "ContactInfo $CONTACT_INFO" >>/etc/torrc &&\
    chown tor:tor /var/lib/tor

CMD /usr/bin/tor

USER tor

EXPOSE 9001 9050
