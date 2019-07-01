`include "uvm_macros.svh"

import uvm_pkg::*;
package axi_pkg;



	`include "axi_transaction.sv"
	
	`include "axi_write_seq.sv"
	`include "axi_write_sequencer.sv"
	`include "axi_w_driver.sv"
	`include "axi_write_monitor.sv"
	`include "axi_w_agent.sv"
	
	`include "axi_read_seq.sv"
	`include "axi_read_sequencer.sv"
	`include "axi_r_driver.sv"
	`include "axi_r_monitor.sv"
	`include "axi_r_agent.sv"

	`include "axi_sb.sv"
	`include "axi_coverage.sv"
	`include "axi_rd_cov.sv"
	`include "axi_env.sv"
	`include "axi_test.sv"

endpackage
