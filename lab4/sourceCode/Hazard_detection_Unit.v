//Subject:     CO project 4
//--------------------------------------------
//Student: 0411276 Chen Yi An
//Student: 0413335 Kuo Yi Lin
//--------------------------------------------

module Hazard_detection_Unit(
    input   EX_MemRead,
    input   ID_RegisterRs,
    input   ID_RegisterRt,
    input   EX_RegisterRt,

    input   MEM_Branch, 

    output  reg PCWrite,
    output  reg IF_ID_Write,
    output  reg IF_Flush,
    output  reg ID_Flush,
	output	reg EX_Flush
);

/*
因為有Branch 的存在, 所以pipeLined CPU會需要 簡單的Branch prediction機制
與 Exception( 預測錯誤 )
這個cpu 的branch 機制是假設branch always not taken
所以 branch signal 一但為true, 就要清空前面的 pipeLine ( flush )
一但發生 load use hazard , 就要產生 stall
*/

wire need_to_stall;
assign need_to_stall = ( EX_MemRead and
                         ( (EX_RegisterRt == ID_RegisterRs) or
                            (EX_RegisterRt == ID_RegisterRt)    )       
                        ) == 1 ;
wire branch_misPredict;
assign branch_misPredict = MEM_branch ; 

always @(*)begin
//PipeLine Stall  
  if( need_to_stall )begin // load use hazard
    IF_ID_Write <= 0;
	IF_Flush <= 1;
    ID_Flush <= 1;
	EX_Flush <= 0; // **
    PCWrite <= 0;  
    end
  else if (branch_misPredict) begin // branch
	IF_ID_Write <=1; // **
    IF_Flush <= 1;
    ID_Flush <= 1;
	EX_Flsut <= 1;
    PCWrite <= 1;
  end

end

endmodule