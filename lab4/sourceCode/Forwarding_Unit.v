//Subject:     CO project 4
//--------------------------------------------
//Student: 0411276 Chen Yi An
//Student: 0413335 Kuo Yi Lin
//--------------------------------------------
`define FORWARD_NO 2'b00
`define FORWARD_FROM_MEM 2'b01 
`define FORWARD_FROM_WB 2'b10

module Forwarding_Unit(
    input [4:0]EX_RegisterRs,
    input [4:0]EX_RegisterRt,
    input [4:0]MEM_RegisterRd,
    input [4:0]WB_RsgisterRd,

    input MEM_RegWrite,
    input WB_RegWrite,
	
    output reg[1:0] ForwardA,
    output reg[1:0] ForwardB
);

/* ForwardA */
always @(*) begin
    // EX hazard
    if( MEM_RegWrite 
        & ( MEM_RegisterRd != 0 )
        & ( MEM_RegisterRd == EX_RegisterRs ) 
    )   ForwardA = `FORWARD_FROM_MEM;
    // MEM hazard
    else if(
        WB_RegWrite
        & ( WB_RsgisterRd != 0)
        & ( ~( MEM_RegWrite & (MEM_RegisterRd!=0 ) ) 
               & MEM_RegisterRd != EX_RegisterRs )
        & ( WB_RsgisterRd == EX_RegisterRs )
    )   ForwardA = `FORWARD_FROM_WB;
    else 
        ForwardA = `FORWARD_NO;
end

/* ForwardB */
always @(*) begin
    // EX hazard
    if( MEM_RegWrite 
        & ( MEM_RegisterRd != 0 )
        & ( MEM_RegisterRd == EX_RegisterRt ) 
    )   ForwardB = `FORWARD_FROM_MEM;
    // MEM hazard
    else if(
        WB_RegWrite
        & ( WB_RsgisterRd != 0)
        & ( ~( MEM_RegWrite & (MEM_RegisterRd!=0 ) ) 
               & MEM_RegisterRd != EX_RegisterRt )
        & ( WB_RsgisterRd == EX_RegisterRt )
    )   ForwardB = `FORWARD_FROM_WB;
    else 
        ForwardB = `FORWARD_NO;
end

endmodule