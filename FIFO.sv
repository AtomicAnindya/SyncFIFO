`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2024 11:18:00
// Design Name: 
// Module Name: FIFO
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


module FIFO
#(parameter ADDR_WIDTH=4, DATA_WIDTH=8)
(
    input logic clk, reset,
    input logic wr,rd,
    input logic [DATA_WIDTH - 1: 0] w_data,
    output logic [DATA_WIDTH - 1: 0] r_data,
    output logic full, empty
);

logic [ADDR_WIDTH - 1 : 0] w_addr, r_addr;

FIFO_register_file #(.ADDR_WIDTH(ADDR_WIDTH),.DATA_WIDTH(DATA_WIDTH))
                    reg_file_unit(.w_en(wr & ~full),.*);
                    
FIFO_control #(.ADDR_WIDTH(ADDR_WIDTH))
                fifo_control_unit(.*);
                    
                    
endmodule
