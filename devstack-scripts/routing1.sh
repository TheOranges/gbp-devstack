#neutron security-group-create web_sg
#neutron security-group-rule-create web_sg --direction ingress --ethertype IPv4
#neutron security-group-rule-create web_sg --direction egress --ethertype IPv4
neutron security-group-create client_sg
neutron security-group-rule-create client_sg --direction egress --ethertype IPv4
neutron security-group-rule-create client_sg --direction ingress --ethertype IPv4


neutron net-create net1
neutron subnet-create net1 10.1.1.0/24 --name sub1 --gateway 10.1.1.1
neutron net-create net2
neutron subnet-create net2 20.1.1.0/24 --name sub2 --gateway 20.1.1.1

neutron router-create r1
neutron router-interface-add r1 sub1
neutron router-interface-add r1 sub2

novaboot.sh net1 client_sg 1 devstack-control
#novaboot.sh net1 web_sg 1 devstack-control

novaboot.sh net2 client_sg 2 devstack-control
#novaboot.sh net2 web_sg 2

#novaboot.sh net1 client_sg 3 devstack-compute-1
#novaboot.sh net2 client_sg 4 devstack-compute-1

nova list
