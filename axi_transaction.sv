class axi_transaction extends uvm_sequence_item;

//`uvm_object_utils(axi_transaction)


rand logic awvalid;
     logic awready;
rand logic [31:0] awaddr;
rand logic [2:0] awprot;

//////////write data channel///////////

rand logic wvalid;
     logic wready;
rand logic [31:0] wdata;
rand logic [3:0] wstrb;

/////////write rseponse channel////

     logic bvalid;
rand logic bready;
     logic [1:0]bresp;

/////////////////Read address channel/////////
rand logic arvalid;
     logic arready;
rand logic [31:0] araddr;
rand logic [2:0]  arprot;

/////////Read data or response  channel/////////
rand logic rvalid;
rand logic rready;
     logic [31:0] rdata;
     logic [1:0] rresp;

`uvm_object_utils_begin(axi_transaction)
`uvm_field_int(awaddr,UVM_ALL_ON)
`uvm_field_int(awvalid,UVM_ALL_ON)
`uvm_field_int(awready,UVM_ALL_ON)
`uvm_field_int(awprot,UVM_ALL_ON)
`uvm_field_int(wready,UVM_ALL_ON)
`uvm_field_int(wdata,UVM_ALL_ON)
`uvm_field_int(wvalid,UVM_ALL_ON)
`uvm_field_int(wstrb,UVM_ALL_ON)
`uvm_field_int(bvalid,UVM_ALL_ON)
`uvm_field_int(bready,UVM_ALL_ON)
`uvm_field_int(bresp,UVM_ALL_ON)
`uvm_field_int(araddr,UVM_ALL_ON)
`uvm_field_int(arvalid,UVM_ALL_ON)
`uvm_field_int(arready,UVM_ALL_ON)
`uvm_field_int(arprot,UVM_ALL_ON)
`uvm_field_int(rvalid,UVM_ALL_ON)
`uvm_field_int(rready,UVM_ALL_ON)
`uvm_field_int(rdata,UVM_ALL_ON)
`uvm_field_int(rresp,UVM_ALL_ON)

`uvm_object_utils_end

constraint w_strb{wstrb==4'b1111;}
constraint aprotec{awprot==3'b001;}
constraint aprotect{arprot==3'b001;}

constraint adder_eq{awaddr==araddr;}
//constraint aprotect{awprot==arprot;}
constraint last_two_bits{awaddr[1:0]==2'b00;}

function new(string name="axi_transaction");
super.new(name);
endfunction
endclass















