module asser(input clk,rst_n,awvalid,awready,wvalid,wready,bready,bvalid,bresp,arvalid,arready,rready,rvalid);

property p1;
	@(posedge clk)$rose(awvalid)|->awready;
endproperty
A:assert property(p1);

property p2;
	@(posedge clk)$rose(wvalid)|->##[1:2]wready;
endproperty
B:assert property(p2);

property p3;
	@(posedge clk)bvalid|->bready;
endproperty
C:assert property(p3);

property p4;
	@(posedge clk)$rose(arvalid)|->arready;
endproperty
D:assert property(p4);

property p5;
	@(posedge clk)$rose( rvalid)|->##[1:2]rready;
endproperty
E:assert property(p5);
/*
property p6;
	@(posedge clk)disable iff(~rst_n) bvalid|=>bresp;
endproperty
F:assert property(p6);
*/

endmodule
