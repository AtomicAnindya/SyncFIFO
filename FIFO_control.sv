`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2024 09:09:15
// Design Name: 
// Module Name: FIFO_control
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


module FIFO_control
#(parameter ADDR_WIDTH=4)
(
    input logic wr,rd,clk,reset,
    output logic full,empty,
    output logic [ADDR_WIDTH-1:0] w_addr, r_addr
    );
    
    logic [ADDR_WIDTH-1:0] w_ptr, w_ptr_next, rd_ptr, rd_ptr_next;
    
    logic full_next;
    logic empty_next;
    
    always_ff@(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            w_ptr<=0;
            rd_ptr<=0;
            full<=1'b0;
            empty<=1'b1;
        end
        else
        begin
            w_ptr<=w_ptr_next;
            rd_ptr<=rd_ptr_next;
            full<=full_next;
            empty<=empty_next;
        end
    end
    
    always_comb
    begin
        w_ptr_next=w_ptr;
        rd_ptr_next=rd_ptr;
        full_next=full;
        empty_next=empty;
        
        case({wr,rd})
            2'b01:  begin           //read
                        if(~empty)
                        begin
                            rd_ptr_next=rd_ptr+1;
                            full_next=1'b0;
                            if(rd_ptr_next==w_ptr)
                                empty_next=1'b1;
                        end
                    end
            2'b10:  begin           //write
                        if(~full)
                        begin
                            w_ptr_next=w_ptr+1;
                            empty_next=1'b0;
                            if(w_ptr_next==rd_ptr)
                                full_next=1'b1;
                        end
                    end
            2'b11:  begin           //read and write simultaneously
                        if(empty)
                        begin
                            w_ptr_next=w_ptr;
                            rd_ptr_next=rd_ptr;
                        end
                        w_ptr_next= w_ptr+1;
                        rd_ptr_next= rd_ptr+1;
                    end
            default: ;
            
            
        endcase  
    end
    assign w_addr= w_ptr;
    assign r_addr= rd_ptr;
endmodule
