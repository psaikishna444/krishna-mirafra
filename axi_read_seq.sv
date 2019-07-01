class axi_read_seq extends uvm_sequence#(axi_transaction);


`uvm_object_utils(axi_read_seq)

function new(string name="axi_read_seq");
super.new(name);
endfunction


task body();
repeat(50)
begin
`uvm_info(get_type_name(),"Executing fifo sequence",UVM_LOW)

	 	`uvm_do_with(req,{req.arvalid==0;req.araddr inside{[0:200]};req.rready==1;})
		
		`uvm_do_with(req,{req.arvalid==1;req.araddr inside{[0:200]};req.rready==1;})

		`uvm_do_with(req,{req.arvalid==0;req.araddr inside{[0:200]};req.rready==1;})

		`uvm_do_with(req,{req.arvalid==1;req.araddr inside{[0:200]};req.rready==1;})

		`uvm_do_with(req,{req.arvalid==1;req.araddr inside{[0:200]};req.rready==1;})

/*
		`uvm_do_with(req,{req.arvalid==0;req.rready==1;})
		
		`uvm_do_with(req,{req.arvalid==1;req.rready==1;})

		`uvm_do_with(req,{req.arvalid==0;req.rready==1;})

		`uvm_do_with(req,{req.arvalid==1;req.rready==1;})

		`uvm_do_with(req,{req.arvalid==1;req.rready==1;})
*/

/*
		 `uvm_do_with(req,{req.arvalid==0;req.arprot==3'b000;req.rready==1;})
		
		`uvm_do_with(req,{req.arvalid==1;req.araddr==32'h218;req.arprot==3'b000;req.rready==1;})

		`uvm_do_with(req,{req.arvalid==0;req.arprot==3'b000;req.rready==1;})

		`uvm_do_with(req,{req.arvalid==1;req.araddr==4;req.arprot==3'b000;req.rready==1;})

		`uvm_do_with(req,{req.arvalid==1;req.araddr==8;req.arprot==3'b000;req.rready==1;})
*/

`uvm_info ("INFO",$sformatf("The WRITE CHANNEL VALUES ARE %0p",req),UVM_LOW)

       `uvm_info ("INFO",$sformatf("The values of arvalid = %d and rvalid=%d araddr=%0h and rdata=%d",req.arvalid,req.rvalid,req.araddr,req.rdata),UVM_LOW)
end
endtask

endclass

