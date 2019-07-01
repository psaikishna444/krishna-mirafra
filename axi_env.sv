class axi_env extends uvm_env;

`uvm_component_utils(axi_env)

axi_w_agent wagt;
axi_r_agent ragt;
axi_sb sb;
axi_coverage cov;
axi_rd_cov rcov;

function new(string name="axi_env",uvm_component parent);
super.new(name,parent);
endfunction

//=============BUILD PHASE==========//

function void build_phase(uvm_phase phase);
//if(!uvm_config_db#(virtual axi_if)::get(this,"","vif",vif))
wagt=axi_w_agent::type_id::create("wagt",this);
ragt=axi_r_agent::type_id::create("ragt",this);
sb=axi_sb::type_id::create("sb",this);
cov = axi_coverage::type_id::create ("cov",this);//write coverage
rcov = axi_rd_cov::type_id::create ("rcov",this);//read coverage

endfunction

function void connect_phase(uvm_phase phase);

//wagt.wmon.ap.connect(sb.wr_in);
//ragt.rmon.rap.connect(sb.rd_in);

wagt.wmon.ap.connect(sb.axi_wx.analysis_export);
ragt.rmon.rap.connect(sb.axi_rx.analysis_export);
wagt.wmon.ap.connect (cov.coverage_collected_export);
ragt.rmon.rap.connect (rcov.coverage_collected_export1);

endfunction

function void start_of_simulation_phase(uvm_phase phase);
`uvm_info(get_type_name(),{"start of simulation phase"},UVM_HIGH)
endfunction

endclass

