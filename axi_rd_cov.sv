class axi_rd_cov extends uvm_subscriber #(axi_transaction);

	uvm_analysis_imp #(axi_transaction,axi_rd_cov) coverage_collected_export1;
	`uvm_component_utils (axi_rd_cov)
	axi_transaction packet1;

	covergroup rd_mycov;

	input1: coverpoint packet1.arvalid {
		bins input1zero[] = {0,1};

	}
	input2: coverpoint packet1.rvalid {
		bins input2zero[] = {0,1};

	}
	input3: coverpoint packet1.bvalid {
		bins input2zero[] = {0,1};
			}
	input4: coverpoint packet1.rdata {option.auto_bin_max=15;}
	input5: coverpoint packet1.araddr {option.auto_bin_max=5;}
//	input6: coverpoint packet1.arprot {option.auto_bin_max=5;}

	input7: coverpoint packet1.arready {
		bins input1zero[] = {0,1};
		}

	input8: coverpoint packet1.wready {
		bins input2zero[] = {0,1};
		
	}

	
	endgroup

		function new (string name = "axi_rd_cov",uvm_component parent);
		super.new (name,parent);
		rd_mycov = new ();
	endfunction

		virtual function void build_phase (uvm_phase phase);
	coverage_collected_export1 = new ("coverage_collected_export1",this);
	packet1  = axi_transaction::type_id::create("packet1",this);
	endfunction


	function void write(axi_transaction t);
	packet1 = t;
	rd_mycov.sample();
	`uvm_info("COVSB", $sformatf("@time %0t, Coverage = %3.2f percent\n", $time, rd_mycov.get_coverage()), UVM_LOW)
	endfunction
	
endclass

