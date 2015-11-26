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
    
    
    reg [31:0] rng = 32'h00010000; // this _should_ seed the rule 30 rng, but it doesn't - it stays all-off until sel is given a negative pulse.
    
    initial
        rng = 32'h00010000; // ... nope, does nothing too. 
    // desparate measures!    
    reg [15:0] autoreset  = 16'h0000;
    
    always@(posedge clk)
        autoreset <= {autoreset[14:0], 1'b1};
    
    wire reset = !autoreset[15];  
    
    
    always@(posedge counter[LOG2DELAY-2])
    if (reset)
        rng <= 32'h00010000; // still nothing :(
    else
        rng <= ({rng[0],(rng >> 1)})^(rng | {(rng << 1),rng[31]});

    reg [BITS+LOG2DELAY-1:0] counter = 0;
    
    always@(posedge clk)
        counter <= counter + 1;
        
    assign {LED1, LED2, LED3, LED4, LED5} = rng[11:7];  // = bin2gray(counter >> LOG2DELAY-1);
    
endmodule 
