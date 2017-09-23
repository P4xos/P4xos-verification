#include "headers.pml"
#include "utils.pml"

inline broadcast(channel, paxos) {
  for (i:0.. ACCEPTORS-1) {
    channel!i,paxos;
  }
}

proctype Proposer(byte my_rnd) {
    Paxos paxos;
    init_paxos(paxos, PREPARE, my_rnd, 0);
    byte hr, hval;
    bit quorum[3];
    bit sent_accept;
    int i;
    broadcast(prepare, paxos)
end:
    do
    :: promise?eval(my_rnd),paxos -> atomic {
        assert(my_rnd == paxos.rnd);
        if
        :: quorum[paxos.acptid] == 0 ->
            quorum[paxos.acptid] = 1;
            if
            :: (paxos.vrnd > hr) -> hr = paxos.vrnd;
                                    hval = paxos.value;
            :: else
            fi;
        :: else
        fi;

        if
        :: (quorum[0] + quorum[1] + quorum[2]) >= MAJORITY && sent_accept == 0 ->
              sent_accept = 1;
              if
              :: hr > 0 -> paxos.value = hval;
              :: else -> hval = my_rnd; paxos.value = hval;
              fi;
              paxos.msgtype = ACCEPT;
              broadcast(accept, paxos)
        :: else
        fi
      }
    od
}
