class axi_write_monitor extends uvm_monitor;

//`uvm_component_utils(axi_write_monitor)

//virtual axi_if.WMN wmvif;
virtual axi_if vif;

int num_trans_col;
 
uvm_analysis_port#(axi_transaction)ap;


axi_transaction wtrans;

`uvm_component_utils_begin(axi_write_monitor)
`uvm_field_int(num_trans_col,UVM_ALL_ON)
`uvm_component_utils_end


function new(string name="axi_write_wmonitor",uvm_component parent);
super.new(name,parent);
ap=new("ap",this);
endfunction

function void build_phase(uvm_phase phase);

if(!uvm_config_db #(virtual axi_if)::get(this,"","vif",vif))
`uvm_fatal("NOVIF",{"virtual interface must set for:",get_full_name(),".vif"})
endfunction

function void start_of_simulation_phase(uvm_phase phase);
`uvm_info(get_type_name(),{"start of simulation for",get_full_name()},UVM_HIGH)
endfunction

///////////////////Run phase /////////////////
 task run_phase(uvm_phase phase);
   forever
           begin
              repeat(1)@(vif.w_mon_cb);
                begin
                   `uvm_info(get_type_name(),"entered in to Tx monitor",UVM_MEDIUM)       
                    wtrans = axi_transaction::type_id::create("wtrans",this);  
	       
 
                     wtrans.wdata = vif.w_mon_cb.wdata;
                     wtrans.bready = vif.w_mon_cb.bready;
		     wtrans.rready = vif.w_mon_cb.rready;
                     wtrans.bresp = vif.w_mon_cb.bresp;   
                     wtrans.awaddr = vif.w_mon_cb.awaddr;    
                     wtrans.bvalid = vif.w_mon_cb.bvalid;
		     wtrans.awprot = vif.w_mon_cb.awprot;
		     wtrans.wstrb = vif.w_mon_cb.wstrb; 
		     wtrans.wvalid = vif.w_mon_cb.wvalid;
		     wtrans.awvalid = vif.w_mon_cb.awvalid; 
 $display("WR MONITOR RESPONSE = %0b, VAILD = %0b",vif.w_mon_cb.bresp,vif.w_mon_cb.bvalid);           
                     ap.write(wtrans);
                     num_trans_col++;
                 end

           end
 endtask



function void report_phase(uvm_phase phase );
`uvm_info(get_type_name(),$sformatf("Report :axi write monitor collected %0d trans:",num_trans_col),UVM_LOW);
endfunction

endclass

