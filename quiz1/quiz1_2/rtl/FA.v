module FA (
    input x,
    input y,
    input z,

    output s,
    output c
);

assign {c,s} = x + y + z;
    
endmodule