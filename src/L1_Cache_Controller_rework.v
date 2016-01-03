`include "StateTable.v"

module L1_Cache_Controller (
	input			clk,
	input			rst,
	
	// Interface to CPU-side components.
	input			cache_cs,
	input			cache_we,
	output			cache_ack,

	// Interface to the internal components.
	input			cache_hit,
	output reg		sram_we,
	input			cache_valid,
	input			cache_dirty_i,
	output reg		cache_dirty_o,
	output reg		dram_data_sel,
	output reg		cpu_data_sel,
	
	// Interface to the DRAM (external memory).
	output reg		dram_addr_sel,
	output reg		dram_cs,
	output reg		dram_we,
	input 			dram_ack
);
	
	// Internal registers for state recording.
	reg	[3:0]	state;	
	reg	[3:0]	next_state;

	reg			cache_ack_en;	// Enable CPU-side ACK response.
	reg			r_cache_ack;	// Internal ACK signal driver.

	initial begin	
		state		= `STATE_IDLE;
		next_state 	= `STATE_IDLE;
	end

	// Control when the ACK signal is emitted.
	assign cache_ack = (cache_ack_en && cache_hit && cache_valid && cache_we) || r_cache_ack;

	// Finite state machine of the L1 cache controller.
	always @ (posedge clk) begin
		state = next_state;
		UpdateSignals(state);

		if(~rst) begin	
			next_state = `STATE_IDLE;
		end
		else begin
			case(state)
				`STATE_IDLE: 
				begin
					if(`DEBUG)
						$display(" -> IDLE", $time);
					
					if(cache_cs && cache_we)
						next_state = `STATE_WRITE;
					else if(cache_cs && !cache_we)
						next_state = `STATE_READ;
					else
						next_state = `STATE_IDLE;
				end

				`STATE_READ:
				begin
					if(`DEBUG)
						$display(" -> READ", $time);
					
					if(cache_hit && cache_valid) begin
						next_state = `STATE_IDLE;
						if(`DEBUG)
							$display(" ... READ HIT");
					end 
					else if((!cache_hit) && cache_valid && cache_dirty_i)
						next_state = `STATE_WRITE_BACK;
					else
						next_state = `STATE_READ_MISS;					
				end
		
				`STATE_READ_MISS:
				begin
					if(`DEBUG)
						$display(" ... READ MISS", $time);
					
					// DELAY THE MEMORY HERE IF DRAM FAIL TO DELAY PROPERLY.
					
					next_state =  `STATE_READ_MEM;
				end
	
				`STATE_READ_MEM:
				begin
					if(`DEBUG)
						$display(" -> READ MEM", $time);

					if(dram_ack)
						next_state = `STATE_READ_DATA;
					else
						next_state = `STATE_READ_MEM;
				end
				
				`STATE_READ_DATA:
				begin
					if(`DEBUG)
						$display(" -> READ DATA", $time);
				
					next_state = `STATE_IDLE;
				end
				
				`STATE_WRITE:
				begin
					if(`DEBUG)
						$display(" -> WRITE", $time);
					
					if(cache_hit && cache_valid)
						next_state = `STATE_WRITE_HIT;
					else	
						next_state = `STATE_WRITE_MISS;
				end
				
				`STATE_WRITE_HIT:
				begin
					if(`DEBUG)
						$display(" ... WRITE HIT", $time);

					next_state = `STATE_IDLE;
				end
	
				`STATE_WRITE_MISS:
				begin
					if(`DEBUG)
						$display(" ... WRITE MISS", $time);

					// DELAY THE MEMORY HERE IF DRAM FAIL TO DELAY PROPERLY.
					
					next_state =  `STATE_WRITE_MEM;
				end

				`STATE_WRITE_MEM:
				begin
					if(`DEBUG)
						$display(" -> WRITE MEM", $time);
					
					if(dram_ack)
						next_state = `STATE_WRITE_DATA;
					else
						next_state = `STATE_WRITE_MEM;
				end

				`STATE_WRITE_DATA:
				begin
					if(`DEBUG)
						$display(" -> WRITE DATA", $time);

					next_state = `STATE_IDLE;
				end

				`STATE_WRITE_BACK:
				begin
					if(`DEBUG)
						$display(" -> WRITE BACK", $time);

					// DELAY THE MEMORY HERE IF DRAM FAIL TO DELAY PROPERLY.
					
					next_state =  `STATE_WRITE_BACK_MEM;
				end

				`STATE_WRITE_BACK_MEM:
				begin
					if(`DEBUG)
						$display(" -> WRITE BACK MEM", $time);

					if(dram_ack)
						next_state = `STATE_READ_MISS;
					else
						next_state = `STATE_WRITE_BACK_MEM;
				end
								
			endcase
		end
	end

task UpdateSignals (
	input	[3:0]	state
);

	case(state)
		`STATE_IDLE:      		ApplySignals();
      	`STATE_READ:      		ApplySignals();
     	`STATE_READ_MISS:  		ApplySignals();
     	`STATE_READ_MEM:   		ApplySignals();
     	`STATE_READ_DATA:  		ApplySignals();
     	`STATE_WRITE:     		ApplySignals();
     	`STATE_WRITE_HIT:  		ApplySignals();
     	`STATE_WRITE_MISS: 		ApplySignals();
     	`STATE_WRITE_MEM:  		ApplySignals();
     	`STATE_WRITE_DATA: 		ApplySignals();
     	`STATE_WRITE_BACK:		ApplySignals();
     	`STATE_WRITE_BACK_MEM: 	ApplySignals();
	endcase

endtask

task ApplySignals (
	input	[:]	sig_vector
);

	begin
	end

endmodule