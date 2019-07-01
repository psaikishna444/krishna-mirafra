class axi_r_agent extends uvm_agent;

uvm_active_passive_enum is_active=UVM_ACTIVE;
`uvm_component_utils(axi_r_agent)

axi_r_monitor rmon;
axi_r_driver rdrv;
axi_read_sequencer rseqr;

function new(string name ="axi_r_agent",uvm_component parent);
super.new(name,parent);
endfunction

//=============BUILD PHASE==========//

function void build_phase (uvm_phase phase);
	super.build_phase(phase);

	if(is_active==UVM_ACTIVE)

	begin
		rseqr=axi_read_sequencer::type_id::create("rseqr",this);
		rdrv=axi_r_driver::type_id::create("rdrv",this);
	end
		rmon=axi_r_monitor::type_id::create("rmon",this);

//if(!uvm_config_db#(virtual fifo_interface)::get(this,"","vif",vif))

endfunction



function void connect_phase (uvm_phase phase);
	
	if(is_active==UVM_ACTIVE)
	rdrv.seq_item_port.connect(rseqr.seq_item_export);
endfunction

function void start_of_simulation_phase (uvm_phase phase);

	`uvm_info(get_type_name(),{"start of simulation phase for ",get_full_name()},UVM_LOW)

endfunction

endclass






