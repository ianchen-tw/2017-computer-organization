//Subject:     CO project 4
//--------------------------------------------
//Student: 0411276 Chen Yi An
//Student: 0413335 Kuo Yi Lin
//--------------------------------------------

module ProgramCounter(
    clk_i,
	rst_i,
	pcWrite, 
	pc_in_i,
	pc_out_o
	);
     
//I/O ports
input           clk_i;
input	        rst_i;
input 			pcWrite;
input  [32-1:0] pc_in_i;
output [32-1:0] pc_out_o;
 
//Internal Signals
reg    [32-1:0] pc_out_o;
 
//Parameter

    
//Main function
always @(posedge clk_i) begin
    if(~rst_i)
	    pc_out_o <= 0;
	else
	    pc_out_o <= (pcWrite==1'b1) ? pc_in_i:pc_out_o;
end

endmodule
