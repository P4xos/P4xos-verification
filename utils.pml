#ifndef _UTILS_
#define _UTILS_

inline init_ether(ether) {
    d_step {
        ether.srcAddr.addr[0] = 23;
        ether.srcAddr.addr[1] = 45;
        ether.srcAddr.addr[2] = 22;
        ether.srcAddr.addr[3] = 33;
        ether.srcAddr.addr[4] = 44;
        ether.srcAddr.addr[5] = 55;
        ether.dstAddr.addr[0] = 99;
        ether.dstAddr.addr[1] = 88;
        ether.dstAddr.addr[2] = 77;
        ether.dstAddr.addr[3] = 66;
        ether.dstAddr.addr[4] = 55;
        ether.dstAddr.addr[5] = 44;
        ether.etherType = IP_ETHERTYPE;
    }
}

inline init_ip(ip) {
    d_step {
        ip.srcAddr.addr[0] = 192;
        ip.srcAddr.addr[1] = 168;
        ip.srcAddr.addr[2] = 1;
        ip.srcAddr.addr[3] = 10;
        ip.dstAddr.addr[0] = 192;
        ip.dstAddr.addr[1] = 168;
        ip.dstAddr.addr[2] = 1;
        ip.dstAddr.addr[3] = 249;
    }
}

inline init_udp(udp) {
    d_step {
        udp.srcPort = 12345;
        udp.dstPort = 3495;
        udp.length  = 92;
        udp.checksum = 20342;
    }
}

inline init_paxos(paxos, pxtype, prnd, pval) {
    d_step {
        paxos.msgtype = pxtype;
        paxos.rnd = prnd;
        paxos.value = pval;
    }
}

inline print_ethernet(ether) {
    printf("%x:%x:%x:%x:%x:%x -> %x:%x:%x:%x:%x:%x, [0x%x]\n",
        ether.srcAddr.addr[0],
        ether.srcAddr.addr[1],
        ether.srcAddr.addr[2],
        ether.srcAddr.addr[3],
        ether.srcAddr.addr[4],
        ether.srcAddr.addr[5],
        ether.dstAddr.addr[0],
        ether.dstAddr.addr[1],
        ether.dstAddr.addr[2],
        ether.dstAddr.addr[3],
        ether.dstAddr.addr[4],
        ether.dstAddr.addr[5],
        ether.etherType
    )
}

inline print_ipv4(ipv4) {
    printf("%d.%d.%d.%d -> %d.%d.%d.%d\n",
    ipv4.srcAddr.addr[0],
    ipv4.srcAddr.addr[1],
    ipv4.srcAddr.addr[2],
    ipv4.srcAddr.addr[3],
    ipv4.dstAddr.addr[0],
    ipv4.dstAddr.addr[1],
    ipv4.dstAddr.addr[2],
    ipv4.dstAddr.addr[3]
    )
}

inline print_udp(udp) {
    printf("%d -> %d\n", udp.srcPort, udp.dstPort);
}

inline print_paxos(paxos) {
    printf("Msgtype: %d, round %d, value %d\n", paxos.msgtype, paxos.rnd, paxos.value);
}

inline dump(eth, ipv4, udp, paxos) {
    d_step {
        print_ethernet(eth);
        print_ipv4(ipv4);
        print_udp(udp);
        print_paxos(paxos);
    }
}

#endif
