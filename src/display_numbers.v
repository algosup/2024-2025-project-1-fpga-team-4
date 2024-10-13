module display_numbers(
    input [3:0] current,
    output wire [6:0] o_Segment);

always @(*)begin
    case (current)
    0: o_Segment= 7'b1000000;
    1: o_Segment= 7'b1111001; // 1
    2: o_Segment= 7'b0100100; // 2
    3: o_Segment= 7'b0110000; // 3
    4: o_Segment= 7'b0011001; // 4
    5: o_Segment= 7'b0010010; // 5
    6: o_Segment= 7'b0000010; // 6
    7: o_Segment= 7'b1111000; // 7
    8: o_Segment= 7'b1000010; // G
    default: o_Segment= 7'b1000010; //  0
    endcase
end

endmodule