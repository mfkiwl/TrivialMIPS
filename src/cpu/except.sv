`include "cpu_defs.svh"

module except(
	input  rst,
	input  PipelineData_t data_a,
	input  PipelineData_t data_b,
	input  ExceptInfo_t  except_a,
	input  ExceptInfo_t  except_b,
	input  CP0Regs_t     cp0_regs,
	output ExceptReq_t   except_req
);

InstAddr_t pc;
ExceptInfo_t except;
Bit_t interrupt_occur, is_user_mode;
assign interrupt_occur = (
	// TODO: check whether DM bit in debug is zero
	cp0_regs.status.ie &&
	~cp0_regs.status.exl && ~cp0_regs.status.erl &&
	(cp0_regs.cause.ip & cp0_regs.status.im) != 8'b0
);
assign is_user_mode = (
	// TODO: check whether DM bit in debug is zero
	cp0_regs.status.um &&
	~cp0_regs.status.exl &&
	~cp0_regs.status.erl
);

always_comb
begin
	if(interrupt_occur)
	begin
		except.occur = 1'b1;
		except.eret  = 1'b0;
		except.code  = `EXCCODE_INT;
		except_req.alpha_taken = 1'b1;
	end else if(is_user_mode && (data_a.is_priv_inst || data_b.is_priv_inst)) begin
		except.occur = is_user_mode;
		except.eret  = 1'b0;
		except.code  = `EXCCODE_CpU;
		except.extra = 2'd1;  // for status.ce
		except_req.alpha_taken = data_a.is_priv_inst;
	end else if(except_a.occur) begin
		except = except_a;
		except_req.alpha_taken = 1'b1;
	end else begin
		except = except_b;
		except_req.alpha_taken = 1'b0;
	end
end

always_comb
begin
	if(except_req.alpha_taken)
	begin
		pc = data_a.pc;
		except_req.delayslot = data_a.delayslot;
	end else begin
		pc = data_b.pc;
		except_req.delayslot = data_b.delayslot;
	end
end

always_comb
begin
	if(rst || ~except.occur)
	begin
		except_req.flush   = 1'b0;
		except_req.code    = 5'b0;
		except_req.eret    = 1'b0;
		except_req.cur_pc  = `ZERO_WORD;
		except_req.jump_pc = `ZERO_WORD;
		except_req.extra   = `ZERO_WORD;
	end else begin
		except_req.flush  = 1'b1;
		except_req.code   = except.code;
		except_req.cur_pc = pc;
		except_req.eret   = except.eret;
		except_req.extra  = except.extra;
		if(except.eret)
		begin
			if(cp0_regs.status.erl)
				except_req.jump_pc = cp0_regs.error_epc;
			else except_req.jump_pc = cp0_regs.epc;
		end else begin
			HalfWord_t offset;
			if(cp0_regs.status.exl == 1'b0)
			begin
				if(except.code == `EXCCODE_TLBL || except.code == `EXCCODE_TLBS)
				begin
					offset = 16'h000;
				end else if(except.code == `EXCCODE_INT && cp0_regs.cause.iv) begin
					offset = 16'h200;
				end else begin
					offset = 16'h180;
				end
			end else begin
				offset = 16'h180;
			end

			if(cp0_regs.status.bev)
				except_req.jump_pc = 32'hbfc00200 + offset;
			else except_req.jump_pc = 32'h80000000 + offset;
		end
	end
end

endmodule
