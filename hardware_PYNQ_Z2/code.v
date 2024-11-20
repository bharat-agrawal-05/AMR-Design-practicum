`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: data
// Project Name: 
// Target Devices: PYNQ-Z2
// Tool Versions: 
// Description: Access data from BRAM and Classify Modulation Type
// 
// Dependencies: 
// 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module main (
    input wire clk,
    input wire rst_n,
    output reg [2:0] mod_type,
    output  bram_en
);

    // Internal registers to hold values for sigma_ap, sigma_af, and sigma_dp
    reg [31:0] sigma_ap;
    reg [31:0] sigma_af;
    reg [31:0] sigma_dp;
    reg [1:0] counter;
    reg [15:0] addr=16'b0;
    wire [31:0]bram_data_out;
    assign bram_en = 1'b1;           // Always enable BRAM for reading

    blk_mem_gen_0 bram_inst (
        .clka(clk),           
        .ena(bram_en),        
        .wea(1'b0),
        .addra(addr),    
        .dina(16'b0),         
        .douta(bram_data_out) 
    );
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mod_type <= 3'b000;      
            sigma_ap <= 32'd0;
            sigma_af <= 32'd0;
            sigma_dp <= 32'd0;
            counter <= 2'b00;      
        end 
        else 
        begin
            case (counter)
                2'b00: begin
                    sigma_ap <= bram_data_out; 
                    addr <= addr + 1;          
                end
                2'b01: begin
                    sigma_af <= bram_data_out; 
                   addr <= addr + 1;          
                end
                2'b10: begin
                    sigma_dp <= bram_data_out; 
                    if (sigma_ap > 32'd70 && sigma_af > 32'd100 && sigma_dp < 16'd200)
                        mod_type <= 3'b001;      // AM
                    else if (sigma_ap < 32'd10 && sigma_dp > 32'd350)
                        mod_type <= 3'b010;      // FM
                    else if (sigma_ap < 32'd10 && sigma_dp < 32'd60)
                        mod_type <= 3'b011;      // PSK
                    else if (sigma_ap > 32'd35 && sigma_ap < 32'd45 && sigma_af < 32'd30 && sigma_dp < 32'd240)
                        mod_type <= 3'b100;      // ASK
                    else if (sigma_ap < 32'd40 && sigma_af > 32'd90)
                        mod_type <= 3'b101;      // FSK
                    else
                        mod_type <= 3'b000;      // Unknown
                end
            endcase
end
end


always@(posedge clk)
begin
            if (counter == 2'b11) 
            begin
                counter <= 2'b00;
               addr <= addr + 1;
            end 
            else 
            begin
                counter <= counter + 1;
            end
        end
endmodule