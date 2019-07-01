`include "uvm_macros.svh"

class axi_test extends uvm_test;

`uvm_component_utils(axi_test)

 axi_env env;
axi_write_seq wseq;
axi_read_seq rseq;

function new(string name="axi_test",uvm_component parent);
super.new(name,parent);

endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);

env=axi_env::type_id::create("env",this);
wseq=axi_write_seq::type_id::create("wseq");
rseq=axi_read_seq::type_id::create("rseq");
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction

task run_phase(uvm_phase phase);
 phase.raise_objection (this);
	wseq.start (env.wagt.wseqr);
	rseq.start (env.ragt.rseqr);
	
	#10 $finish;
 phase.drop_objection (this);

endtask

endclass
