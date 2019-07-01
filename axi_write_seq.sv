class axi_write_seq extends uvm_sequence#(axi_transaction);

`uvm_object_utils(axi_write_seq)

function new(string name="axi_write_seq");
super.new(name);
endfunction


task body();
repeat(50)
begin
`uvm_info(get_type_name(),"Executing fifo sequence",UVM_LOW)

		`uvm_do_with(req,{req.awvalid==1;req.awaddr inside {[0:200]};req.wvalid==1;req.bready==1;})
		
		`uvm_do_with(req,{req.awvalid==0;req.awaddr inside {[0:200]};req.wvalid==1;req.bready==1;})

		`uvm_do_with(req,{req.awvalid==1;req.awaddr inside {[0:200]};req.wvalid==1;req.bready==1;})

		`uvm_do_with(req,{req.awvalid==0;req.awaddr inside {[0:200]};req.wvalid==1;req.bready==1;})

		`uvm_do_with(req,{req.awvalid==1;req.awaddr inside {[0:200]};req.wvalid==1;req.bready==1;})

/*
		`uvm_do_with(req,{req.awvalid==1;req.wvalid==0;req.bready==0;})
		
		`uvm_do_with(req,{req.awvalid==0;req.wvalid==1;req.bready==1;})

		`uvm_do_with(req,{req.awvalid==1;req.wvalid==1;req.bready==1;})

		`uvm_do_with(req,{req.awvalid==0;req.wvalid==1;req.bready==1;})

		`uvm_do_with(req,{req.awvalid==1;req.wvalid==1;req.bready==1;})
*/
/*

		`uvm_do_with(req,{req.awvalid==1;req.awaddr==32'h218;req.awprot==3'b000;req.wvalid==0;req.bready==0;})
		
		`uvm_do_with(req,{req.awvalid==0;req.awprot==3'b000;req.wvalid==1;req.bready==1;})

		`uvm_do_with(req,{req.awvalid==1;req.awaddr==4;req.awprot==3'b000;req.wvalid==1;req.bready==1;})

		`uvm_do_with(req,{req.awvalid==0;req.awprot==3'b000;req.wvalid==1;req.bready==1;})

		`uvm_do_with(req,{req.awvalid==1;req.awaddr==8;req.awprot==3'b000;req.wvalid==1;req.bready==1;})
*/

`uvm_info ("INFO",$sformatf("The WRITE CHANNEL VALUES ARE %0p",req),UVM_LOW)



       `uvm_info ("INFO",$sformatf("The values of awvalid = %d and wvalid=%d bready=%0d awaddr=%0h and wdata=%h",req.awvalid,req.wvalid,req.bready,req.awaddr,req.wdata),UVM_LOW)

//send_request(req);
//wait_for_item_done();
end
endtask

endclass









