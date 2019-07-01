module axi_top;
	
	import uvm_pkg::*;
	import axi_pkg::*;

bit clk,rst;

//clock generation////
initial begin
clk=1'b0;
forever  #10 clk=~clk;
end

//reset generation//
initial
begin
@(posedge clk);
rst=1'b0;
@(posedge clk);
rst=1'b1;
end

//////////interface instantiation///////
axi_if vif (clk,rst);

/////////////////module instance////

MFRA_axlite_slv DUT(.clk(clk),
			.rst_n(vif.rst),
			.awvalid(vif.awvalid),
			.awaddr(vif.awaddr),
			.awprot(vif.awprot),
			.awready(vif.awready),
			.wvalid(vif.wvalid),
			.wdata(vif.wdata),
			.wstrb(vif.wstrb),
			.wready(vif.wready),
			.bready(vif.bready),
			.bvalid(vif.bvalid),
			.bresp(vif.bresp),
			.arvalid(vif.arvalid),
			.araddr(vif.araddr),
			.arprot(vif.arprot),
			.arready(vif.arready),
			.rready(vif.rready),
			.rvalid(vif.rvalid),
			.rdata(vif.rdata),
			.rresp(vif.rresp)		
			);



initial
begin
uvm_config_db#(virtual axi_if)::set(null,"*","vif",vif);

run_test("axi_test");
end


endmodule

















