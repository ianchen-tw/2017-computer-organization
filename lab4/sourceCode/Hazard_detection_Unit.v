//Subject:     CO project 4
//--------------------------------------------
//Student: 0411276 Chen Yi An
//Student: 0413335 Kuo Yi Lin
//--------------------------------------------

module Hazard_detection_Unit(
    input   EX_MemRead,
    input   [5-1:0]ID_RegisterRs,
    input   [5-1:0]ID_RegisterRt,
    input   [5-1:0]EX_RegisterRt,

    input   MEM_Branch, 

    output  reg PCWrite,
    output  reg IF_Flush,
    output  reg ID_Flush,
	output	reg EX_Flush
);

wire need_to_stall;
assign need_to_stall = ( EX_MemRead &
                         ( (EX_RegisterRt == ID_RegisterRs) ||
                            (EX_RegisterRt == ID_RegisterRt)    )       
                        ) == 1 ;
wire branch_misPredict;
assign branch_misPredict = MEM_Branch ; 

always @(*)begin
//PipeLine Stall  
  if( need_to_stall )begin // load use hazard
	{IF_Flush,ID_Flush,EX_Flush} <= 3'b110;
    PCWrite <= 0;  
    end
  else if (branch_misPredict) begin // branch
	{IF_Flush,ID_Flush,EX_Flush} <= 3'b111;
	PCWrite <= 1;
  end
	else begin
	{IF_Flush,ID_Flush,EX_Flush} <= 'b0;
	PCWrite <= 1;
	end
end

endmodule