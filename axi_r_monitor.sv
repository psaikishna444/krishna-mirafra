class axi_r_monitor extends uvm_monitor;

//virtual axi_if.RMN rmvif;
virtual axi_if vif;
int num_trans_rec;
uvm_analysis_port#(axi_transaction)rap;

axi_transaction rmtrans;


`uvm_component_utils_begin(axi_r_monitor)
`uvm_field_int(num_trans_rec,UVM_ALL_ON)
`uvm_component_utils_end

function new(string name="axi_r_monitor",uvm_component parent);
super.new(name,parent);
rap=new("rap",this);
endfunction


function void build_phase(uvm_phase phase);

if(!uvm_config_db#(virtual axi_if)::get(this,"","vif",vif))
`uvm_fatal("NOVIF",{"virtual interface must set for:",get_full_name(),".rmvif"})

endfunction


function void start_of_simulation_phase(uvm_phase phase);
`uvm_info(get_type_name(),{"start of simulation for",get_full_name()},UVM_HIGH)
endfunction

//////////////////Run phase /////////////////
 task run_phase(uvm_phase phase);
   forever
           begin
              repeat(1)@(vif.r_mon_cb);
               begin
                   `uvm_info(get_type_name(),"entered in to Rx monitor",UVM_MEDIUM)  
     	rmtrans = axi_transaction::type_id::create("rmtrans",this);  

                     rmtrans.araddr = vif.r_mon_cb.araddr;
                     rmtrans.arready = vif.r_mon_cb.arready;
		     rmtrans.wready = vif.r_mon_cb.wready;
		 rmtrans.arvalid = vif.r_mon_cb.arvalid;
		 rmtrans.arprot = vif.r_mon_cb.arprot;
                     rmtrans.rvalid = vif.r_mon_cb.rvalid;
		     rmtrans.bvalid = vif.r_mon_cb.bvalid;
                     rmtrans.rdata = vif.r_mon_cb.rdata;   
                     rmtrans.rresp = vif.r_mon_cb.rresp;                
                     rap.write(rmtrans);
                 end

           end
 endtask



function void report_phase(uvm_phase phase );
`uvm_info(get_type_name(),$sformatf("Report :axi read monitor collected %0d trans:",num_trans_rec),UVM_LOW);
endfunction

endclass









