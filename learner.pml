#include "headers.pml"
#include "utils.pml"

proctype Learner() {
  Paxos paxos;
  byte rnd, cur_rnd, cur_val;
  bit quorum[3];
  bit chosen;
  byte chosen_value;
  int i;
end:
  do
  :: learn?rnd,paxos -> atomic {
      if
      :: rnd > cur_rnd ->
          assert(rnd == paxos.rnd);
          printf("Learned first ACK value %d in round %d\n", paxos.value, paxos.rnd);
          /* Reset */
          chosen = 0;
          quorum[0] = 0;
          quorum[1] = 0;
          quorum[2] = 0;
          /* Ack */
          cur_rnd = rnd;
          cur_val = paxos.value;
          quorum[paxos.acptid] = 1;
      :: rnd == cur_rnd ->
          printf("Learned second ACK value %d in round %d\n", paxos.value, paxos.rnd);
          if
          :: quorum[paxos.acptid] == 0 ->
              quorum[paxos.acptid] = 1;
              assert(cur_val == paxos.value);
          :: else
          fi;
          if
          :: (quorum[0] + quorum[1] + quorum[2]) >= MAJORITY && chosen == 0 ->
              printf("Chosen value %d\n", cur_val);
              if
              :: chosen_value == 0 ->
                chosen = 1;
                chosen_value = cur_val;
              :: else -> assert(chosen_value == cur_val);
              fi
          :: else
          fi
      :: else
      fi
    }
  od
}
