class axi_write_sequencer extends uvm_sequencer#(axi_transaction);

`uvm_component_utils(axi_write_sequencer)

function new(string name="axi_write_sequencer",uvm_component parent);
super.new(name,parent);
endfunction

endclass
