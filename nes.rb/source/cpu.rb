=begin
Nintendo.rb

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end
require './opdata'

# Class modeling the NES CPU, it's registers and state.
class CPU

    # IRQ Types.
    IRQ_NORMAL = 0
    IRQ_NMI = 1
    IRQ_RESET = 2

    # Main Memory.
    attr_accessor :main_memory

    # Registers. 
    attr_accessor :REG_ACC,             # Accumulator register.
                  :REG_X, :REG_Y,       # "8-bit index registers X and Y"
                  :REG_SP,              # Stack pointer - used to track the start of our current stack.]
                  :REG_PC, :REG_PC_NEW, # The program counter - points to the current instruction in memory. 
                  :REG_STATUS           # The "status" register - Keeps CPU status using a group of flags.

    # Flags.
    attr_accessor :F_CARRY,         # Arithmatic carry.
                  :F_DECIMAL,       # Enables decimal mode.
                  :F_INTERRUPT,     # Hardware interrupt.
                  :F_INTERRUPT_NEW, 
                  :F_OVERFLOW,      # Memory overflow flag.
                  :F_SIGN,          # Sign of the number.
                  :F_ZERO,          # Zero result.
                  :F_NOTUSED,
                  :F_NOTUSED_NEW,
                  :F_BRK,           # BRK instruction - aka the software interrupt
                  :F_BRK_NEW

    # Crash flag
    attr_accessor :crash         # Flag indicating the crash status of the NES.
    attr_accessor :cycles_to_halt# How long to stall the CPU for (used to wait for hardware requests or timing purposes).
    attr_accessor :irq_requested # Has a hardware interrupt request been found?
    attr_accessor :irq_type      # What type of hardware interrupt has been requested?
    attr_accessor :nes           # The NES ROM currently being used aka a game.
    attr_accessor :opdata        # OP_DATA class instance used to execute instructions (basically a library of assembler intructions).

    # Constructor time!
    def initialize(nes) 
        @nes = nes
        reset()
    end

    # Reset the CPU and memory, flags and register.
    def reset

        # Zero out the main memory buffer and default all the subsections.
        @main_memory = Array.new(0x10000)

        i = 0
        while i  < 0x2000
            @main_memory[i] = 0xFF
            i+=1
        end

        p = 0
        while p < 4
            i = p*0x800;
            @main_memory[i+0x008] = 0xF7
            @main_memory[i+0x009] = 0xEF
            @main_memory[i+0x00A] = 0xDF
            @main_memory[i+0x00F] = 0xBF
            p+=1
        end

        i = 0x2001
        while i < @main_memory.length
            @main_memory[i] = 0
            i+=1
        end

        # Reset the accumulator register and X and Y index registers
        @REG_ACC = 0
        @REG_X   = 0
        @REG_Y   = 0

        # Reset the Stack pointer:
        @REG_SP = 0x01FF

        # Reset the Program counters:
        @REG_PC = 0x8000-1
        @REG_PC_NEW = 0x8000-1
        
        # Reset Status register:
        @REG_STATUS = 0x28
        self.set_status(0x28)

        # Set the flag defaults.
        @F_CARRY         = 0
        @F_DECIMAL       = 0
        @F_INTERRUPT     = 1
        @F_INTERRUPT_NEW = 1
        @F_OVERFLOW      = 0
        @F_SIGN          = 0
        @F_ZERO          = 1

        @F_NOTUSED       = 1
        @F_NOTUSED_NEW   = 1
        @F_BRK           = 1
        @F_BRK_NEW       = 1

        @opdata = OP_DATA.new.opdata;
        @cycles_to_halt = 0
        
        # Reset crash flag:
        @crash = false
        
        # Hardware interrupt notification:
        @irq_requested = false
        @irq_type = null
    end

    # Sets the flags (basically a bit vector operation going on here)
    def set_status(status)

        self.F_CARRY     = (status   )&1;
        self.F_ZERO      = (status>>1)&1;
        self.F_INTERRUPT = (status>>2)&1;
        self.F_DECIMAL   = (status>>3)&1;
        self.F_BRK       = (status>>4)&1;
        self.F_NOTUSED   = (status>>5)&1;
        self.F_OVERFLOW  = (status>>6)&1;
        self.F_SIGN      = (status>>7)&1;
    end
    
    # Load a block of memory from main memory or a ROM.
    def load(addr)
        if (addr < 0x2000)
            return @main_memory[addr & 0x7FF]
        else
            return @nes.mmap.load(addr)
        end
    end
    
    # Load a 16 bit block of memory.
    def load_16_bit(addr)

        if (addr < 0x1FFF)
            return @main_memory[addr&0x7FF] 
                | (@main_memory[(addr+1)&0x7FF]<<8)
        else
            return @nes.mmap.load(addr) | (@nes.mmap.load(addr+1) << 8)
        end
    end
    
    # Write a block of memory.
    def write(addr, val)
        if(addr < 0x2000)
            @main_memory[addr&0x7FF] = val
        else 
            @nes.mmap.write(addr,val)
    end

    # Requests a hardware interrupt from the CPU.
    def request_irq(type)

        if(@irq_requested)

            if(type == IRQ_NORMAL)
                return
            end
        end

        @irq_requested = true
        @irq_type      = type
    end

    # Push an instruction down into the CPU's stack and update the stack pointer accordingly.
    def push(value)
        @nes.mmap.write(@REG_SP, value)
        @REG_SP -= 1
        @REG_SP = 0x0100 | (@REG_SP&0xFF)
    end

    # Increment the stack pointer to wrap around if the stack has overgrown it's allotted memory space.
    def stack_wrap
        @REG_SP = 0x0100 | (@REG_SP&0xFF)
    end

    # Technically a "pop" off the top of the stack but apparently they are calling it a pull here. 
    def pull
        @REG_SP += 1;
        @REG_SP = 0x0100 | (@REG_SP&0xFF)
        return @nes.mmap.load(@REG_SP)
    end

    # This probably gets called when we have read from one memory page to another e.g. crossed a memory page into the next.
    def page_crossed(addr1, addr2)
        return ((addr1&0xFF00) != (addr2&0xFF00))
    end

    # Force the CPU to idle for a certain number of cycles (probably while the hardware waits for something to finish)
    def halt_cycles(cycles)
        @cycles_to_halt += cycles
    end

    def do_non_maskable_interrupt(status)

        # Check whether VBlank Interrupts are enabled (e.g. blanking the PPU screen).
        if((@nes.mmap.load(0x2000) & 128) != 0) 

            # Push down some instructions onto the stack.
            @REG_PC_NEW += 1
            self.push((@REG_PC_NEW>>8)&0xFF)
            self.push(@REG_PC_NEW&0xFF)
            self.push(status)

            @REG_PC_NEW = @nes.mmap.load(0xFFFA) | (@nes.mmap.load(0xFFFB) << 8)
            @REG_PC_NEW -= 1
        end
    end

    def do_reset_interrupt
        @REG_PC_NEW = @nes.mmap.load(0xFFFC) | (@nes.mmap.load(0xFFFD) << 8)
        @REG_PC_NEW -= 1
    end

    # Handle a hardware interrupt request.
    def do_irq(status)

        @REG_PC_NEW += 1
        self.push((@REG_PC_NEW>>8)&0xFF)
        self.push(@REG_PC_NEW&0xFF)
        self.push(status)
        @F_INTERRUPT_NEW = 1
        @F_BRK_NEW = 0

        # Set the program counter new.
        @REG_PC_NEW = @nes.mmap.load(0xFFFE) | (@nes.mmap.load(0xFFFF) << 8)
        @REG_PC_NEW -= 1
    end

    # Return the status of our flags.
    def get_status
        return (@F_CARRY)
                |(@F_ZERO<<1)
                |(@F_INTERRUPT<<2)
                |(@F_DECIMAL<<3)
                |(@F_BRK<<4)
                |(@F_NOTUSED<<5)
                |(@F_OVERFLOW<<6)
                |(@F_SIGN<<7)
    end

    # Emulates a single CPU instruction, returns the number of cycles
    def emulate
        temp
        add
        
        # Check if there are any hardware interrupts:
        if(@irq_requested)

            temp =
                (@F_CARRY)|
                ((@F_ZERO===0?1:0)<<1)|
                (@F_INTERRUPT<<2)|
                (@F_DECIMAL<<3)|
                (@F_BRK<<4)|
                (@F_NOTUSED<<5)|
                (@F_OVERFLOW<<6)|
                (@F_SIGN<<7)

            # Store the program counter and interrupt flag.
            @REG_PC_NEW = @REG_PC
            @F_INTERRUPT_NEW = @F_INTERRUPT

            # React to the interrupt request based on it's type.
            case(@irq_type)
                when 0
                    # Normal IRQ:
                    if(@F_INTERRUPT !=0 )
                        puts "Interrupt was masked."
                    else
                        # Do the interrupt request on the CPU.
                        do_irq(temp)
                            puts "Did normal IRQ. I= #{@F_INTERRUPT}"
                    end
                when 1
                    # NMI:
                    self.do_non_maskable_interrupt(temp)
                when 2
                    # Reset:
                    self.do_reset_interrupt
            end

            # Set all the breaks and program counters back to where they need to be.
            @REG_PC = @REG_PC_NEW
            @F_INTERRUPT = @F_INTERRUPT_NEW
            @F_BRK = @F_BRK_NEW
            @irq_requested = false
        end

        opinf = @opdata[@nes.mmap.load(@REG_PC+1)]
        cycleCount = (opinf>>24)
        cycleAdd = 0

        # Find address mode:
        addrMode = (opinf >> 8) & 0xFF

        # Increment PC by number of op bytes:
        opaddr = @REG_PC
        @REG_PC += ((opinf >> 16) & 0xFF)
        
        addr = 0
       
        case(addrMode)
            when 0
                # Zero Page mode. Use the address given after the opcode, 
                # but without high byte.
                addr = self.load(opaddr+2)
            when 1
                # Relative mode.
                addr = self.load(opaddr+2)

                if(addr<0x80)
                    addr += @REG_PC
                else
                    addr += @REG_PC-256
                end
            when 2
                # Ignore. Address is implied in instruction.
            when 3
                # Absolute mode. Use the two bytes following the opcode as 
                # an address.
                addr = self.load_16_bit(opaddr+2)
            when 4
                # Accumulator mode. The address is in the accumulator 
                # register.
                addr = @REG_ACC
            when 5
                # Immediate mode. The value is given after the opcode.
                addr = @REG_PC
            when 6
                # Zero Page Indexed mode, X as index. Use the address given 
                # after the opcode, then add the
                # X register to it to get the final address.
                addr = (self.load(opaddr+2)+@REG_X)&0xFF
                break;
            when 7
                # Zero Page Indexed mode, Y as index. Use the address given 
                # after the opcode, then add the
                # Y register to it to get the final address.
                addr = (self.load(opaddr+2)+@REG_Y)&0xFF
            when 8
                # Absolute Indexed Mode, X as index. Same as zero page 
                # indexed, but with the high byte.
                addr = self.load16bit(opaddr+2);
                if((addr&0xFF00)!=((addr+@REG_X)&0xFF00))
                    cycleAdd = 1
                end
                addr += @REG_X
            when 9
                # Absolute Indexed Mode, Y as index. Same as zero page 
                # indexed, but with the high byte.
                addr = self.load_16_bit(opaddr+2)
                if((addr&0xFF00)!=((addr+@REG_Y)&0xFF00
                    cycleAdd = 1
                end
                addr+=@REG_Y
            when 10
                # Pre-indexed Indirect mode. Find the 16-bit address 
                # starting at the given location plus
                # the current X register. The value is the contents of that 
                # address.
                addr = self.load(opaddr+2)

                if((addr&0xFF00)!=((addr+@REG_X)&0xFF00))
                    cycleAdd = 1
                end

                addr+=@REG_X
                addr&=0xFF
                addr = self.load_16_bit(addr)
            when 11
                # Post-indexed Indirect mode. Find the 16-bit address 
                # contained in the given location
                # (and the one following). Add to that address the contents 
                # of the Y register. Fetch the value
                # stored at that adress.
                addr = self.load_16_bit(self.load(opaddr+2))

                if((addr&0xFF00)!=((addr+@REG_Y)&0xFF00))
                    cycleAdd = 1
                end

                addr+=@REG_Y
            when 12
                # Indirect Absolute mode. Find the 16-bit address contained 
                # at the given location.
                addr = self.load_16_bit(opaddr+2) #Find op

                if(addr < 0x1FFF) 
                    addr = @main_memory[addr] + (@main_memory[(addr & 0xFF00) | (((addr & 0xFF) + 1) & 0xFF)] << 8) #Read from address given in op
                else
                    addr = @nes.mmap.load(addr) + (@nes.mmap.load((addr & 0xFF00) | (((addr & 0xFF) + 1) & 0xFF)) << 8)
                end
        end
        
        # Wrap around for addresses above 0xFFFF:
        addr&=0xFFFF

        # ----------------------------------------------------------------------------------------------------
        # Decode & execute instruction:
        # ----------------------------------------------------------------------------------------------------

        # This should be compiled to a jump table.
        case(opinf&0xFF)
            when 0
                # *******
                # * ADC *
                # *******

                # Add with carry.
                temp = @REG_ACC + self.load(addr) + @F_CARRY
                @F_OVERFLOW = ((!(((@REG_ACC ^ self.load(addr)) & 0x80)!=0) && (((@REG_ACC ^ temp) & 0x80))!=0)?1:0)
                @F_CARRY = (temp>255?1:0)
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp&0xFF
                @REG_ACC = (temp&255)
                cycleCount+=cycleAdd
            when 1
                # *******
                # * AND *
                # *******

                # AND memory with accumulator.
                @REG_ACC = @REG_ACC & self.load(addr)
                @F_SIGN = (@REG_ACC>>7)&1
                @F_ZERO = @REG_ACC
                #@REG_ACC = temp
                if(addrMode!=11)
                    cycleCount+=cycle
                end
            when 2
                # *******
                # * ASL *
                # *******

                # Shift left one bit
                if(addrMode == 4) # ADDR_ACC = 4
                    @F_CARRY = (@REG_ACC>>7)&1
                    @REG_ACC = (@REG_ACC<<1)&255
                    @F_SIGN = (@REG_ACC>>7)&1
                    @F_ZERO = @REG_ACC
                else
                    temp = self.load(addr)
                    @F_CARRY = (temp>>7)&1
                    temp = (temp<<1)&255
                    @F_SIGN = (temp>>7)&1
                    @F_ZERO = temp
                    @write(addr, temp)
                end
            when 3
                # *******
                # * BCC *
                # *******

                # Branch on carry clear
                if(@F_CARRY == 0)
                    cycleCount += ((opaddr&0xFF00)!=(addr&0xFF00)?2:1)
                    @REG_PC = addr
                end
            when 4
                # *******
                # * BCS *
                # *******

                # Branch on carry set
                if(@F_CARRY == 1)
                    cycleCount += ((opaddr&0xFF00)!=(addr&0xFF00)?2:1)
                    @REG_PC = addr
                end
            when 5
                # *******
                # * BEQ *
                # *******

                # Branch on zero
                if(@F_ZERO == 0)
                    cycleCount += ((opaddr&0xFF00)!=(addr&0xFF00)?2:1)
                    @REG_PC = addr
                end
            when 6
                # *******
                # * BIT *
                # *******

                temp = self.load(addr)
                @F_SIGN = (temp>>7)&1
                @F_OVERFLOW = (temp>>6)&1
                temp &= @REG_ACC
                @F_ZERO = temp
            when 7
                # *******
                # * BMI *
                # *******

                # Branch on negative result
                if(@F_SIGN == 1)
                    cycleCount+=1
                    @REG_PC = addr
                end
            when 8
                # *******
                # * BNE *
                # *******

                # Branch on not zero
                if(@F_ZERO != 0)
                    cycleCount += ((opaddr&0xFF00)!=(addr&0xFF00)?2:1)
                    @REG_PC = addr
                end
            when 9
                # *******
                # * BPL *
                # *******

                # Branch on positive result
                if(@F_SIGN == 0)
                    cycleCount += ((opaddr&0xFF00)!=(addr&0xFF00)?2:1)
                    @REG_PC = addr
                end

            when 10
                # *******
                # * BRK *
                # *******

                @REG_PC+=2
                self.push((@REG_PC>>8)&255)
                self.push(@REG_PC&255)
                @F_BRK = 1

                self.push(
                    (@F_CARRY)|
                    ((@F_ZERO==0?1:0)<<1)|
                    (@F_INTERRUPT<<2)|
                    (@F_DECIMAL<<3)|
                    (@F_BRK<<4)|
                    (@F_NOTUSED<<5)|
                    (@F_OVERFLOW<<6)|
                    (@F_SIGN<<7)
                )

                @F_INTERRUPT = 1
                #@REG_PC = load(0xFFFE) | (load(0xFFFF) << 8)
                @REG_PC = self.load16bit(0xFFFE)
                @REG_PC -= 1
            when 11
                # *******
                # * BVC *
                # *******

                # Branch on overflow clear
                if(@F_OVERFLOW == 0)
                    cycleCount += ((opaddr&0xFF00)!=(addr&0xFF00)?2:1)
                    @REG_PC = addr
                end
            when 12
                # *******
                # * BVS *
                # *******

                # Branch on overflow set
                if(@F_OVERFLOW == 1)
                    cycleCount += ((opaddr&0xFF00)!=(addr&0xFF00)?2:1)
                    @REG_PC = addr
                end
            when 13
                # *******
                # * CLC *
                # *******

                # Clear carry flag
                @F_CARRY = 0
            when 14
                # *******
                # * CLD *
                # *******

                # Clear decimal flag
                @F_DECIMAL = 0
            when 15
                # *******
                # * CLI *
                # *******

                # Clear interrupt flag
                @F_INTERRUPT = 0
            when 16
                # *******
                # * CLV *
                # *******

                # Clear overflow flag
                @F_OVERFLOW = 0
            when 17
                # *******
                # * CMP *
                # *******

                # Compare memory and accumulator:
                temp = @REG_ACC - self.load(addr)
                @F_CARRY = (temp>=0?1:0)
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp&0xFF
                cycleCount+=cycleAdd
            when 18
                # *******
                # * CPX *
                # *******

                # Compare memory and index X:
                temp = @REG_X - self.load(addr)
                @F_CARRY = (temp>=0?1:0)
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp&0xFF
            when 19
                # *******
                # * CPY *
                # *******

                # Compare memory and index Y:
                temp = @REG_Y - self.load(addr)
                @F_CARRY = (temp>=0?1:0)
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp&0xFF
            when 20
                # *******
                # * DEC *
                # *******

                # Decrement memory by one:
                temp = (self.load(addr)-1)&0xFF
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp
                self.write(addr, temp)
            when 21
                # *******
                # * DEX *
                # *******

                # Decrement index X by one:
                @REG_X = (@REG_X-1)&0xFF
                @F_SIGN = (@REG_X>>7)&1
                @F_ZERO = @REG_X
            when 22
                # *******
                # * DEY *
                # *******

                # Decrement index Y by one:
                @REG_Y = (@REG_Y-1)&0xFF
                @F_SIGN = (@REG_Y>>7)&1
                @F_ZERO = @REG_Y
            when 23
                # *******
                # * EOR *
                # *******

                # XOR Memory with accumulator, store in accumulator:
                @REG_ACC = (self.load(addr)^@REG_ACC)&0xFF
                @F_SIGN = (@REG_ACC>>7)&1
                @F_ZERO = @REG_ACC
                cycleCount+=cycleAdd
            when 24
                # *******
                # * INC *
                # *******

                # Increment memory by one:
                temp = (self.load(addr)+1)&0xFF
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp
                self.write(addr, temp&0xFF)
            when 25
                # *******
                # * INX *
                # *******

                # Increment index X by one:
                @REG_X = (@REG_X+1)&0xFF
                @F_SIGN = (@REG_X>>7)&1
                @F_ZERO = @REG_X
            when 26
                # *******
                # * INY *
                # *******

                # Increment index Y by one:
                @REG_Y++
                @REG_Y &= 0xFF
                @F_SIGN = (@REG_Y>>7)&1
                @F_ZERO = @REG_Y
            when 27
                # *******
                # * JMP *
                # *******

                # Jump to new location:
                @REG_PC = addr-1
            when 28
                # *******
                # * JSR *
                # *******

                # Jump to new location, saving return address.
                # Push return address on stack:
                self.push((@REG_PC>>8)&255)
                self.push(@REG_PC&255)
                @REG_PC = addr-1
            when 29
                # *******
                # * LDA *
                # *******

                # Load accumulator with memory:
                @REG_ACC = self.load(addr)
                @F_SIGN = (@REG_ACC>>7)&1
                @F_ZERO = @REG_ACC
                cycleCount+=cycleAdd
            when 30
                # *******
                # * LDX *
                # *******

                # Load index X with memory:
                @REG_X = self.load(addr)
                @F_SIGN = (@REG_X>>7)&1
                @F_ZERO = @REG_X
                cycleCount+=cycleAdd
            when 31
                # *******
                # * LDY *
                # *******

                # Load index Y with memory:
                @REG_Y = self.load(addr)
                @F_SIGN = (@REG_Y>>7)&1
                @F_ZERO = @REG_Y
                cycleCount+=cycleAdd
            when 32
                # *******
                # * LSR *
                # *******

                # Shift right one bit:
                if(addrMode == 4) # ADDR_ACC
                    temp = (@REG_ACC & 0xFF)
                    @F_CARRY = temp&1
                    temp >>= 1
                    @REG_ACC = temp
                else
                    temp = self.load(addr) & 0xFF
                    @F_CARRY = temp&1
                    temp >>= 1
                    self.write(addr, temp)
                end
                
                @F_SIGN = 0
                @F_ZERO = temp
            when 33
                # *******
                # * NOP *
                # *******

                # No OPeration.
                # Ignore.
            when 34
                # *******
                # * ORA *
                # *******

                # OR memory with accumulator, store in accumulator.
                temp = (self.load(addr)|@REG_ACC)&255
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp
                @REG_ACC = temp

                if(addrMode!=11)
                    cycleCount+=cycleAdd # PostIdxInd = 11
                end
            when 35
                # *******
                # * PHA *
                # *******

                # Push accumulator on stack
                self.push(@REG_ACC)
            when 36
                # *******
                # * PHP *
                # *******

                # Push processor status on stack
                @F_BRK = 1
                self.push(
                    (@F_CARRY)|
                    ((@F_ZERO==0?1:0)<<1)|
                    (@F_INTERRUPT<<2)|
                    (@F_DECIMAL<<3)|
                    (@F_BRK<<4)|
                    (@F_NOTUSED<<5)|
                    (@F_OVERFLOW<<6)|
                    (@F_SIGN<<7)
                )
            when 37
                # *******
                # * PLA *
                # *******

                # Pull accumulator from stack
                @REG_ACC = self.pull()
                @F_SIGN = (@REG_ACC>>7)&1
                @F_ZERO = @REG_ACC

            when 38
                # *******
                # * PLP *
                # *******

                # Pull processor status from stack
                temp = self.pull()
                @F_CARRY     = (temp   )&1
                @F_ZERO      = (((temp>>1)&1)==1)?0:1
                @F_INTERRUPT = (temp>>2)&1
                @F_DECIMAL   = (temp>>3)&1
                @F_BRK       = (temp>>4)&1
                @F_NOTUSED   = (temp>>5)&1
                @F_OVERFLOW  = (temp>>6)&1
                @F_SIGN      = (temp>>7)&1

                @F_NOTUSED = 1
            when 39
                # *******
                # * ROL *
                # *******

                # Rotate one bit left
                if(addrMode == 4) # ADDR_ACC = 4
                    temp = @REG_ACC
                    add = @F_CARRY
                    @F_CARRY = (temp>>7)&1
                    temp = ((temp<<1)&0xFF)+add
                    @REG_ACC = temp
                else
                    temp = self.load(addr)
                    add = @F_CARRY
                    @F_CARRY = (temp>>7)&1
                    temp = ((temp<<1)&0xFF)+add    
                    self.write(addr, temp)
                end
                
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp
            when 40
                # *******
                # * ROR *
                # *******

                # Rotate one bit right
                if(addrMode == 4) # ADDR_ACC = 4

                    add = @F_CARRY<<7
                    @F_CARRY = @REG_ACC&1
                    temp = (@REG_ACC>>1)+add   
                    @REG_ACC = temp
                else
                    temp = self.load(addr)
                    add = @F_CARRY<<7
                    @F_CARRY = temp&1
                    temp = (temp>>1)+add
                    self.write(addr, temp)
                end
                
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp
            when 41
                # *******
                # * RTI *
                # *******

                # Return from interrupt. Pull status and PC from stack.
                
                temp = self.pull()
                @F_CARRY     = (temp   )&1
                @F_ZERO      = ((temp>>1)&1)==0?1:0
                @F_INTERRUPT = (temp>>2)&1
                @F_DECIMAL   = (temp>>3)&1
                @F_BRK       = (temp>>4)&1
                @F_NOTUSED   = (temp>>5)&1
                @F_OVERFLOW  = (temp>>6)&1
                @F_SIGN      = (temp>>7)&1

                @REG_PC = self.pull()
                @REG_PC += (self.pull()<<8)

                if(@REG_PC==0xFFFF)
                    return
                end
                
                @REG_PC--
                @F_NOTUSED = 1
            when 42
                # *******
                # * RTS *
                # *******

                # Return from subroutine. Pull PC from stack.
                
                @REG_PC = self.pull()
                @REG_PC += (self.pull()<<8)
                
                if(@REG_PC==0xFFFF)
                    return # return from NSF play routine:
                end
            when 43
                # *******
                # * SBC *
                # *******

                temp = @REG_ACC-self.load(addr)-(1-@F_CARRY)
                @F_SIGN = (temp>>7)&1
                @F_ZERO = temp&0xFF
                @F_OVERFLOW = ((((@REG_ACC^temp)&0x80)!=0 && ((@REG_ACC^self.load(addr))&0x80)!=0)?1:0)
                @F_CARRY = (temp<0?0:1)
                @REG_ACC = (temp&0xFF)

                if(addrMode!=11)
                    cycleCount+=cycleAdd # PostIdxInd = 11
                end
            when 44
                # *******
                # * SEC *
                # *******

                # Set carry flag
                @F_CARRY = 1
            when 45
                # *******
                # * SED *
                # *******

                # Set decimal mode
                @F_DECIMAL = 1
            when 46
                # *******
                # * SEI *
                # *******

                # Set interrupt disable status
                @F_INTERRUPT = 1
            when 47
                # *******
                # * STA *
                # *******

                # Store accumulator in memory
                self.write(addr, @REG_ACC)
            when 48
                # *******
                # * STX *
                # *******

                # Store index X in memory
                self.write(addr, @REG_X)
            when 49
                # *******
                # * STY *
                # *******

                # Store index Y in memory:
                self.write(addr, @REG_Y)
            when 50
                # *******
                # * TAX *
                # *******

                # Transfer accumulator to index X:
                @REG_X = @REG_ACC
                @F_SIGN = (@REG_ACC>>7)&1
                @F_ZERO = @REG_ACC
            when 51
                # *******
                # * TAY *
                # *******

                # Transfer accumulator to index Y:
                @REG_Y = @REG_ACC
                @F_SIGN = (@REG_ACC>>7)&1
                @F_ZERO = @REG_ACC
            when 52
                # *******
                # * TSX *
                # *******

                # Transfer stack pointer to index X:
                @REG_X = (@REG_SP-0x0100)
                @F_SIGN = (@REG_SP>>7)&1
                @F_ZERO = @REG_X
            when 53
                # *******
                # * TXA *
                # *******

                # Transfer index X to accumulator:
                @REG_ACC = @REG_X
                @F_SIGN = (@REG_X>>7)&1
                @F_ZERO = @REG_X
            when 54
                # *******
                # * TXS *
                # *******

                # Transfer index X to stack pointer:
                @REG_SP = (@REG_X+0x0100)
                self.stack_wrap()
            when 55
                # *******
                # * TYA *
                # *******

                # Transfer index Y to accumulator:
                @REG_ACC = @REG_Y
                @F_SIGN = (@REG_Y>>7)&1
                @F_ZERO = @REG_Y
            else
                # *******
                # * ??? *
                # *******

                @nes.stop()
                @nes.crashMessage = "Game crashed, invalid opcode at address $"+opaddr.toString(16)
            end

        return cycleCount
    end

    JSON_PROPERTIES = [
                        'main_memory', 'cycles_to_halt', 'irq_requested', 'irq_type',
                        # Registers
                        'REG_ACC', 'REG_X', 'REG_Y', 'REG_SP', 'REG_PC', 'REG_PC_NEW',
                        'REG_STATUS',
                        #Status
                        'F_CARRY', 'F_DECIMAL', 'F_INTERRUPT', 'F_INTERRUPT_NEW', 'F_OVERFLOW', 
                        'F_SIGN', 'F_ZERO', 'F_NOTUSED', 'F_NOTUSED_NEW', 'F_BRK', 'F_BRK_NEW'
                      ]
end

