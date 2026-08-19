`timescale 1ns/1ps

module synchronous_fifo_tb;

    parameter DATA_WIDTH = 8;
    parameter FIFO_DEPTH = 8;

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] data_in;

    wire [DATA_WIDTH-1:0] data_out;
    wire full;
    wire empty;

    // DUT
    synchronous_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH)
    ) DUT (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("fifo.vcd");
        $dumpvars(0, synchronous_fifo_tb);

        clk    = 0;
        rst    = 1;
        wr_en  = 0;
        rd_en  = 0;
        data_in = 0;

        $display("======================================");
        $display("     SYNCHRONOUS FIFO TESTBENCH");
        $display("======================================");

        // Reset
        #10;
        rst = 0;

        $display("\nFIFO Reset Completed");
        $display("Empty = %b, Full = %b", empty, full);

        // Write data
        write_data(8'h11);
        write_data(8'h22);
        write_data(8'h33);
        write_data(8'h44);
        write_data(8'h55);

        // Read data
        read_data();
        read_data();
        read_data();

        // Write more data
        write_data(8'h66);
        write_data(8'h77);
        write_data(8'h88);

        // Read remaining data
        read_data();
        read_data();
        read_data();
        read_data();
        read_data();

        // Final status
        #10;
        $display("\nFinal FIFO Status:");
        $display("Empty = %b", empty);
        $display("Full  = %b", full);

        $display("\n======================================");
        $display("       SIMULATION COMPLETED");
        $display("======================================");

        $finish;
    end

    // Write task
    task write_data(input [DATA_WIDTH-1:0] data);
        begin
            @(posedge clk);
            if (!full) begin
                wr_en = 1;
                data_in = data;

                @(posedge clk);
                wr_en = 0;

                $display("WRITE : Data = %h | Empty = %b | Full = %b",
                         data, empty, full);
            end
            else begin
                $display("WRITE BLOCKED : FIFO FULL");
            end
        end
    endtask

    // Read task
    task read_data;
        begin
            @(posedge clk);
            if (!empty) begin
                rd_en = 1;

                @(posedge clk);
                rd_en = 0;

                $display("READ  : Data = %h | Empty = %b | Full = %b",
                         data_out, empty, full);
            end
            else begin
                $display("READ BLOCKED : FIFO EMPTY");
            end
        end
    endtask

endmodule