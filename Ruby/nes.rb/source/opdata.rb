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

# Convenient utility class describing the possible operations the CPU can execute.
class OP_DATA

    # These are assembly language instructions.
    INS_ADC = 0
    INS_AND = 1
    INS_ASL = 2
    
    INS_BCC = 3
    INS_BCS = 4
    INS_BEQ = 5
    INS_BIT = 6
    INS_BMI = 7
    INS_BNE = 8
    INS_BPL = 9
    INS_BRK = 10
    INS_BVC = 11
    INS_BVS = 12
    
    INS_CLC = 13
    INS_CLD = 14
    INS_CLI = 15
    INS_CLV = 16
    INS_CMP = 17
    INS_CPX = 18
    INS_CPY = 19
    
    INS_DEC = 20
    INS_DEX = 21
    INS_DEY = 22
    
    INS_EOR = 23
    
    INS_INC = 24
    INS_INX = 25
    INS_INY = 26
    
    INS_JMP = 27
    INS_JSR = 28
    
    INS_LDA = 29
    INS_LDX = 30
    INS_LDY = 31
    INS_LSR = 32
    
    INS_NOP = 33
    
    INS_ORA = 34
    
    INS_PHA = 35
    INS_PHP = 36
    INS_PLA = 37
    INS_PLP = 38
    
    INS_ROL = 39
    INS_ROR = 40
    INS_RTI = 41
    INS_RTS = 42
    
    INS_SBC = 43
    INS_SEC = 44
    INS_SED = 45
    INS_SEI = 46
    INS_STA = 47
    INS_STX = 48
    INS_STY = 49
    
    INS_TAX = 50
    INS_TAY = 51
    INS_TSX = 52
    INS_TXA = 53
    INS_TXS = 54
    INS_TYA = 55
    
    INS_DUMMY = 56 # dummy instruction used for 'halting' the processor some cycles
    
    # Addressing modes:
    ADDR_ZP        = 0
    ADDR_REL       = 1
    ADDR_IMP       = 2
    ADDR_ABS       = 3
    ADDR_ACC       = 4
    ADDR_IMM       = 5
    ADDR_ZPX       = 6
    ADDR_ZPY       = 7
    ADDR_ABSX      = 8
    ADDR_ABSY      = 9
    ADDR_PREIDXIND = 10
    ADDR_POSTIDXIND= 11
    ADDR_INDABS    = 12

    attr_accessor :opdata       # Cache of all the operations the CPU can perform.
    attr_accessor :cyc_table    #
    attr_accessor :inst_name    # Instruction Names.
    attr_accessor :address_desc # Address descriptions.

    def initialize

         @opdata = Array.new(256)
     
        # Set all to invalid instruction (to detect crashes):
        for i in 1..256
            @opdata[i] = 0xFF
        end
    
        # Now fill in all valid opcodes:
    
        # ADC:
        self.set_op(INS_ADC,0x69,ADDR_IMM,2,2)
        self.set_op(INS_ADC,0x65,ADDR_ZP,2,3)
        self.set_op(INS_ADC,0x75,ADDR_ZPX,2,4)
        self.set_op(INS_ADC,0x6D,ADDR_ABS,3,4)
        self.set_op(INS_ADC,0x7D,ADDR_ABSX,3,4)
        self.set_op(INS_ADC,0x79,ADDR_ABSY,3,4)
        self.set_op(INS_ADC,0x61,ADDR_PREIDXIND,2,6)
        self.set_op(INS_ADC,0x71,ADDR_POSTIDXIND,2,5)
    
        # AND:
        self.set_op(INS_AND,0x29,ADDR_IMM,2,2)
        self.set_op(INS_AND,0x25,ADDR_ZP,2,3)
        self.set_op(INS_AND,0x35,ADDR_ZPX,2,4)
        self.set_op(INS_AND,0x2D,ADDR_ABS,3,4)
        self.set_op(INS_AND,0x3D,ADDR_ABSX,3,4)
        self.set_op(INS_AND,0x39,ADDR_ABSY,3,4)
        self.set_op(INS_AND,0x21,ADDR_PREIDXIND,2,6)
        self.set_op(INS_AND,0x31,ADDR_POSTIDXIND,2,5)
        
        # ASL:
        self.set_op(INS_ASL,0x0A,ADDR_ACC,1,2)
        self.set_op(INS_ASL,0x06,ADDR_ZP,2,5)
        self.set_op(INS_ASL,0x16,ADDR_ZPX,2,6)
        self.set_op(INS_ASL,0x0E,ADDR_ABS,3,6)
        self.set_op(INS_ASL,0x1E,ADDR_ABSX,3,7)
        
        # BCC:
        self.set_op(INS_BCC,0x90,ADDR_REL,2,2)
        
        # BCS:
        self.set_op(INS_BCS,0xB0,ADDR_REL,2,2)
        
        # BEQ:
        self.set_op(INS_BEQ,0xF0,ADDR_REL,2,2)
        
        # BIT:
        self.set_op(INS_BIT,0x24,ADDR_ZP,2,3)
        self.set_op(INS_BIT,0x2C,ADDR_ABS,3,4)
        
        # BMI:
        self.set_op(INS_BMI,0x30,ADDR_REL,2,2)
        
        # BNE:
        self.set_op(INS_BNE,0xD0,ADDR_REL,2,2)
        
        # BPL:
        self.set_op(INS_BPL,0x10,ADDR_REL,2,2)
        
        # BRK:
        self.set_op(INS_BRK,0x00,ADDR_IMP,1,7)
        
        # BVC:
        self.set_op(INS_BVC,0x50,ADDR_REL,2,2)
        
        # BVS:
        self.set_op(INS_BVS,0x70,ADDR_REL,2,2)
        
        # CLC:
        self.set_op(INS_CLC,0x18,ADDR_IMP,1,2)
        
        # CLD:
        self.set_op(INS_CLD,0xD8,ADDR_IMP,1,2)
        
        # CLI:
        self.set_op(INS_CLI,0x58,ADDR_IMP,1,2)
        
        # CLV:
        self.set_op(INS_CLV,0xB8,ADDR_IMP,1,2)
        
        # CMP:
        self.set_op(INS_CMP,0xC9,ADDR_IMM,2,2)
        self.set_op(INS_CMP,0xC5,ADDR_ZP,2,3)
        self.set_op(INS_CMP,0xD5,ADDR_ZPX,2,4)
        self.set_op(INS_CMP,0xCD,ADDR_ABS,3,4)
        self.set_op(INS_CMP,0xDD,ADDR_ABSX,3,4)
        self.set_op(INS_CMP,0xD9,ADDR_ABSY,3,4)
        self.set_op(INS_CMP,0xC1,ADDR_PREIDXIND,2,6)
        self.set_op(INS_CMP,0xD1,ADDR_POSTIDXIND,2,5)
        
        # CPX:
        self.set_op(INS_CPX,0xE0,ADDR_IMM,2,2)
        self.set_op(INS_CPX,0xE4,ADDR_ZP,2,3)
        self.set_op(INS_CPX,0xEC,ADDR_ABS,3,4)
        
        # CPY:
        self.set_op(INS_CPY,0xC0,ADDR_IMM,2,2)
        self.set_op(INS_CPY,0xC4,ADDR_ZP,2,3)
        self.set_op(INS_CPY,0xCC,ADDR_ABS,3,4)
        
        # DEC:
        self.set_op(INS_DEC,0xC6,ADDR_ZP,2,5)
        self.set_op(INS_DEC,0xD6,ADDR_ZPX,2,6)
        self.set_op(INS_DEC,0xCE,ADDR_ABS,3,6)
        self.set_op(INS_DEC,0xDE,ADDR_ABSX,3,7)
        
        # DEX:
        self.set_op(INS_DEX,0xCA,ADDR_IMP,1,2)
        
        # DEY:
        self.set_op(INS_DEY,0x88,ADDR_IMP,1,2)
        
        # EOR:
        self.set_op(INS_EOR,0x49,ADDR_IMM,2,2)
        self.set_op(INS_EOR,0x45,ADDR_ZP,2,3)
        self.set_op(INS_EOR,0x55,ADDR_ZPX,2,4)
        self.set_op(INS_EOR,0x4D,ADDR_ABS,3,4)
        self.set_op(INS_EOR,0x5D,ADDR_ABSX,3,4)
        self.set_op(INS_EOR,0x59,ADDR_ABSY,3,4)
        self.set_op(INS_EOR,0x41,ADDR_PREIDXIND,2,6)
        self.set_op(INS_EOR,0x51,ADDR_POSTIDXIND,2,5)
        
        # INC:
        self.set_op(INS_INC,0xE6,ADDR_ZP,2,5)
        self.set_op(INS_INC,0xF6,ADDR_ZPX,2,6)
        self.set_op(INS_INC,0xEE,ADDR_ABS,3,6)
        self.set_op(INS_INC,0xFE,ADDR_ABSX,3,7)
        
        # INX:
        self.set_op(INS_INX,0xE8,ADDR_IMP,1,2)
        
        # INY:
        self.set_op(INS_INY,0xC8,ADDR_IMP,1,2)
        
        # JMP:
        self.set_op(INS_JMP,0x4C,ADDR_ABS,3,3)
        self.set_op(INS_JMP,0x6C,ADDR_INDABS,3,5)
        
        # JSR:
        self.set_op(INS_JSR,0x20,ADDR_ABS,3,6)
        
        # LDA:
        self.set_op(INS_LDA,0xA9,ADDR_IMM,2,2)
        self.set_op(INS_LDA,0xA5,ADDR_ZP,2,3)
        self.set_op(INS_LDA,0xB5,ADDR_ZPX,2,4)
        self.set_op(INS_LDA,0xAD,ADDR_ABS,3,4)
        self.set_op(INS_LDA,0xBD,ADDR_ABSX,3,4)
        self.set_op(INS_LDA,0xB9,ADDR_ABSY,3,4)
        self.set_op(INS_LDA,0xA1,ADDR_PREIDXIND,2,6)
        self.set_op(INS_LDA,0xB1,ADDR_POSTIDXIND,2,5)
        
        # LDX:
        self.set_op(INS_LDX,0xA2,ADDR_IMM,2,2)
        self.set_op(INS_LDX,0xA6,ADDR_ZP,2,3)
        self.set_op(INS_LDX,0xB6,ADDR_ZPY,2,4)
        self.set_op(INS_LDX,0xAE,ADDR_ABS,3,4)
        self.set_op(INS_LDX,0xBE,ADDR_ABSY,3,4)
        
        # LDY:
        self.set_op(INS_LDY,0xA0,ADDR_IMM,2,2)
        self.set_op(INS_LDY,0xA4,ADDR_ZP,2,3)
        self.set_op(INS_LDY,0xB4,ADDR_ZPX,2,4)
        self.set_op(INS_LDY,0xAC,ADDR_ABS,3,4)
        self.set_op(INS_LDY,0xBC,ADDR_ABSX,3,4)
        
        # LSR:
        self.set_op(INS_LSR,0x4A,ADDR_ACC,1,2)
        self.set_op(INS_LSR,0x46,ADDR_ZP,2,5)
        self.set_op(INS_LSR,0x56,ADDR_ZPX,2,6)
        self.set_op(INS_LSR,0x4E,ADDR_ABS,3,6)
        self.set_op(INS_LSR,0x5E,ADDR_ABSX,3,7)
        
        # NOP:
        self.set_op(INS_NOP,0xEA,ADDR_IMP,1,2)
        
        # ORA:
        self.set_op(INS_ORA,0x09,ADDR_IMM,2,2)
        self.set_op(INS_ORA,0x05,ADDR_ZP,2,3)
        self.set_op(INS_ORA,0x15,ADDR_ZPX,2,4)
        self.set_op(INS_ORA,0x0D,ADDR_ABS,3,4)
        self.set_op(INS_ORA,0x1D,ADDR_ABSX,3,4)
        self.set_op(INS_ORA,0x19,ADDR_ABSY,3,4)
        self.set_op(INS_ORA,0x01,ADDR_PREIDXIND,2,6)
        self.set_op(INS_ORA,0x11,ADDR_POSTIDXIND,2,5)
        
        # PHA:
        self.set_op(INS_PHA,0x48,ADDR_IMP,1,3)
        
        # PHP:
        self.set_op(INS_PHP,0x08,ADDR_IMP,1,3)
        
        # PLA:
        self.set_op(INS_PLA,0x68,ADDR_IMP,1,4)
        
        # PLP:
        self.set_op(INS_PLP,0x28,ADDR_IMP,1,4)
        
        # ROL:
        self.set_op(INS_ROL,0x2A,ADDR_ACC,1,2)
        self.set_op(INS_ROL,0x26,ADDR_ZP,2,5)
        self.set_op(INS_ROL,0x36,ADDR_ZPX,2,6)
        self.set_op(INS_ROL,0x2E,ADDR_ABS,3,6)
        self.set_op(INS_ROL,0x3E,ADDR_ABSX,3,7)
        
        # ROR:
        self.set_op(INS_ROR,0x6A,ADDR_ACC,1,2)
        self.set_op(INS_ROR,0x66,ADDR_ZP,2,5)
        self.set_op(INS_ROR,0x76,ADDR_ZPX,2,6)
        self.set_op(INS_ROR,0x6E,ADDR_ABS,3,6)
        self.set_op(INS_ROR,0x7E,ADDR_ABSX,3,7)
        
        # RTI:
        self.set_op(INS_RTI,0x40,ADDR_IMP,1,6)
        
        # RTS:
        self.set_op(INS_RTS,0x60,ADDR_IMP,1,6)
        
        # SBC:
        self.set_op(INS_SBC,0xE9,ADDR_IMM,2,2)
        self.set_op(INS_SBC,0xE5,ADDR_ZP,2,3)
        self.set_op(INS_SBC,0xF5,ADDR_ZPX,2,4)
        self.set_op(INS_SBC,0xED,ADDR_ABS,3,4)
        self.set_op(INS_SBC,0xFD,ADDR_ABSX,3,4)
        self.set_op(INS_SBC,0xF9,ADDR_ABSY,3,4)
        self.set_op(INS_SBC,0xE1,ADDR_PREIDXIND,2,6)
        self.set_op(INS_SBC,0xF1,ADDR_POSTIDXIND,2,5)
        
        # SEC:
        self.set_op(INS_SEC,0x38,ADDR_IMP,1,2)
        
        # SED:
        self.set_op(INS_SED,0xF8,ADDR_IMP,1,2)
        
        # SEI:
        self.set_op(INS_SEI,0x78,ADDR_IMP,1,2)
        
        # STA:
        self.set_op(INS_STA,0x85,ADDR_ZP,2,3)
        self.set_op(INS_STA,0x95,ADDR_ZPX,2,4)
        self.set_op(INS_STA,0x8D,ADDR_ABS,3,4)
        self.set_op(INS_STA,0x9D,ADDR_ABSX,3,5)
        self.set_op(INS_STA,0x99,ADDR_ABSY,3,5)
        self.set_op(INS_STA,0x81,ADDR_PREIDXIND,2,6)
        self.set_op(INS_STA,0x91,ADDR_POSTIDXIND,2,6)
        
        # STX:
        self.set_op(INS_STX,0x86,ADDR_ZP,2,3)
        self.set_op(INS_STX,0x96,ADDR_ZPY,2,4)
        self.set_op(INS_STX,0x8E,ADDR_ABS,3,4)
        
        # STY:
        self.set_op(INS_STY,0x84,ADDR_ZP,2,3)
        self.set_op(INS_STY,0x94,ADDR_ZPX,2,4)
        self.set_op(INS_STY,0x8C,ADDR_ABS,3,4)
        
        # TAX:
        self.set_op(INS_TAX,0xAA,ADDR_IMP,1,2)
        
        # TAY:
        self.set_op(INS_TAY,0xA8,ADDR_IMP,1,2)
        
        # TSX:
        self.set_op(INS_TSX,0xBA,ADDR_IMP,1,2)
        
        # TXA:
        self.set_op(INS_TXA,0x8A,ADDR_IMP,1,2)
        
        # TXS:
        self.set_op(INS_TXS,0x9A,ADDR_IMP,1,2)
        
        # TYA:
        self.set_op(INS_TYA,0x98,ADDR_IMP,1,2)
        
        @cyc_table = [
                         7,6,2,8,3,3,5,5,3,2,2,2,4,4,6,6, #0x00
                         2,5,2,8,4,4,6,6,2,4,2,7,4,4,7,7, #0x10
                         6,6,2,8,3,3,5,5,4,2,2,2,4,4,6,6, #etc...
                         2,5,2,8,4,4,6,6,2,4,2,7,4,4,7,7,
                         6,6,2,8,3,3,5,5,3,2,2,2,3,4,6,6,
                         2,5,2,8,4,4,6,6,2,4,2,7,4,4,7,7,
                         6,6,2,8,3,3,5,5,4,2,2,2,5,4,6,6,
                         2,5,2,8,4,4,6,6,2,4,2,7,4,4,7,7,
                         2,6,2,6,3,3,3,3,2,2,2,2,4,4,4,4,
                         2,6,2,6,4,4,4,4,2,5,2,5,5,5,5,5,
                         2,6,2,6,3,3,3,3,2,2,2,2,4,4,4,4,
                         2,5,2,5,4,4,4,4,2,4,2,4,4,4,4,4,
                         2,6,2,8,3,3,5,5,2,2,2,2,4,4,6,6,
                         2,5,2,8,4,4,6,6,2,4,2,7,4,4,7,7,
                         2,6,3,8,3,3,5,5,2,2,2,2,4,4,6,6,
                         2,5,2,8,4,4,6,6,2,4,2,7,4,4,7,7
                    ]
        
        @inst_name = Array.new(56)
        
        # Instruction Names:
        @instname[ 0] = "ADC"
        @instname[ 1] = "AND"
        @instname[ 2] = "ASL"
        @instname[ 3] = "BCC"
        @instname[ 4] = "BCS"
        @instname[ 5] = "BEQ"
        @instname[ 6] = "BIT"
        @instname[ 7] = "BMI"
        @instname[ 8] = "BNE"
        @instname[ 9] = "BPL"
        @instname[10] = "BRK"
        @instname[11] = "BVC"
        @instname[12] = "BVS"
        @instname[13] = "CLC"
        @instname[14] = "CLD"
        @instname[15] = "CLI"
        @instname[16] = "CLV"
        @instname[17] = "CMP"
        @instname[18] = "CPX"
        @instname[19] = "CPY"
        @instname[20] = "DEC"
        @instname[21] = "DEX"
        @instname[22] = "DEY"
        @instname[23] = "EOR"
        @instname[24] = "INC"
        @instname[25] = "INX"
        @instname[26] = "INY"
        @instname[27] = "JMP"
        @instname[28] = "JSR"
        @instname[29] = "LDA"
        @instname[30] = "LDX"
        @instname[31] = "LDY"
        @instname[32] = "LSR"
        @instname[33] = "NOP"
        @instname[34] = "ORA"
        @instname[35] = "PHA"
        @instname[36] = "PHP"
        @instname[37] = "PLA"
        @instname[38] = "PLP"
        @instname[39] = "ROL"
        @instname[40] = "ROR"
        @instname[41] = "RTI"
        @instname[42] = "RTS"
        @instname[43] = "SBC"
        @instname[44] = "SEC"
        @instname[45] = "SED"
        @instname[46] = "SEI"
        @instname[47] = "STA"
        @instname[48] = "STX"
        @instname[49] = "STY"
        @instname[50] = "TAX"
        @instname[51] = "TAY"
        @instname[52] = "TSX"
        @instname[53] = "TXA"
        @instname[54] = "TXS"
        @instname[55] = "TYA"
        
        # Set the address descriptions.
        @address_desc = [
                            "Zero Page           ",
                            "Relative            ",
                            "Implied             ",
                            "Absolute            ",
                            "Accumulator         ",
                            "Immediate           ",
                            "Zero Page,X         ",
                            "Zero Page,Y         ",
                            "Absolute,X          ",
                            "Absolute,Y          ",
                            "Preindexed Indirect ",
                            "Postindexed Indirect",
                            "Indirect Absolute   "
                        ]
    end

    # Set an operation in the op data instruction table.
    def set_op(inst, op, addr, size, cycles)

        @opdata[op] = 
            ((inst  &0xFF)    )| 
            ((addr  &0xFF)<< 8)| 
            ((size  &0xFF)<<16)| 
            ((cycles&0xFF)<<24)
    end
end