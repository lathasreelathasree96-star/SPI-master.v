module spi_master #(
    parameter DATA_WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  reset,
    input  wire                  start,
    input  wire [DATA_WIDTH-1:0] data_in,

    output reg                   sclk,
    output reg                   mosi,
    output reg                   cs,
    output reg                   busy,
    output reg                   done
);

    reg [DATA_WIDTH-1:0] shift_reg;
    reg [3:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sclk      <= 1'b0;
            mosi      <= 1'b0;
            cs        <= 1'b1;
            busy      <= 1'b0;
            done      <= 1'b0;
            shift_reg <= 0;
            bit_count <= 0;
        end
        else begin
            done <= 1'b0;

            // Start SPI transmission
            if (start && !busy) begin
                cs        <= 1'b0;
                busy      <= 1'b1;
                shift_reg <= data_in;
                bit_count <= 0;
                mosi      <= data_in[DATA_WIDTH-1];
                sclk      <= 1'b0;
            end

            // SPI transmission
            else if (busy) begin
                sclk <= ~sclk;

                // Change data on falling edge
                if (sclk == 1'b1) begin
                    if (bit_count == DATA_WIDTH-1) begin
                        busy <= 1'b0;
                        cs   <= 1'b1;
                        done <= 1'b1;
                        mosi <= 1'b0;
                    end
                    else begin
                        bit_count <= bit_count + 1'b1;
                        shift_reg <= {shift_reg[DATA_WIDTH-2:0], 1'b0};
                        mosi      <= shift_reg[DATA_WIDTH-2];
                    end
                end
            end
        end
    end

endmodule