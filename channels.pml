#include "headers.pml"

chan prepare = [MAX] of { byte, Paxos }
chan promise = [MAX] of { byte, Paxos }
chan accept  = [MAX] of { byte, Paxos }
chan learn   = [MAX] of { byte, Paxos }
