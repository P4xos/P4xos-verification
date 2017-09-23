#ifndef _HEADERS_
#define _HEADERS_

mtype = { ACCEPTED, ACCEPT, PROMISE, PREPARE }
#define PROPOSERS 2
#define ACCEPTORS 3
#define MAJORITY (ACCEPTORS/2) + 1
#define MAX PROPOSERS*ACCEPTORS

#define IP_ETHERTYPE 2048

typedef MacAddress {
    byte addr[6];
}

typedef IPAddress {
    byte addr[4];
}

typedef Ethernet {
    MacAddress  dstAddr;
    MacAddress  srcAddr;
    short       etherType;
}

typedef IPv4 {
    byte    version_ihl;
    byte    diffserv;
    short   totalLen;
    short   identification;
    short   flags_fragOffset;
    byte    ttl;
    byte    protocol;
    short   checksum;
    IPAddress srcAddr;
    IPAddress dstAddr;
}

typedef UDP {
    short   srcPort;
    short   dstPort;
    short   length;
    short   checksum;
}

typedef Paxos {
    mtype msgtype;
    byte inst;
    byte rnd;
    byte vrnd;
    byte acptid;
    byte value;
}

typedef Metadata {
    bit drop;
    byte rnd;
    byte ack_count;
    byte ack_acceptors;
}

#endif
