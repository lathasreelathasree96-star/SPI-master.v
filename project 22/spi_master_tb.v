`timescale 1ns/1ps

module spi_master_tb;

    reg clk;
    reg reset;
    reg start;
    reg [7:0] data_in;

    wire sclk;
    wire mosi;
    wire cs;
    wire busy;
    wire done;

    // Instantiate SPI Master
    spi_master uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data_in(data_in),
        .sclk(sclk),
        .mosi(mosi),
        .cs(cs),
        .busy(busy),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        start = 0;
        data_in = 8'b10101010;

        #20;
        reset = 0;

        // Start transmission
        #10;
        start = 1;

        #10;
        start = 0;

        // Wait for transmission to complete
        wait(done);

        #20;

        // Second transmission
        data_in = 8'b11001100;

        #10;
        start = 1;

        #10;
        start = 0;

        wait(done);

        #20;

        $finish;
    end

    // Monitor signals
    initial begin
        $monitor(
            "Time=%0t | CS=%b | SCLK=%b | MOSI=%b | BUSY=%b | DONE=%b",
            $time, cs, sclk, mosi, busy, done
        );
    end

endmodule