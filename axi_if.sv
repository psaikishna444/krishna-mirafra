
`timescale 1ns/1ps
interface axi_if(input bit clk,input bit rst);

////////Write address channel//////////////

logic      awvalid;
logic      awready;
logic [31:0] awaddr;
logic [2:0] awprot;

//////////write data channel///////////

logic      wvalid;
logic      wready;
logic [31:0] wdata;
logic [3:0] wstrb;

/////////write rseponse channel////

logic bvalid;
logic bready;
logic [1:0]bresp;

/////////////////Read address channel/////////


logic        arvalid;
logic        arready;
logic [31:0] araddr;
logic [2:0]  arprot;

/////////Read data or response  channel/////////

logic      rvalid;
logic      rready;
logic [31:0] rdata;
logic [1:0] rresp;

//////////////////////
/*property p;
@(posedge clk)disable_iff(rst);
endproperty
assert_write:assert property(p);
*/
////clocking blocks///////////
clocking w_drv_cb@(posedge clk);
default input #1 output #0;
input rst,awready,wready;
output awvalid,awaddr,awprot,wvalid,wdata,wstrb,bready;

endclocking

clocking r_drv_cb@(posedge clk);
default input #1 output #0;
input rst,arready;;
output arvalid,araddr,arprot,rready;

endclocking

clocking w_mon_cb @(posedge clk);
default input #0 output #0;
input awvalid,awaddr,awprot,wvalid,wdata,wstrb,bready,rready,arvalid,araddr,arprot,awready,wready,bvalid,bresp,arready,rvalid,rresp,rdata,rst;
endclocking

clocking r_mon_cb@(posedge clk);
default input #0 output #0;

input awvalid,awaddr,awprot,wvalid,wdata,wstrb,bready,rready,arvalid,araddr,arprot,awready,wready,bvalid,bresp,arready,rvalid,rresp,rdata,rst;

endclocking

////MODPORTS//////////
modport WDRV(clocking w_drv_cb);
modport RDRV(clocking r_drv_cb);
modport WMN(clocking w_mon_cb );
modport RMN(clocking r_mon_cb );


endinterface






