module top (
    input clk,
    output LED1,
    output LED2,
    output LED3,
    output LED4,
    output LED5
);

    localparam BITS = 5;
    localparam LOG2DELAY = 22;
    
    function [BITS-1:0] bin2gray(input [BITS-1:0] in);
        integer i;
        reg [BITS-1:0] temp;
        begin
            temp = in;
            for (i=0; i<BITS; i=i+1)
                bin2gray[i] = ^temp[i +: 2];
        end
    endfunction
    
    
    reg [BITS+LOG2DELAY-1:0] counter = 0;
    
    always@(posedge clk)
        counter <= counter + 1;
        
        
    reg [31:0] rng = 32'h00010000; 
    
    always@(posedge counter[LOG2DELAY-2])
        rng <= ({rng[0],(rng >> 1)})^(rng | {(rng << 1),rng[31]});        
        
    assign {LED1, LED2, LED3, LED4, LED5} = rng[11:7];  // = bin2gray(counter >> LOG2DELAY-1);
    
endmodule 
