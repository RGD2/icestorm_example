module top (
    input clk,
    input sel,
    output LED1,
    output LED2,
    output LED3,
    output LED4,
    output LED5,
    output LED6,
    output LED7,
    output LED8
);

    localparam BITS = 8;
    localparam LOG2DELAY = 22;
    
    function [BITS-1:0] bin2gray(input [BITS+1:0] in);
        integer i;
        reg [BITS+1:0] temp;
        begin
            temp = in;
            for (i=0; i<BITS; i=i+1)
                bin2gray[i] = ^temp[i +: 2];
        end
    endfunction
    
    
    reg [31:0] rng = 32'h00010000; // this _should_ seed the rule 30 rng, but it doesn't - it stays all-off until sel is given a negative pulse.
    
    initial
        rng = 32'h00010000; // ... nope, does nothing too. 
    
    always@(posedge counter[LOG2DELAY-2])
    if (sel)
        rng <= ({rng[0],(rng >> 1)})^(rng | {(rng << 1),rng[31]});
    else
        rng <= 32'h00010000; // only this works :(


    reg [BITS+LOG2DELAY-1:0] counter = 0; // in the CHECK pass: "Warning: Wire top.counter has an unprocessed 'init' attribute." There's one for rng too.
    
    always@(posedge clk)
        counter <= counter + 1;
        
    assign {LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8} = sel ? rng[14:7] : bin2gray(counter >> LOG2DELAY-1);
    
    
    
endmodule 
