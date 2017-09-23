#include "headers.pml"
#include "utils.pml"
#include "channels.pml"
#include "proposer.pml"
#include "acceptor.pml"
#include "learner.pml"

init {
  atomic {
    byte i;

    for (i:0.. ACCEPTORS) {
      run Acceptor(i);
    }

    for (i:1.. PROPOSERS) {
      run Proposer(i);
    }

    run Learner();
  }
}
