module mux5(
    input [15:0] in1, in2, in3, in4, in5,
    input [2:0] s,
    output reg [15:0] out
    );

    always@(*)
        case (s)
            3'b 000: out = in1;
            3'b 001: out = in2;
            3'b 010: out = in3;
            3'b 011: out = in4;
			3'b 100: out = 1n5;
            default: out = out;
        endcase
endmodule