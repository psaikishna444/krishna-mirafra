class axi_w_agent extends uvm_agent;

uvm_active_passive_enum is_active=UVM_ACTIVE;
`uvm_component_utils(axi_w_agent)


axi_write_monitor wmon;
axi_w_driver wdrv;
axi_write_sequencer wseqr;

function new(string name="axi_w_agent",uvm_component parent);
super.new(name,parent);
endfunction

//=============BUILD PHASE==========//

function void build_phase (uvm_phase phase);
	super.build_phase(phase);

	if(is_active==UVM_ACTIVE)

	begin
		wseqr=axi_write_sequencer::type_id::create("wseqr",this);
		wdrv=axi_w_driver::type_id::create("wdrv",this);
	end
		wmon=axi_write_monitor::type_id::create("wmon",this);

//if(!uvm_config_db#(virtual fifo_interface)::get(this,"","vif",vif))

endfunction

function void connect_phase (uvm_phase phase);
	
	if(is_active==UVM_ACTIVE)
	wdrv.seq_item_port.connect(wseqr.seq_item_export);
endfunction

function void start_of_simulation_phase (uvm_phase phase);

	`uvm_info(get_type_name(),{"start of simulation phase for ",get_full_name()},UVM_LOW)

endfunction

endclass







