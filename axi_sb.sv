class axi_sb extends uvm_scoreboard;

`uvm_component_utils(axi_sb)
	
	//`uvm_analysis_imp_decl(_wr)
	//`uvm_analysis_imp_decl(_rd)

//uvm_analysis_imp_wr #(axi_transaction,axi_sb) wr_in;
//uvm_analysis_imp_rd #(axi_transaction,axi_sb) rd_in;

uvm_tlm_analysis_fifo #(axi_transaction)axi_wx;
uvm_tlm_analysis_fifo #(axi_transaction)axi_rx;


axi_transaction wx_er;
axi_transaction rx_er;

function new(string name="axi_sb",uvm_component parent);
super.new(name,parent);
	//wr_in=new("wr_in",this);
	//rd_in=new("rd_in",this);
	axi_wx = new("axi_wx",this);
        axi_rx = new("axi_rx",this);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info(get_type_name(),{"start of build phase"},UVM_HIGH)
endfunction

function void connect_phase(uvm_phase phase);
`uvm_info(get_type_name(),{"start of connect phase"},UVM_LOW)
endfunction

function void start_of_simulation_phase(uvm_phase phase);
`uvm_info(get_type_name(),{"start of build phase"},UVM_LOW)
endfunction

task run_phase(uvm_phase phase);
      forever
        begin
	     fork
	       begin
	         axi_wx.get(wx_er);
                  $display($time,"-------------getting wx data ------------------");
                  `uvm_info(get_type_name(),$sformatf("printing from scoreboard wx_er  %s \n",wx_er.sprint()),UVM_LOW)
               end			
               begin
                 axi_rx.get(rx_er);
                  $display($time," -------------getting rx data  ------------------");				
                  `uvm_info(get_type_name(),$sformatf("printing from scoreboard rx_er  %s \n",rx_er.sprint()),UVM_LOW)
               end
	    join

                  $display($time,"----------------------coming out of  SCOREBOARD-----------------------");

              //   begin
                      if(wx_er.wdata==rx_er.rdata)
                          begin
                        	$display($time,"-------SUCCESSFULLY COMPARED--------------------");
                                $display("WRITEDATA is equal to READDATA ie, %0d = %0d",wx_er.wdata,rx_er.rdata);
                          end
                      else
                          begin
                        	$display($time,"--------NOT SUCCESSFULLY COMPARED--------------------");
                                $display("WRITEDATA is NOT equal to READDATA ie %0d != %0d",wx_er.wdata,rx_er.rdata);
                           end                    
                    // end

        end
   endtask
endclass





