=begin
JSNES, based on Jamie Sanders' vNES
Copyright (C) 2010 Ben Firshman

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http:#www.gnu.org/licenses/>.
=end

class PPU

    # Status flags:
    STATUS_VRAMWRITE = 4
    STATUS_SLSPRITECOUNT = 5
    STATUS_SPRITE0HIT = 6
    STATUS_VBLANK = 7

    attr_accessor :nes
    attr_accessor :show_spr0_hit0_hit
    attr_accessor :clip_to_tv_size
    attr_accessor :vram_mem 
    attr_accessor :sprite_mem ,
                  :vram_address, 
                  :vram_tmp_address, 
                  :vram_buffered_read_value, 
                  :first_write, 
                  :sram_address,
                  :request_end_frame,
                  :nmiOk,
                  :dummy_cycle_toggle,
                  :nmi_counter,
                  :scan_line_already_rendered,
                  :f_nmi_on_vblank,
                  :f_nmi_on_vblank,
                  :f_sprite_size,
                  :f_bg_pattern_table,
                  :f_sp_pattern_table,
                  :f_addr_inc,
                  :f_n_tbl_address,
                  :f_color,    
                  :f_sp_visibility,
                  :f_bg_visibility,
                  :f_sp_clipping,
                  :f_bg_clipping,
                  :f_disp_type,  
                  :cnt_FV,
                  :cnt_V,
                  :cnt_H,
                  :cnt_VT,
                  :cnt_HT,
                  :reg_FV,
                  :reg_V,
                  :reg_H, 
                  :reg_VT,
                  :reg_HT,
                  :reg_FH,
                  :reg_S,
                  :cur_Nt,
                  :attrib,
                  :buffer,
                  :prev_buffer,
                  :bg_buffer,
                  :pix_rendered,
                  :valid_tile_data,
                  :scan_tile,
                  :scan_line,
                  :last_rendered_scan_line,
                  :cur_X,
                  :sprite_X,
                  :sprite_Y,
                  :sprite_tile,
                  :spr_col,
                  :vert_flip,
                  :hori_flip,
                  :bg_priority,
                  :spr0_hit_X ,
                  :spr0_hit_Y,
                  :hit_spr0,
                  :sprite_palette,
                  :img_palette,
                  :pt_tile,
                  :ntable1,
                  :current_mirroring,
                  :name_table,
                  :vram_mirror_table,
                  :pal_table

    def initialize(nes)
        @nes = nes
        
        # Rendering Options
        @show_spr0_hit0_hit = false
        @clip_to_tv_size = true
        
        self.reset()
    end

    def reset 
        
        # Memory
        @vram_mem =  Array.new(0x8000)
        @sprite_mem =  Array.new(0x100)

        i = 0
        while (i < @vram_mem.length)
            @vram_mem[i] = 0
            i+=1
        end

        i = 0
        while (i < @sprite_mem.length)
            @sprite_mem[i] = 0
            i+=1
        end
        
        # VRAM I/O:
        @vram_address = null
        @vram_tmp_address = null
        @vram_buffered_read_value = 0
        @first_write = true       # VRAM/Scroll Hi/Lo latch

        # SPR-RAM I/O:
        @sram_address = 0 # 8-bit only.
        
        @current_mirroring = -1
        @request_end_frame = false
        @nmiOk = false
        @dummy_cycle_toggle = false
        @valid_tile_data = false
        @nmi_counter = 0
        @scan_line_already_rendered = null
        
        # Control Flags Register 1:
        @f_nmi_on_vblank = 0    # NMI on VBlank. 0=disable, 1=enable
        @f_sprite_size = 0     # Sprite size. 0=8x8, 1=8x16
        @f_bg_pattern_table = 0 # Background Pattern Table address. 0=0x0000,1=0x1000
        @f_sp_pattern_table = 0 # Sprite Pattern Table address. 0=0x0000,1=0x1000
        @f_addr_inc = 0        # PPU Address Increment. 0=1,1=32
        @f_n_tbl_address = 0    # Name Table Address. 0=0x2000,1=0x2400,2=0x2800,3=0x2C00
        
        # Control Flags Register 2:
        @f_color = 0         # Background color. 0=black, 1=blue, 2=green, 4=red
        @f_sp_visibility = 0   # Sprite visibility. 0=not displayed,1=displayed
        @f_bg_visibility = 0   # Background visibility. 0=Not Displayed,1=displayed
        @f_sp_clipping = 0     # Sprite clipping. 0=Sprites invisible in left 8-pixel column,1=No clipping
        @f_bg_clipping = 0     # Background clipping. 0=BG invisible in left 8-pixel column, 1=No clipping
        @f_disp_type = 0       # Display type. 0=color, 1=monochrome
        
        # Counters:
        @cnt_FV = 0
        @cnt_V = 0
        @cnt_H = 0
        @cnt_VT = 0
        @cnt_HT = 0
        
        # Registers:
        @reg_FV = 0
        @reg_V = 0
        @reg_H = 0
        @reg_VT = 0
        @reg_HT = 0
        @reg_FH = 0
        @reg_S = 0
        
        # These are temporary self.write_memiables used in rendering and sound procedures.
        # Their states outside of those procedures can be ignored.
        # TODO: the use of this is a bit weird, investigate
        @cur_Nt = null
        
        # self.write_memiables used when rendering:
        @attrib = Array.new(32)
        @buffer = Array.new(256*240)
        @prev_buffer = Array.new(256*240)
        @bg_buffer = Array.new(256*240)
        @pix_rendered = Array.new(256*240)

        @valid_tile_data = null

        @scan_tile = Array.new(32)
        
        # Initialize misc self.write_mems:
        @scan_line= 0
        @last_rendered_scan_line = -1
        @cur_X = 0
        
        # Sprite data:
        @sprite_X = Array.new(64) # X coordinate
        @sprite_Y = Array.new(64) # Y coordinate
        @sprite_tile = Array.new(64) # Tile Index (into pattern table)
        @spr_col = Array.new(64) # Upper two bits of color
        @vert_flip = Array.new(64) # Vertical Flip
        @hori_flip = Array.new(64) # Horizontal Flip
        @bg_priority = Array.new(64) # Background priority
        @spr0_hit_X = 0 # Sprite #0 hit X coordinate
        @spr0_hit_Y = 0 # Sprite #0 hit Y coordinate
        @hit_spr0 = false
        
        # Palette data:
        @sprite_palette = Array.new(16)
        @img_palette = Array.new(16)
        
        # Create pattern table tile buffers:
        @pt_tile = Array.new(512)

        i = 0
        while( i < 512)
            @pt_tile[i] = new JSNES.PPU.Tile()
            i+=1
        end
        
        # Create name_table buffers:
        # Name table data:
        @ntable1 = Array.new(4)
        @current_mirroring = -1
        @name_table = Array.new(4)

        i = 0
        while(i < 4)
            @name_table[i] = new JSNES.PPU.name_table(32, 32, "Nt"+i)
            i+=1
        end
        
        # Initialize mirroring lookup table:
        @vram_mirror_table = Array.new(0x8000)

        i = 0
        while( i < 0x8000) 
            @vram_mirror_table[i] = i
            i+=1
        end
        
        @pal_table = new JSNES.PPU.PaletteTable()
        @pal_table.load_NTSC_palette()
        #@pal_table.load_default_palette()
        
        self.update_control_reg1(0)
        self.update_control_reg2(0)
    },
    
    # Sets name_table mirroring.
    def set_mirroring(mirroring)
    
        if (mirroring == @current_mirroring)
            return
        end
        
        @current_mirroring = mirroring
        self.trigger_rendering()
    
        # Remove mirroring:
        if (@vram_mirror_table === null)
            @vram_mirror_table = Array.new(0x8000)
        end

        i=0
        while (i<0x8000) 
            @vram_mirror_table[i] = i
            i += 1
        end
        
        # Palette mirroring:
        self.define_mirror_region(0x3f20,0x3f00,0x20)
        self.define_mirror_region(0x3f40,0x3f00,0x20)
        self.define_mirror_region(0x3f80,0x3f00,0x20)
        self.define_mirror_region(0x3fc0,0x3f00,0x20)
        
        # Additional mirroring:
        self.define_mirror_region(0x3000,0x2000,0xf00)
        self.define_mirror_region(0x4000,0x0000,0x4000)

        case mirroring
            when @nes.rom.HORIZONTAL_MIRRORING
                # Horizontal mirroring.
                @ntable1[0] = 0
                @ntable1[1] = 0
                @ntable1[2] = 1
                @ntable1[3] = 1
                
                self.define_mirror_region(0x2400,0x2000,0x400)
                self.define_mirror_region(0x2c00,0x2800,0x400)
            when @nes.rom.VERTICAL_MIRRORING
                 # Vertical mirroring.
                @ntable1[0] = 0
                @ntable1[1] = 1
                @ntable1[2] = 0
                @ntable1[3] = 1
                
                self.define_mirror_region(0x2800,0x2000,0x400)
                self.define_mirror_region(0x2c00,0x2400,0x400)
            when @nes.rom.SINGLESCREEN_MIRRORING
                # Single Screen mirroring
                
                @ntable1[0] = 0
                @ntable1[1] = 0
                @ntable1[2] = 0
                @ntable1[3] = 0
                
                self.define_mirror_region(0x2400,0x2000,0x400)
                self.define_mirror_region(0x2800,0x2000,0x400)
                self.define_mirror_region(0x2c00,0x2000,0x400)
            else 
                # Assume Four-screen mirroring.
                
                @ntable1[0] = 0
                @ntable1[1] = 1
                @ntable1[2] = 2
                @ntable1[3] = 3
        end
    end
    
    # Define a mirrored area in the address lookup table.
    # Assumes the regions don't overlap.
    # The 'to' region is the region that is physically in memory.
    def define_mirror_region(from_start, to_start, size)

        i=0
        while (i<sizei)
            @vram_mirror_table[from_start+i] = to_start+i
            i+=1
        end
    end
    
    def start_v_blank
        
        # Do NMI:
        @nes.cpu.request_irq(@nes.cpu.IRQ_NMI)
        
        # Make sure everything is rendered:
        if (@last_rendered_scan_line < 239)
            @render_frame_partially(
                @last_rendered_scan_line+1,240-@last_rendered_scan_line
            )
        end
        
        # End frame:
        self.end_frame()
        
        # Reset scan_line counter:
        @last_rendered_scan_line = -1
    end
    
    def end_scan_line

        case (@scan_line)
            when 19
                # Dummy scan_line.
                # May be self.write_memiable length:
                if (@dummy_cycle_toggle)

                    # Remove dead cycle at end of scan_line,
                    # for next scan_line:
                    @cur_X = 1
                    @dummy_cycle_toggle = !@dummy_cycle_toggle
                end
            when 20
                # Clear VBlank flag:
                self.setStatusFlag(@STATUS_VBLANK,false)

                # Clear Sprite #0 hit flag:
                self.set_status_flag(@STATUS_SPRITE0HIT,false)
                @hit_spr0 = false
                @spr0_hit_X = -1
                @spr0_hit_Y = -1

                if (@f_bg_visibility == 1 || @f_sp_visibility==1)

                    # Update counters:
                    @cnt_FV = @reg_FV
                    @cnt_V = @reg_V
                    @cnt_H = @reg_H
                    @cnt_VT = @reg_VT
                    @cnt_HT = @reg_HT

                    if (@f_bg_visibility==1)
                        # Render dummy scan_line:
                        self.render_bg_scan_line(false,0)
                    end
                end

                if (@f_bg_visibility==1 && @f_sp_visibility==1)
                    # Check sprite 0 hit for first scan_line:
                    self.check_sprite0(0)
                end

                if (@f_bg_visibility==1 || @f_sp_visibility==1)
                    # Clock mapper IRQ Counter:
                    @nes.mmap.clock_irq_counter()
                end
            when 261
                # Dead scan_line, no rendering.
                # Set VINT:
                self.set_status_flag(@STATUS_VBLANK,true)
                @request_end_frame = true
                @nmi_counter = 9
            
                # Wrap around:
                @scan_line= -1 # will be incremented to 0
            else
                if (@scan_line>= 21 && @scan_line<= 260)

                    # Render normally:
                    if (@f_bg_visibility == 1)

                        if (!@scan_line_already_rendered)
                            # update scroll:
                            @cnt_HT = @reg_HT
                            @cnt_H = @reg_H
                            self.render_bg_scan_line(true,@scan_line+1-21)
                        end
                        @scan_line_already_rendered=false

                        # Check for sprite 0 (next scan_line):
                        if (!@hit_spr0 && @f_sp_visibility == 1)
                            if (@sprite_X[0] >= -7 &&
                                    @sprite_X[0] < 256 &&
                                    @sprite_Y[0] + 1 <= (@scan_line- 20) &&
                                    (@sprite_Y[0] + 1 + (
                                        @f_sprite_size === 0 ? 8 : 16
                                    )) >= (@scan_line- 20))
                                if (self.check_sprite0(@scan_line- 20))
                                    @hit_spr0 = true
                                end
                            end
                        end

                    end

                    if (@f_bg_visibility==1 || @f_sp_visibility==1)
                        # Clock mapper IRQ Counter:
                        @nes.mmap.clock_irq_counter()
                    end
                end
        end
        
        @scan_line+=1
        self.regs_to_address()
        self.cnts_to_address()
        
    end
    
    def start_frame
        # Set background color:
        bg_color=0
        
        if (@f_disp_type === 0)
            # Color display.
            # f_color determines color emphasis.
            # Use first entry of image palette as BG color.
            bg_color = @img_palette[0]
        else
            # Monochrome display.
            # f_color determines the bg color.
            case (@f_color) 
                case 0
                    # Black
                    bg_color = 0x00000
                case 1
                    # Green
                    bg_color = 0x00FF00
                case 2
                    # Blue
                    bg_color = 0xFF0000
                case 3
                    # Invalid. Use black.
                    bg_color = 0x000000
                case 4
                    # Red
                    bg_color = 0x0000FF
                else
                    # Invalid. Use black.
                    bg_color = 0x0
            end
        end
        
        buffer = @buffer
        i=0
        while( i<256*240 )
            buffer[i] = bg_color
            i+=1
        end

        pix_rendered = @pix_rendered

        i=0
        while(i<pix_rendered.length )
            pix_rendered[i]=65
            i +=1
        end
    end
    
    def end_frame
        i, x, y = 0
        buffer = @buffer
        
        # Draw spr#0 hit coordinates:
        if (@show_spr0_hit)
            # Spr 0 position:
            if (@sprite_X[0] >= 0 && @sprite_X[0] < 256 &&
                    @sprite_Y[0] >= 0 && @sprite_Y[0] < 240)

                i=0
                while (i<256)
                    buffer[(@sprite_Y[0]<<8)+i] = 0xFF5555
                    i+=1
                end

                i=0
                while (i<240)
                    buffer[(i<<8)+@sprite_X[0]] = 0xFF5555
                    i+=1
                end
            end
            # Hit position:
            if (@spr0_hit_X >= 0 && @spr0_hit_X < 256 &&
                    @spr0_hit_Y >= 0 && @spr0_hit_Y < 240)

                i=0
                while (i<256)
                    buffer[(@spr0_hit_Y<<8)+i] = 0x55FF55
                    i+=1
                end

                i=0
                while (i<240)
                    buffer[(i<<8)+@spr0_hit_X] = 0x55FF55
                    i+=1
                end
            end
        end
        
        # This is a bit lazy..
        # if either the sprites or the background should be clipped,
        # both are clipped after rendering is finished.
        if (@clip_to_tv_size || @f_bg_clipping === 0 || @f_sp_clipping === 0) 
            # Clip left 8-pixels column:
            for (y=0y<240y+=1) 
                for (x=0x<8x+=1) 
                    buffer[(y<<8)+x] = 0
                end
            end
        end
        
        if (@clip_to_tv_size) 
            # Clip right 8-pixels column too:
            y=0
            while (y<240) 

                x=0
                while (x<8) 
                    buffer[(y<<8)+255-x] = 0
                    x+=1
                end

                y+=1
            end
        end
        
        # Clip top and bottom 8 pixels:
        if (@clip_to_tv_size)

            y=0
            while (y<8 )

                x=0
                while (x<256)
                    buffer[(y<<8)+x] = 0
                    buffer[((239-y)<<8)+x] = 0
                    x+=1
                end
                y+=1
            end
        end
        
        if (@nes.opts.show_display)
            @nes.ui.write_frame(buffer, @prev_buffer)
        end
    end
    
    def update_control_reg1(value)
        
        self.trigger_rendering()
        
        @f_nmi_on_vblank =     (value>>7)&1
        @f_sprite_size =       (value>>5)&1
        @f_bg_pattern_table =  (value>>4)&1
        @f_sp_pattern_table =  (value>>3)&1
        @f_addr_inc =          (value>>2)&1
        @f_n_tbl_address =     value&3
        
        @reg_V =  (value>>1)&1
        @reg_H =  value&1
        @reg_S =  (value>>4)&1
        
    end
    
    def update_control_reg2(value)
        
        self.trigger_rendering()
        
        @f_color =         (value>>5)&7
        @f_sp_visibility = (value>>4)&1
        @f_bg_visibility = (value>>3)&1
        @f_sp_clipping =   (value>>2)&1
        @f_bg_clipping =   (value>>1)&1
        @f_disp_type =      value&1
        
        if (@f_disp_type === 0)
            @pal_table.set_emphasis(@f_color)
        end
        
        self.update_palettes()
    end
    
    def set_status_flag(flag, value)
        n = 1<<flag
        @nes.cpu.main_memory[0x2002] = 
            ((@nes.cpu.main_memory[0x2002] & (255-n)) | (value?n:0))
    end
    
    # CPU Register $2002:
    # Read the Status Register.
    def read_status_register
        
        tmp = @nes.cpu.main_memory[0x2002]
        
        # Reset scroll & VRAM Address toggle:
        @first_write = true
        
        # Clear VBlank flag:
        self.set_status_flag(@STATUS_VBLANK,false)
        
        # Fetch status data:
        return tmp
        
    end
    
    # CPU Register $2003:
    # Write the SPR-RAM address that is used for sramWrite (Register 0x2004 in CPU memory map)
    def write_SRAM_address(address)
        @sram_address = address
    end
    
    # CPU Register $2004 (R):
    # Read from SPR-RAM (Sprite RAM).
    # The address should be set first.
    def sram_load
        =begin
            short tmp = sprMem.load(@sram_address)
            @sram_address+=1 # Increment address
            @sram_address%=0x100
            return tmp
        =end
        return @sprite_mem[@sram_address]
    end
    
    # CPU Register $2004 (W):
    # Write to SPR-RAM (Sprite RAM).
    # The address should be set first.
    def sram_write(value)
        @sprite_mem[@sram_address] = value
        sprite_ram_write_update(@sram_address,value)
        @sram_address+=1 # Increment address
        @sram_address %= 0x100
    end
    
    # CPU Register $2005:
    # Write to scroll registers.
    # The first write is the vertical offset, the second is the
    # horizontal offset:
    def scroll_write(value)
        self.trigger_rendering()
        
        if (@first_write)
            # First write, horizontal scroll:
            @reg_HT = (value>>3)&31
            @regFH = value&7
        else
            # Second write, vertical scroll:
            @reg_FV = value&7
            @reg_VT = (value>>3)&31
        end

        @first_write = !@first_write
    end
    
    # CPU Register $2006:
    # Sets the adress used when reading/writing from/to VRAM.
    # The first write sets the high byte, the second the low byte.
    def write_VRAM_address(address)
        
        if (@first_write)
            @reg_FV = (address>>4)&3
            @reg_V  = (address>>3)&1
            @reg_H  = (address>>2)&1
            @reg_VT = (@reg_VT&7) | ((address&3)<<3)
        else
            self.trigger_rendering()
            
            @reg_VT = (@reg_VT&24) | ((address>>5)&7)
            @reg_HT = address&31
            
            @cnt_FV = @reg_FV
            @cnt_V  = @reg_V
            @cnt_H  = @reg_H
            @cnt_VT = @reg_VT
            @cnt_HT = @reg_HT
            
            self.check_sprite0(@scan_line-20)
        end
        
        @first_write = !@first_write
        
        # Invoke mapper latch:
        self.cnts_to_address()
        if (@vram_address < 0x2000) 
            @nes.mmap.latch_access(@vram_address)
        end   
    end
    
    # CPU Register $2007(R):
    # Read from PPU memory. The address should be set first.
    def vram_load
        tmp
        
        self.cnts_to_address()
        self.regs_to_address()
        
        # If address is in range 0x0000-0x3EFF, return buffered values:
        if (@vram_address <= 0x3EFF)
            tmp = @vram_buffered_read_value
        
            # Update buffered value:
            if (@vram_address < 0x2000)
                @vram_buffered_read_value = @vram_mem[@vram_address]
            else 
                @vram_buffered_read_value = self.mirrored_load(
                    @vram_address
                )
            end
            
            # Mapper latch access:
            if (@vram_address < 0x2000)
                @nes.mmap.latch_access(@vram_address)
            end
            
            # Increment by either 1 or 32, depending on d2 of Control Register 1:
            @vram_address += (@f_addr_inc == 1 ? 32 : 1)
            
            @cnts_from_address()
            @reg_S_from_address()
            
            return tmp # Return the previous buffered value.
        end
            
        # No buffering in this mem range. Read normally.
        tmp = self.mirrored_load(@vram_address)
        
        # Increment by either 1 or 32, depending on d2 of Control Register 1:
        @vram_address += (@f_addr_inc == 1 ? 32 : 1) 
        
        self.cnts_from_address()
        self.reg_S_from_address()
        
        return tmp
    end
    
    # CPU Register $2007(W):
    # Write to PPU memory. The address should be set first.
    def vram_write(value)
        
        self.trigger_rendering()
        self.cnts_to_address()
        self.regs_to_address()
        
        if (@vram_address >= 0x2000)
            # Mirroring is used.
            self.mirrored_write(@vram_address,value)
        else
            # Write normally.
            self.write_mem(@vram_address,value)
            
            # Invoke mapper latch:
            @nes.mmap.latch_access(@vram_address)
        end
        
        # Increment by either 1 or 32, depending on d2 of Control Register 1:
        @vram_address += (@f_addrInc==1?32:1)
        self.reg_S_from_address()
        self.cnts_from_address()
    end
    
    # CPU Register $4014:
    # Write 256 bytes of main memory
    # into Sprite RAM.
    def sram_DMA(value)
        baseAddress = value * 0x100
        data

        i=@sram_address
        while (i < 256 )
            data = @nes.cpu.main_memory[baseAddress+i]
            @sprite_mem[i] = data
            sprite_ram_write_update(i, data)
            i+=1
         end
        
        @nes.cpu.halt_cycles(513)
    end
    
    # Updates the scroll registers from a new VRAM address.
    def regs_from_ddress
        
        address = (@vram_tmp_address>>8)&0xFF
        @reg_FV = (address>>4)&7
        @reg_V = (address>>3)&1
        @reg_H = (address>>2)&1
        @reg_VT = (@reg_VT&7) | ((address&3)<<3)
        
        address = @vram_tmp_address&0xFF
        @reg_VT = (@reg_VT&24) | ((address>>5)&7)
        @reg_HT = address&31
    end
    
    # Updates the scroll registers from a new VRAM address.
    def cnts_from_address
        
        address = (@vram_address>>8)&0xFF
        @cnt_FV = (address>>4)&3
        @cnt_V = (address>>3)&1
        @cnt_H = (address>>2)&1
        @cnt_VT = (@cnt_VT&7) | ((address&3)<<3)        
        
        address = @vram_address&0xFF
        @cnt_VT = (@cnt_VT&24) | ((address>>5)&7)
        @cnt_HT = address&31
    end
    
    def regs_to_address
        b1  = (@reg_FV&7)<<4
        b1 |= (@reg_V&1)<<3
        b1 |= (@reg_H&1)<<2
        b1 |= (@reg_VT>>3)&3
        
        b2  = (@reg_VT&7)<<5
        b2 |= @reg_HT&31
        
        @vram_tmp_address = ((b1<<8) | b2)&0x7FFF
    end
    
    def cnts_to_address
        b1  = (@cnt_FV&7)<<4
        b1 |= (@cnt_V&1)<<3
        b1 |= (@cnt_H&1)<<2
        b1 |= (@cnt_VT>>3)&3
        
        b2  = (@cnt_VT&7)<<5
        b2 |= @cnt_HT&31
        
        @vram_address = ((b1<<8) | b2)&0x7FFF
    end
    
    def inc_tile_counter(count) 

        i = count
        while(i>0)

            @cnt_HT+=1

            if (@cnt_HT == 32)

                @cnt_HT = 0
                @cnt_VT+=1

                if (@cnt_VT >= 30)
                    @cnt_H+=1

                    if(@cnt_H == 2) 
                        @cnt_H = 0
                        @cnt_V+=1

                        if (@cnt_V == 2)
                            @cnt_V = 0
                            @cnt_FV+=1
                            @cnt_FV &= 0x7
                        end
                    end
                end
            end

            i -= 1
        end
    end
    
    # Reads from memory, taking into account
    # mirroring/mapping of address ranges.
    def mirrored_load(address) 
        return @vram_mem[@vram_mirror_table[address]]
    end
    
    # Writes to memory, taking into account
    # mirroring/mapping of address ranges.
    def mirrored_write(address, value)

        if (address>=0x3f00 && address<0x3f20)
            # Palette write mirroring.
            if (address==0x3F00 || address==0x3F10)
                self.write_mem(0x3F00,value)
                self.write_mem(0x3F10,value)
            elsif (address==0x3F04 || address==0x3F14)
                self.write_mem(0x3F04,value)
                self.write_mem(0x3F14,value)
            elsif (address==0x3F08 || address==0x3F18)
                self.write_mem(0x3F08,value)
                self.write_mem(0x3F18,value)
            elsif (address==0x3F0C || address==0x3F1C)
                self.write_mem(0x3F0C,value)
                self.write_mem(0x3F1C,value)
             else 
                self.write_mem(address,value)
             end
        else 
            # Use lookup table for mirrored address:
            if (address<@vram_mirror_table.length)
                self.write_mem(@vram_mirror_table[address],value)
            else
                # FIXME
                puts "Invalid VRAM address: #{address.toString(16)}"
            end
        end
    end
    
    def trigger_rendering

        if (@scan_line>= 21 && @scan_line<= 260)

            # Render sprites, and combine:
            @renderFramePartially(
                @last_rendered_scan_line+1,
                @scan_line-21-@last_rendered_scan_line
            )
            
            # Set last rendered scan_line:
            @last_rendered_scan_line = @scan_line-21
        end
    end
    
    def render_frame_partially(startScan, scanCount)

        if (@f_sp_visibility == 1) 
            self.render_sprites_partially(startScan,scanCount,true)
        end
        
        if(@f_bg_visibility == 1)

            si = startScan<<8
            ei = (startScan+scanCount)<<8

            if (ei > 0xF000)
                ei = 0xF000
            end 

            buffer = @buffer
            bg_buffer = @bg_buffer
            pix_rendered = @pix_rendered

            dest_index=si
            while (dest_index<ei ) 

                if (pix_rendered[dest_index] > 0xFF)
                    buffer[dest_index] = bg_buffer[dest_index]
                end
                dest_index+=1
            end
        end
        
        if (@f_sp_visibility == 1)
            self.render_sprites_partially(startScan, scanCount, false)
        end
        
        @valid_tile_data = false
    end
    
    def render_bg_scan_line(bg_buffer, scan)

        baseTile = (@reg_S === 0 ? 0 : 256)
        dest_index = (scan<<8)-@regFH

        @curNt = @ntable1[@cnt_V+@cnt_V+@cnt_H]
        
        @cnt_HT = @reg_HT
        @cnt_H = @reg_H
        @curNt = @ntable1[@cnt_V+@cnt_V+@cnt_H]
        
        if (scan<240 && (scan-@cnt_FV)>=0)
            
            tscanoffset = @cnt_FV<<3
            scantile = @scan_tile
            attrib = @attrib
            pt_tile = @pt_tile
            name_table = @name_table
            img_palette = @img_palette
            pix_rendered = @pix_rendered
            target_buffer = bg_buffer ? @bg_buffer : @buffer

            t, tpix, att, col

            tile=0
            for (tile<32)
                
                if (scan>=0) 
                
                    # Fetch tile & attrib data:
                    if (@valid_tile_data) 
                        # Get data from array:
                        t = scantile[tile]
                        tpix = t.pix
                        att = attrib[tile]
                    else
                        # Fetch data:
                        t = pt_tile[baseTile+name_table[@curNt].get_tile_index(@cnt_HT,@cnt_VT)]
                        tpix = t.pix
                        att = name_table[@curNt].get_attrib(@cnt_HT,@cnt_VT)
                        scantile[tile] = t
                        attrib[tile] = att
                    end
                    
                    # Render tile scan_line:
                    sx = 0
                    x = (tile<<3)-@regFH

                    if (x>-8)

                        if (x<0)
                            dest_index-=x
                            sx = -x
                        end

                        if (t.opaque[@cnt_FV])
                            while (sx<8)
                                target_buffer[dest_index] = img_palette[
                                    tpix[tscanoffset+sx]+att
                                ]
                                pix_rendered[dest_index] |= 256
                                dest_index+=1
                                sx+=1
                            end
                        else
                            for (sx<8sx+=1) 
                                col = tpix[tscanoffset+sx]

                                if(col !== 0)
                                    target_buffer[dest_index] = img_palette[
                                        col+att
                                    ]
                                    pix_rendered[dest_index] |= 256
                                end
                                dest_index+=1
                            end
                        end
                    end
                end
                    
                # Increase Horizontal Tile Counter:
                if (@cnt_HT == 32)
                    @cnt_HT = 0
                    @cnt_H += 1
                    @cnt_H %= 2
                    @curNt = @ntable1[(@cnt_V<<1)+@cnt_H]    
                end
                
                tile+=1
            end
            
            # Tile data for one row should now have been fetched,
            # so the data in the array is valid.
            @valid_tile_data = true
            
        end
        
        # update vertical scroll:
        @cnt_FV+=1

        if (@cnt_FV==8)

            @cnt_FV = 0
            @cnt_VT+=1

            if (@cnt_VT==30)

                @cnt_VT = 0
                @cnt_V+=1
                @cnt_V%=2
                @curNt = @ntable1[(@cnt_V<<1)+@cnt_H]

            elsif (@cnt_VT==32)
                @cnt_VT = 0
            end
            
            # Invalidate fetched data:
            @valid_tile_data = false
            
        end
    end
    
    def render_sprites_partially(startscan, scancount, bgPri)

        if (@f_sp_visibility === 1)
            
            for (i=0i<64i+=1)

                if (@bg_priority[i]==bgPri && @sprite_X[i]>=0 && 
                        @sprite_X[i]<256 && @sprite_Y[i]+8>=startscan && 
                        @sprite_Y[i]<startscan+scancount)

                    # Show sprite.
                    if (@f_sprite_size === 0)
                        # 8x8 sprites
                        
                        @srcy1 = 0
                        @srcy2 = 8
                        
                        if (@sprite_Y[i]<startscan)
                            @srcy1 = startscan - @sprite_Y[i]-1
                        end
                        
                        if (@sprite_Y[i]+8 > startscan+scancount)
                            @srcy2 = startscan+scancount-@sprite_Y[i]+1
                        end
                        
                        if (@f_sp_pattern_table===0) 
                            @pt_tile[@sprite_tile[i]].render(@buffer, 
                                0, @srcy1, 8, @srcy2, @sprite_X[i], 
                                @sprite_Y[i]+1, @spr_col[i], @sprite_palette, 
                                @hori_flip[i], @vert_flip[i], i, 
                                @pix_rendered
                            )
                        else
                            @pt_tile[@sprite_tile[i]+256].render(@buffer, 0, @srcy1, 8, @srcy2, @sprite_X[i], @sprite_Y[i]+1, @spr_col[i], @sprite_palette, @hori_flip[i], @vert_flip[i], i, @pix_rendered)
                        end
                    else
                        # 8x16 sprites
                        top = @sprite_tile[i]

                        if ((top&1)!==0)
                            top = @sprite_tile[i]-1+256
                        end
                        
                        srcy1 = 0
                        srcy2 = 8
                        
                        if (@sprite_Y[i]<startscan)
                            srcy1 = startscan - @sprite_Y[i]-1
                        end
                        
                        if (@sprite_Y[i]+8 > startscan+scancount)
                            srcy2 = startscan+scancount-@sprite_Y[i]
                        end
                        
                        @pt_tile[top+(@vert_flip[i]?1:0)].render(
                            @buffer,
                            0,
                            srcy1,
                            8,
                            srcy2,
                            @sprite_X[i],
                            @sprite_Y[i]+1,
                            @spr_col[i],
                            @sprite_palette,
                            @hori_flip[i],
                            @vert_flip[i],
                            i,
                            @pix_rendered
                        )
                        
                        srcy1 = 0
                        srcy2 = 8
                        
                        if (@sprite_Y[i]+8<startscan)
                            srcy1 = startscan - (@sprite_Y[i]+8+1)
                        end
                        
                        if (@sprite_Y[i]+16 > startscan+scancount)
                            srcy2 = startscan+scancount-(@sprite_Y[i]+8)
                        end
                        
                        @pt_tile[top+(@vert_flip[i]?0:1)].render(
                            @buffer,
                            0,
                            srcy1,
                            8,
                            srcy2,
                            @sprite_X[i],
                            @sprite_Y[i]+1+8,
                            @spr_col[i],
                            @sprite_palette,
                            @hori_flip[i],
                            @vert_flip[i],
                            i,
                            @pix_rendered
                        )
                    end
                end
            end
        end
    end
    
    def check_sprite0(scan)
        
        @spr0_hit_X = -1
        @spr0_hit_Y = -1
        
        toffset
        t_indexAdd = (@f_sp_pattern_table === 0?0:256)
        x, y, t, i
        bufferIndex
        col
        bgPri
        
        x = @sprite_X[0]
        y = @sprite_Y[0]+1
        
        if (@f_sprite_size === 0) 
            # 8x8 sprites.

            # Check range:
            if (y <= scan && y + 8 > scan && x >= -7 && x < 256)
                
                # Sprite is in range.
                # Draw scan_line:
                t = @pt_tile[@sprite_tile[0] + t_indexAdd]
                col = @spr_col[0]
                bgPri = @bg_priority[0]
                
                if (@vert_flip[0])
                    toffset = 7 - (scan -y)
                else 
                    toffset = scan - y
                end

                toffset *= 8
                
                bufferIndex = scan * 256 + x
                if (@hori_flip[0])
                    i=7
                    while ( i >= 0)
                        if (x >= 0 && x < 256)
                            if (bufferIndex>=0 && bufferIndex<61440 && 
                                    @pix_rendered[bufferIndex] !==0 )
                                if (t.pix[toffset+i] !== 0)
                                    @spr0_hit_X = bufferIndex % 256
                                    @spr0_hit_Y = scan
                                    return true
                                end
                            end
                        end
                        x+=1
                        bufferIndex+=1
                        i-=1
                    end
                else
                    i=0
                    for (i < 8 )
                        if (x >= 0 && x < 256)
                            if (bufferIndex >= 0 && bufferIndex < 61440 && 
                                    @pix_rendered[bufferIndex] !==0 ) 
                                if (t.pix[toffset+i] !== 0) {
                                    @spr0_hit_X = bufferIndex % 256
                                    @spr0_hit_Y = scan
                                    return true
                                end
                            end
                        end
                        x+=1
                        i+=1
                        bufferIndex+=1  
                    end
                end
            end
        else
            # 8x16 sprites:
        
            # Check range:
            if (y <= scan && y + 16 > scan && x >= -7 && x < 256)
                # Sprite is in range.
                # Draw scan_line:
                
                if (@vert_flip[0])
                    toffset = 15-(scan-y)
                else
                    toffset = scan-y
                end
                
                if (toffset<8) 
                    # first half of sprite.
                    t = @pt_tile[@sprite_tile[0]+(@vert_flip[0]?1:0)+((@sprite_tile[0]&1)!==0?255:0)]
                else
                    # second half of sprite.
                    t = @pt_tile[@sprite_tile[0]+(@vert_flip[0]?0:1)+((@sprite_tile[0]&1)!==0?255:0)]

                    if (@vert_flip[0]) 
                        toffset = 15-toffset
                    else 
                        toffset -= 8
                    end
                end
                toffset*=8
                col = @spr_col[0]
                bgPri = @bg_priority[0]
                
                bufferIndex = scan*256+x

                if (@hori_flip[0])
                    i=7
                    while (i>=0) 
                        if (x>=0 && x<256) 
                            if (bufferIndex>=0 && bufferIndex<61440 && @pix_rendered[bufferIndex]!==0) 
                                if (t.pix[toffset+i] !== 0) 
                                    @spr0_hit_X = bufferIndex%256
                                    @spr0_hit_Y = scan
                                    return true
                                end
                            end
                        end
                        x+=1
                        bufferIndex+=1
                        i-=1
                    end
                else
                    i=0
                    while (i<8)
                        if (x>=0 && x<256)
                            if (bufferIndex>=0 && bufferIndex<61440 && @pix_rendered[bufferIndex]!==0)

                                if (t.pix[toffset+i] !== 0) 
                                    @spr0_hit_X = bufferIndex%256
                                    @spr0_hit_Y = scan
                                    return true
                                end
                            end
                        end
                        x+=1
                        i+=1
                        bufferIndex+=1
                    end
                end
            end
        end
        
        return false
    end
    
    # This will write to PPU memory, and
    # update internally buffered data
    # appropriately.
    def write_mem(address, value)
        @vram_mem[address] = value
        
        # Update internally buffered data:
        if (address < 0x2000)
            @vram_mem[address] = value
            @patternWrite(address,value)
        elsif (address >=0x2000 && address <0x23c0)
            @name_tableWrite(@ntable1[0], address - 0x2000, value)
        elsif (address >=0x23c0 && address <0x2400) 
            @attribTableWrite(@ntable1[0],address-0x23c0,value)
        elsif (address >=0x2400 && address <0x27c0) 
            @name_tableWrite(@ntable1[1],address-0x2400,value)
        elsif (address >=0x27c0 && address <0x2800) 
            @attribTableWrite(@ntable1[1],address-0x27c0,value)
        elsif (address >=0x2800 && address <0x2bc0)
            @name_tableWrite(@ntable1[2],address-0x2800,value)
        elsif (address >=0x2bc0 && address <0x2c00) 
            @attribTableWrite(@ntable1[2],address-0x2bc0,value)
        elsif (address >=0x2c00 && address <0x2fc0)   
            @name_tableWrite(@ntable1[3],address-0x2c00,value)
        elsif (address >=0x2fc0 && address <0x3000)
            @attribTableWrite(@ntable1[3],address-0x2fc0,value)
        elsif (address >=0x3f00 && address <0x3f20)
            self.update_palettes()
        end
    end
    
    # Reads data from $3f00 to $f20 
    # into the two buffered palettes.
    def update_palettes
        i=0
        
        while ( i < 16 ) 
            if (@f_disp_type === 0) 
                @img_palette[i] = @pal_table.get_entry(
                    @vram_mem[0x3f00 + i] & 63
                )
            else 
                @img_palette[i] = @pal_table.get_entry(
                    @vram_mem[0x3f00 + i] & 32
                )
            end
            i+=1
        end
        i=0
        while (i < 16 )
            if (@f_disp_type === 0)
                @sprite_palette[i] = @pal_table.get_entry(
                    @vram_mem[0x3f10 + i] & 63
                )
            else 
                @sprite_palette[i] = @pal_table.get_entry(
                    @vram_mem[0x3f10 + i] & 32
                )
            end
            i+=1
        end
    end
    
    # Updates the internal pattern
    # table buffers with this new byte.
    # In vNES, there is a version of this with 4 arguments which isn't used.
    def pattern_write(address, value)

        tileIndex = Math.floor(address / 16)
        leftOver = address%16

        if (leftOver<8)
            @pt_tile[tileIndex].set_scan_line(
                leftOver,
                value,
                @vram_mem[address+8]
            )
        else
            @pt_tile[tileIndex].set_scan_line(
                leftOver-8,
                @vram_mem[address-8],
                value
            )
        end
    end

    # Updates the internal name table buffers
    # with this new byte.
    def name_tableWrite(index, address, value)
        @name_table[index].tile[address] = value
        
        # Update Sprite #0 hit:
        #updateSpr0Hit()
        self.check_sprite0(@scan_line-20)
    end
    
    # Updates the internal pattern
    # table buffers with this new attribute
    # table byte.
    def attrib_table_write(index, address, value)
        @name_table[index].writeAttrib(address,value)
    end
    
    # Updates the internally buffered sprite
    # data with this new byte of info.
    spriteRamWriteUpdate: function(address, value) {
        t_index = Math.floor(address / 4)
        
        if (t_index === 0)
            #updateSpr0Hit()
            self.check_sprite0(@scan_line- 20)
        end
        
        if (address % 4 === 0)
            # Y coordinate
            @sprite_Y[t_index] = value
        elsif (address % 4 == 1)
            # Tile index
            @sprite_tile[t_index] = value
        elsif (address % 4 == 2)
            # Attributes
            @vert_flip[t_index] = ((value & 0x80) !== 0)
            @hori_flip[t_index] = ((value & 0x40) !==0 )
            @bg_priority[t_index] = ((value & 0x20) !== 0)
            @spr_col[t_index] = (value & 3) << 2
        elsif (address % 4 == 3)
            # X coordinate
            @sprite_X[t_index] = value
        end
    end
    
    def do_NMI
        # Set VBlank flag:
        self.set_status_flag(@STATUS_VBLANK,true)
        #nes.getCpu().doNonMaskableInterrupt()
        @nes.cpu.request_irq(@nes.cpu.IRQ_NMI)
    end
    
    JSON_PROPERTIES = [
        # Memory
        'vram_mem', 'sprite_mem',
        # Counters
        'cnt_FV', 'cnt_V', 'cnt_H', 'cnt_VT', 'cnt_HT',
        # Registers
        'reg_FV', 'reg_V', 'reg_H', 'reg_VT', 'reg_HT', 'reg_FH', 'reg_S',
        # VRAM addr
        'vram_address', 'vram_tmp_address',
        # Control/Status registers
        'f_nmi_on_vblank', 'f_sprite_size', 'f_bg_pattern_table', 'f_sp_pattern_table', 
        'f_addr_inc', 'f_n_tbl_address', 'f_color', 'f_sp_visibility', 
        'f_bg_visibility', 'f_sp_clipping', 'f_bg_clipping', 'f_disp_type',
        # VRAM I/O
        'vram_buffered_read_value', 'first_write',
        # Mirroring
        'current_mirroring', 'vram_mirror_table', 'ntable1',
        # SPR-RAM I/O
        'sram_address',
        # Sprites. Most sprite data is rebuilt from spriteMem
        'hit_spr0',
        # Palettes
        'sprite_palette', 'img_palette',
        # Rendering progression
        'curX', 'scan_line', 'last_rendered_scan_line', 'cur_Nt', 'scan_tile',
        # Used during rendering
        'attrib', 'buffer', 'bg_buffer', 'pix_rendered',
        # Misc
        'request_end_frame', 'nmiOk', 'dummy_cycle_toggle', 'nmi_counter', 
        'valid_tile_data', 'scan_line_already_rendered'
    ]
    
    def to_JSON
        i=0
        state = JSNES.Utils.toJSON(this)
        
        state.name_table = []

        i = 0
        while (i < @name_table.length)
            state.name_table[i] = @name_table[i].toJSON()
            i+=1
        end
        
        state.pt_tile = []
        i=0
        while (i < @pt_tile.length )
            state.pt_tile[i] = @pt_tile[i].toJSON()
            i+=1
        end
        
        return state
    end
    
    def from_JSON(state)
        i=0
        
        JSNES.Utils.fromJSON(this, state)
        i = 0
        for ( i < @name_table.length)
            @name_table[i].fromJSON(state.name_table[i])
            i+=1
        end

        i = 0
        for ( i < @pt_tile.length)
            @pt_tile[i].fromJSON(state.pt_tile[i])
            i+=1
        end
        
        # Sprite data:
        i = 0
        for (i < @sprite_mem.length)
            sprite_ram_write_update(i, @sprite_mem[i])
            i+=1
        end
    end
end

class NameTable

    attr_accessor :width, :height, :name, :tile, :attrib

    def initialize(width, height, name)
        @width = width
        @height = height
        @name = name
        
        @tile = Array.new(width*height)
        @attrib = Array.new(width*height)
    end

    def get_tile_index(x,y)
        return @tile[y*@width+x]
    end

    def get_attrib(x,y)
        return @attrib[y*@width+x]
    end

    def write_attrib(index,value)
        basex = (index % 8) * 4
        basey = Math.floor(index / 8) * 4
        add=0
        tx, ty=0
        att_index=0 

        for sqy in (0..2 - 1)
            for sqx in (0..2 - 1)
                add = (value>>(2*(sqy*2+sqx)))&3

                for y in (0..2 - 1)
                    for x in (0..2 - 1)
                        tx = basex+sqx*2+x
                        ty = basey+sqy*2+y
                        att_index = ty*@width+tx
                        @attrib[ty*@width+tx] = (add<<2)&12
                    end
                end
            end
        end
    end

    def to_JSON
        return
            'tile'=> @tile,
            'attrib'=> @attrib
    end
    
    def from_JSON(s)
        @tile = s.tile
        @attrib = s.attrib
    end
end

class PaletteTable

    attr_accessor :cur_table, :emph_table, :current_emph

    def initialize
        @cur_table = Array.new(64)
        @emph_table = Array.new(8)
        @current_emph = -1
    end

    def reset
        self.set_emphasis(0)
    end
    
    def load_NTSC_palette
        @cur_table = [0x525252, 0xB40000, 0xA00000, 0xB1003D, 0x740069, 0x00005B, 0x00005F, 0x001840, 0x002F10, 0x084A08, 0x006700, 0x124200, 0x6D2800, 0x000000, 0x000000, 0x000000, 0xC4D5E7, 0xFF4000, 0xDC0E22, 0xFF476B, 0xD7009F, 0x680AD7, 0x0019BC, 0x0054B1, 0x006A5B, 0x008C03, 0x00AB00, 0x2C8800, 0xA47200, 0x000000, 0x000000, 0x000000, 0xF8F8F8, 0xFFAB3C, 0xFF7981, 0xFF5BC5, 0xFF48F2, 0xDF49FF, 0x476DFF, 0x00B4F7, 0x00E0FF, 0x00E375, 0x03F42B, 0x78B82E, 0xE5E218, 0x787878, 0x000000, 0x000000, 0xFFFFFF, 0xFFF2BE, 0xF8B8B8, 0xF8B8D8, 0xFFB6FF, 0xFFC3FF, 0xC7D1FF, 0x9ADAFF, 0x88EDF8, 0x83FFDD, 0xB8F8B8, 0xF5F8AC, 0xFFFFB0, 0xF8D8F8, 0x000000, 0x000000]
        self.make_tables()
        self.set_emphasis(0)
    end
    
    def load_PAL_palette
        @cur_table = [0x525252, 0xB40000, 0xA00000, 0xB1003D, 0x740069, 0x00005B, 0x00005F, 0x001840, 0x002F10, 0x084A08, 0x006700, 0x124200, 0x6D2800, 0x000000, 0x000000, 0x000000, 0xC4D5E7, 0xFF4000, 0xDC0E22, 0xFF476B, 0xD7009F, 0x680AD7, 0x0019BC, 0x0054B1, 0x006A5B, 0x008C03, 0x00AB00, 0x2C8800, 0xA47200, 0x000000, 0x000000, 0x000000, 0xF8F8F8, 0xFFAB3C, 0xFF7981, 0xFF5BC5, 0xFF48F2, 0xDF49FF, 0x476DFF, 0x00B4F7, 0x00E0FF, 0x00E375, 0x03F42B, 0x78B82E, 0xE5E218, 0x787878, 0x000000, 0x000000, 0xFFFFFF, 0xFFF2BE, 0xF8B8B8, 0xF8B8D8, 0xFFB6FF, 0xFFC3FF, 0xC7D1FF, 0x9ADAFF, 0x88EDF8, 0x83FFDD, 0xB8F8B8, 0xF5F8AC, 0xFFFFB0, 0xF8D8F8, 0x000000, 0x000000]
        self.make_tables()
        self.set_emphasis(0)
    end

    def make_tables
        r, g, b, col, i, rFactor, gFactor, bFactor=0
        
        # Calculate a table for each possible emphasis setting:
        for emph in (0..8 - 1)
            
            # Determine color component factors:
            rFactor = 1.0
            gFactor = 1.0
            bFactor = 1.0
            
            if ((emph & 1) !== 0)
                rFactor = 0.75
                bFactor = 0.75
            end
            if ((emph & 2) !== 0)
                rFactor = 0.75
                gFactor = 0.75
            end
            if ((emph & 4) !== 0) 
                gFactor = 0.75
                bFactor = 0.75
            end
            
            @emph_table[emph] = Array.new(64)
            
            # Calculate table:
            for i in (0..64 - 1)
                col = @cur_table[i]
                r = Math.floor(@get_red(col) * rFactor)
                g = Math.floor(@get_green(col) * gFactor)
                b = Math.floor(@get_blue(col) * bFactor)
                @emph_table[emph][i] = self.get_rgb(r, g, b)
            end
        end
    end
    
    def set_emphasis(emph)
        if (emph != @current_emph)
            @current_emph = emph
            for i in (0..64 - 1)
                @cur_table[i] = @emph_table[emph][i]
            end
        end
    end
    
    def get_entry(yiq)
        return @cur_table[yiq]
    end
    
    def get_red(rgb)
        return (rgb>>16)&0xFF
    end
    
    def get_green(rgb)
        return (rgb>>8)&0xFF
    end
    
    def get_blue(rgb)
        return rgb&0xFF
    end
    
    def get_RGB(r, g, b)
        return ((r<<16)|(g<<8)|(b))
    end
    
    def load_default_palette
        @cur_table[ 0] = self.get_RGB(117,117,117)
        @cur_table[ 1] = self.get_RGB( 39, 27,143)
        @cur_table[ 2] = self.get_RGB(  0,  0,171)
        @cur_table[ 3] = self.get_RGB( 71,  0,159)
        @cur_table[ 4] = self.get_RGB(143,  0,119)
        @cur_table[ 5] = self.get_RGB(171,  0, 19)
        @cur_table[ 6] = self.get_RGB(167,  0,  0)
        @cur_table[ 7] = self.get_RGB(127, 11,  0)
        @cur_table[ 8] = self.get_RGB( 67, 47,  0)
        @cur_table[ 9] = self.get_RGB(  0, 71,  0)
        @cur_table[10] = self.get_RGB(  0, 81,  0)
        @cur_table[11] = self.get_RGB(  0, 63, 23)
        @cur_table[12] = self.get_RGB( 27, 63, 95)
        @cur_table[13] = self.get_RGB(  0,  0,  0)
        @cur_table[14] = self.get_RGB(  0,  0,  0)
        @cur_table[15] = self.get_RGB(  0,  0,  0)
        @cur_table[16] = self.get_RGB(188,188,188)
        @cur_table[17] = self.get_RGB(  0,115,239)
        @cur_table[18] = self.get_RGB( 35, 59,239)
        @cur_table[19] = self.get_RGB(131,  0,243)
        @cur_table[20] = self.get_RGB(191,  0,191)
        @cur_table[21] = self.get_RGB(231,  0, 91)
        @cur_table[22] = self.get_RGB(219, 43,  0)
        @cur_table[23] = self.get_RGB(203, 79, 15)
        @cur_table[24] = self.get_RGB(139,115,  0)
        @cur_table[25] = self.get_RGB(  0,151,  0)
        @cur_table[26] = self.get_RGB(  0,171,  0)
        @cur_table[27] = self.get_RGB(  0,147, 59)
        @cur_table[28] = self.get_RGB(  0,131,139)
        @cur_table[29] = self.get_RGB(  0,  0,  0)
        @cur_table[30] = self.get_RGB(  0,  0,  0)
        @cur_table[31] = self.get_RGB(  0,  0,  0)
        @cur_table[32] = self.get_RGB(255,255,255)
        @cur_table[33] = self.get_RGB( 63,191,255)
        @cur_table[34] = self.get_RGB( 95,151,255)
        @cur_table[35] = self.get_RGB(167,139,253)
        @cur_table[36] = self.get_RGB(247,123,255)
        @cur_table[37] = self.get_RGB(255,119,183)
        @cur_table[38] = self.get_RGB(255,119, 99)
        @cur_table[39] = self.get_RGB(255,155, 59)
        @cur_table[40] = self.get_RGB(243,191, 63)
        @cur_table[41] = self.get_RGB(131,211, 19)
        @cur_table[42] = self.get_RGB( 79,223, 75)
        @cur_table[43] = self.get_RGB( 88,248,152)
        @cur_table[44] = self.get_RGB(  0,235,219)
        @cur_table[45] = self.get_RGB(  0,  0,  0)
        @cur_table[46] = self.get_RGB(  0,  0,  0)
        @cur_table[47] = self.get_RGB(  0,  0,  0)
        @cur_table[48] = self.get_RGB(255,255,255)
        @cur_table[49] = self.get_RGB(171,231,255)
        @cur_table[50] = self.get_RGB(199,215,255)
        @cur_table[51] = self.get_RGB(215,203,255)
        @cur_table[52] = self.get_RGB(255,199,255)
        @cur_table[53] = self.get_RGB(255,199,219)
        @cur_table[54] = self.get_RGB(255,191,179)
        @cur_table[55] = self.get_RGB(255,219,171)
        @cur_table[56] = self.get_RGB(255,231,163)
        @cur_table[57] = self.get_RGB(227,255,163)
        @cur_table[58] = self.get_RGB(171,243,191)
        @cur_table[59] = self.get_RGB(179,255,207)
        @cur_table[60] = self.get_RGB(159,255,243)
        @cur_table[61] = self.get_RGB(  0,  0,  0)
        @cur_table[62] = self.get_RGB(  0,  0,  0)
        @cur_table[63] = self.get_RGB(  0,  0,  0)
        
        self.make_tables()
        self.set_emphasis(0)
    }
}

