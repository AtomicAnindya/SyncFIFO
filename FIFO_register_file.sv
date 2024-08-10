`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2024 08:59:19
// Design Name: 
// Module Name: FIFO_register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIFO_register_file
#(parameter DATA_WIDTH=8, ADDR_WIDTH=4)
(
    input logic [DATA_WIDTH-1:0] w_data,
    input logic  w_en,clk,
    input logic [ADDR_WIDTH - 1: 0] w_addr, r_addr,
    output logic [DATA_WIDTH-1:0] r_data  
    );
    logic [DATA_WIDTH-1 : 0] RAM [0: 2**ADDR_WIDTH-1];
    always_ff@(posedge clk)
    begin
        if(w_en)
           RAM[w_addr]<=w_data; 
    end
    
    
    assign r_data = RAM[r_addr];

endmodule
