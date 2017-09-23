all:
	spin -a paxos.pml
	gcc -DVECTORSZ=2048 -o pan pan.c
	./pan

clean:
	rm -rf pan* *.trail