class Tile

    attr_accessor :pix,:fb_index,:t_index,:x,:y,:w,:h,:inc_X,:inc_Y,:pal_index,:t_pri,:c,:initialized,:opaque

    def initialize
        # Tile data:
        @pix = Array.new(64)
        
        @fb_index = null
        @t_index = null
        @x = null
        @y = null
        @w = null
        @h = null
        @inc_X = null
        @inc_Y = null
        @pal_index = null
        @t_pri = null
        @c = null
        @initialized = false
        @opaque = Array.new(8)
    end

    def set_buffer(scan_line)
        for y in (0..8-1)
            self.set_scan_line(y,scan_line[y],scan_line[y+8])
        end
    end
    
    def set_scan_line(sline, b1, b2)
        @initialized = true
        @t_index = sline<<3
        for x in (0..8 - 1)
            @pix[@t_index + x] = ((b1 >> (7 - x)) & 1) +
                    (((b2 >> (7 - x)) & 1) << 1)
            if(@pix[@t_index+x] === 0) 
                @opaque[sline] = false
            end
        end
    end
    
    def is_transparent(x, y)
        return (@pix[(y << 3) + x] === 0)
    end
    
    def to_JSON
        return 
            :opaque => @opaque,
            :pix => @pix
        
    end

    def from_JSON(s)
        @opaque = s.opaque
        @pix = s.pix
    end
    
    def render(buffer, srcx1, srcy1, srcx2, srcy2, dx, dy, palAdd, palette, flipHorizontal, flipVertical, pri, priTable)

        if (dx<-7 || dx>=256 || dy<-7 || dy>=240)
            return
        end

        @w=srcx2-srcx1
        @h=srcy2-srcy1
    
        if (dx<0)
            srcx1-=dx
        end
        if (dx+srcx2>=256)
            srcx2=256-dx
        end
    
        if (dy<0)
            srcy1-=dy
        end
        if (dy+srcy2>=240)
            srcy2=240-dy
        end
    
        if (!flipHorizontal && !flipVertical)
        
            @fb_index = (dy<<8)+dx
            @t_index = 0
            for y in (0..8-1)
                for x in (0..8-1)
                    if (x>=srcx1 && x<srcx2 && y>=srcy1 && y<srcy2)
                        @pal_index = @pix[@t_index]
                        @t_pri = priTable[@fb_index]

                        if (@pal_index!==0 && pri<=(@t_pri&0xFF))
                            #console.log("Rendering upright tile to buffer")
                            buffer[@fb_index] = palette[@pal_index+palAdd]
                            @t_pri = (@t_pri&0xF00)|pri
                            priTable[@fb_index] =@t_pri
                        end
                    end
                    @fb_index+=1
                    @t_index+=1
                end
                @fb_index-=8
                @fb_index+=256
            end
        elsif (flipHorizontal && !flipVertical)
        
            @fb_index = (dy<<8)+dx
            @t_index = 7

            for y in (0..8-1)
                for x in (0..8-1)
                    if (x>=srcx1 && x<srcx2 && y>=srcy1 && y<srcy2)

                        @pal_index = @pix[@t_index]
                        @t_pri = priTable[@fb_index]

                        if (@pal_index!==0 && pri<=(@t_pri&0xFF))

                            buffer[@fb_index] = palette[@pal_index+palAdd]
                            @t_pri = (@t_pri&0xF00)|pri
                            priTable[@fb_index] =@t_pri
                        end
                    end
                    @fb_index+=1
                    @t_index-=1
                end
                @fb_index-=8
                @fb_index+=256
                @t_index+=16
            end
        elsif(flipVertical && !flipHorizontal)
        
            @fb_index = (dy<<8)+dx
            @t_index = 56
            for y in (0..8-1)
                for x in (0..8-1)

                    if (x>=srcx1 && x<srcx2 && y>=srcy1 && y<srcy2)
                        @pal_index = @pix[@t_index]
                        @t_pri = priTable[@fb_index]

                        if (@pal_index!==0 && pri<=(@t_pri&0xFF))

                            buffer[@fb_index] = palette[@pal_index+palAdd]
                            @t_pri = (@t_pri&0xF00)|pri
                            priTable[@fb_index] =@t_pri
                        end
                    end
                    @fb_index+=1
                    @t_index+=1
                end
                @fb_index-=8
                @fb_index+=256
                @t_index-=16
            end
        else 
            @fb_index = (dy<<8)+dx
            @t_index = 63

            for y in (0..8-1)
                for x in (0..8-1)

                    if (x>=srcx1 && x<srcx2 && y>=srcy1 && y<srcy2)

                        @pal_index = @pix[@t_index]
                        @t_pri = priTable[@fb_index]

                        if (@pal_index!==0 && pri<=(@t_pri&0xFF))

                            buffer[@fb_index] = palette[@pal_index+palAdd]
                            @t_pri = (@t_pri&0xF00)|pri
                            priTable[@fb_index] =@t_pri
                        end
                    end
                    @fb_index+=1
                    @t_index-=1
                end

                @fb_index-=8
                @fb_index+=256
            end
        end
    end
end
    