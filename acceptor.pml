#include "headers.pml"
#include "utils.pml"

proctype Acceptor(byte id) {
    Paxos paxos;
    byte rnd, vrnd, val;
end:
    do
    :: prepare?eval(id),paxos -> print_paxos(paxos);
        if
        :: paxos.msgtype == PREPARE -> atomic {
            if
            :: paxos.rnd > rnd -> paxos.msgtype = PROMISE;
                                  paxos.acptid = id;
                                  rnd = paxos.rnd;
                                  if
                                  :: vrnd > 0 ->  paxos.vrnd = vrnd;
                                                  paxos.value = val;
                                  :: else
                                  fi;
                                  promise!rnd,paxos;
            :: else
            fi
          }
        fi
    :: accept?eval(id),paxos -> print_paxos(paxos);
        if
        :: paxos.msgtype == ACCEPT ->
            if
            :: paxos.rnd >= rnd ->  atomic {
                                    printf("Accept Value %d in round %d\n", val, rnd);
                                    rnd  = paxos.rnd;
                                    vrnd = paxos.rnd;
                                    val  = paxos.value;
                                    paxos.acptid = id;
                                    paxos.msgtype = ACCEPTED;
                                    learn!rnd,paxos;
                                  }
            :: else
            fi
        fi
    od
}
