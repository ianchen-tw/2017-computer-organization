//Subject:     CO project 4
//--------------------------------------------
//Student: 0411276 Chen Yi An
//Student: 0413335 Kuo Yi Lin
//--------------------------------------------
`define FORWARD_NO 2'b00
`define FORWARD_FROM_MEM 2'b01 
`define FORWARD_FROM_WB 2'b10

module Forwarding_Unit(
    input EX_RegisterRs,
    input EX_RegisterRt,
    input MEM_RegisterRd,
    input WB_RsgisterRd,

    input MEM_RegWrite,
    input WB_RegWrite,
	
    output ForwardA,
    output ForwardB
);
wire [4:0] EX_RegisterRs;
wire [4:0] EX_RegisterRt;
wire [4:0] MEM_RegisterRd;
wire [4:0] WB_RsgisterRd;

wire EX_RegWrite, WB_RegWrite;

reg [1:0] ForwardA, ForwardB; 

/* ForwardA */
always @(*) begin
    // EX hazard
    if( MEM_RegWrite 
        and ( MEM_RegisterRd != 0 )
        and ( MEM_RegisterRd == EX_RegisterRs ) 
    )   ForwardA = FORWARD_FROM_MEM;
    // MEM hazard
    else if(
        WB_RegWrite
        and ( WB_RsgisterRd != 0)
        and ( not( MEM_RegWrite and (MEM_RegisterRd!=0 ) ) 
               and MEM_RegisterRd != EX_RegisterRs )
        and ( WB_RsgisterRd == EX_RegisterRs )
    )   ForwardA = FORWARD_FROM_WB
    else 
        ForwardA = FORWARD_NO;
end

/* ForwardB */
always @(*) begin
    // EX hazard
    if( MEM_RegWrite 
        and ( MEM_RegisterRd != 0 )
        and ( MEM_RegisterRd == EX_RegisterRt ) 
    )   ForwardB = FORWARD_FROM_MEM;
    // MEM hazard
    else if(
        WB_RegWrite
        and ( WB_RsgisterRd != 0)
        and ( not( MEM_RegWrite and (MEM_RegisterRd!=0 ) ) 
               and MEM_RegisterRd != EX_RegisterRt )
        and ( WB_RsgisterRd == EX_RegisterRt )
    )   ForwardB = FORWARD_FROM_WB;
    else 
        ForwardB = FORWARD_NO;
end

endmodule