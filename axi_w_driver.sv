class axi_w_driver extends uvm_driver#(axi_transaction);

`uvm_component_utils(axi_w_driver)

//virtual axi_if.WDRV wdvif;

virtual axi_if vif;

int num_sent;

axi_transaction trans;

/////costructor///////////////

function new(string name="axi_w_driver ",uvm_component parent);
super.new(name,parent);
endfunction

///////BUILD PHASE//////////////////

function void build_phase (uvm_phase phase);
super.build_phase(phase);
if(!(uvm_config_db#(virtual axi_if)::get(this,"","vif",vif)))
begin
`uvm_fatal("NO_VIF",{"virtual interface must be set for:",get_full_name(),".vif"});
end
trans=axi_transaction::type_id::create("trans",this);
endfunction


///////////////////START OF SIMULATION//////////////////

function void start_of_simulation_phase(uvm_phase phase );
		`uvm_info(get_type_name(),{"start of simulation for ",get_full_name()},UVM_LOW)
	endfunction

//////////////////RUN PHASE/////////////////////////
 
task run_phase(uvm_phase phase);
  forever
    begin
      repeat (5)@ (vif.w_drv_cb);
		if (!vif.w_drv_cb.rst)
		 begin
       			`uvm_info(get_type_name(),"RESET observed",UVM_LOW)
				   vif.w_drv_cb.wdata  <= 'bz;
             				  vif.w_drv_cb.awaddr  <= 'bz;
					vif.w_drv_cb.awvalid <= 'b0;
					vif.w_drv_cb.wvalid  <= 'b0;
					vif.w_drv_cb.bready  <= 'b0;
					vif.w_drv_cb.wstrb   <= 'b0;
					vif.w_drv_cb.awprot  <= 'b0;		
		end
		else
		begin

seq_item_port.get_next_item(trans);
    		                // vif.w_drv_cb.wvalid<=1'b1;
	                         //vif.w_drv_cb.awvalid<=1'b1;  

		                  // @ (vif.w_drv_cb);
                         if(trans.awvalid)
                         begin
                         vif.w_drv_cb.awvalid <= trans.awvalid;
                         vif.w_drv_cb.awaddr  <= trans.awaddr; 
                         vif.w_drv_cb.awprot  <= trans.awprot;  
			 vif.w_drv_cb.wvalid <= trans.wvalid;
                         vif.w_drv_cb.wdata  <= trans.wdata;
			               vif.w_drv_cb.bready <= trans.bready;
					//vif.w_drv_cb.bready <= 1'b1;
                         vif.w_drv_cb.wstrb  <= trans.wstrb;
				// vif.w_drv_cb.wvalid<=1'b1;
	                         //vif.w_drv_cb.awvalid<=1'b1;  
			                num_sent++;
                         end 
		seq_item_port.item_done();
		end
  end			
 endtask
////////////////Repoprt Phase/////////////////////////////

function void report_phase(uvm_phase phase);
	   `uvm_info(get_type_name(), $sformatf("Report: FIFO TX DRIVER SENT %0d packets", num_sent), UVM_LOW)
endfunction: report_phase

endclass  
