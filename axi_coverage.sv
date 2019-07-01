class axi_coverage extends uvm_subscriber #(axi_transaction);

	uvm_analysis_imp #(axi_transaction,axi_coverage) coverage_collected_export;
	`uvm_component_utils (axi_coverage)
	axi_transaction packet;

	covergroup mycov;

	input1: coverpoint packet.awvalid {
		bins input1zero[] = {0,1};

	}
	input2: coverpoint packet.wvalid {
		bins input2zero[] = {0,1};

	}
	input3: coverpoint packet.wdata {option.auto_bin_max=15;}
	input4: coverpoint packet.awaddr {option.auto_bin_max=5;}
//	input5: coverpoint packet.awprot {option.auto_bin_max=5;}

	input6: coverpoint packet.bready {
		bins input1zero[] = {0,1};

	}
//	input7: coverpoint packet.bresp {
//		bins input1zero[] = {2'b00,2'b01,2'b10,2'b11};

//	}
	input8: coverpoint packet.rready {
		bins input1zero[] = {0,1};

	}


	endgroup
	
	function new (string name = "axi_coverage",uvm_component parent);
		super.new (name,parent);
		mycov = new ();
	endfunction

	virtual function void build_phase (uvm_phase phase);
	coverage_collected_export = new ("coverage_collected_export",this);
	packet  = axi_transaction::type_id::create("packet",this);
	endfunction

	function void write(axi_transaction t);
	packet = t;
	mycov.sample();
	`uvm_info("COVSB", $sformatf("@time %0t, Coverage = %3.2f percent\n", $time, mycov.get_coverage()), UVM_LOW)
	endfunction
	
endclass


