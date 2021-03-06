`timescale 1ns/1ps
//15 MHz Clock / 115200 = 130 baud rate
module u_receiver #(parameter clocks_per_bit = 520) 
		   (input clk, input serial_data, output data_valid, output [7:0] parallel_data);
	
	//State Machine initialize
	parameter INITIAL = 3'b000;
	parameter START = 3'b001;
	parameter DATA = 3'b010;
	parameter STOP = 3'b011;
	parameter RESET = 3'b100;

	//initializing the variables
	reg [7:0] clock_counter = 0;
	reg [2:0] index = 0;
	reg r_data_valid = 0;
	reg [7:0] r_parallel_data = 0;
	reg [2:0] FSM = 0;

	assign data_valid   = r_data_valid;
  	assign parallel_data = r_parallel_data;
	
	//State Machine protocol
	always @(posedge clk) begin
		case (FSM)
			INITIAL: begin
				r_data_valid <= 1'b0;
				clock_counter <= 1'b0;
				index <= 1'b0;
				
				if (serial_data == 1'b0) //when start bit found
					FSM <= START;
				else
					FSM <= INITIAL;
			end
			
			START: begin
				if (clock_counter == (clocks_per_bit - 1)/2) begin //checking until the halfway if the start bit still low
					if (serial_data == 1'b0) begin
						clock_counter <= 0;
						FSM <= DATA;
					end
					else
						FSM <= INITIAL;
				end
				else begin
					clock_counter <= clock_counter + 1;
					FSM <= START;
				end
			end

			DATA: begin
				if (clock_counter < clocks_per_bit - 1) begin //cheking the clock for data
					clock_counter <= clock_counter + 1;
					FSM <= DATA;
				end
				else begin
					clock_counter <= 0;
					r_parallel_data[index] <= serial_data;
					
					if(index < 7) begin //checking if all the data is recieved
						index <= index + 1;
						FSM <= DATA;
					end
					else begin
						index <= 0;
						FSM <= STOP;
					end
				end
			end

			STOP: begin
				if (clock_counter < clocks_per_bit - 1) begin //cheking the clock for stop bit
					clock_counter <= clock_counter + 1;
					FSM <= STOP;
				end
				else begin
					r_data_valid <= 1'b1; //valid data recieved
					clock_counter <= 0;
					FSM <= RESET;
				end
			end

			RESET: begin //reset the state machine
				FSM <= INITIAL;
				r_data_valid <= 1'b0;
			end
			
			default:
				FSM <= INITIAL;
		endcase
	end
endmodule
