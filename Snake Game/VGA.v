`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:17 05/18/2023 
// Design Name: 
// Module Name:    projekt1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Snake(
    input clk50,
	 input reset,
	 input UP, DOWN, LEFT, RIGHT,
    output vga_hsync,
    output vga_vsync,
    output vga_r,
    output vga_g,
    output vga_b,
    output [9:0] xcount,
    output [9:0] ycount
);

	 reg [9:0] h_counter;
	 reg [9:0] v_counter;
	 reg [9:0] hcount_next, vcount_next;
	 reg hsync_next, vsync_next;
	 reg vsync, hsync;
	 reg rst=0;

	 reg red_value, blue_value, green_value; 

	 reg [5:0] x1 = 4;
	 reg [5:0] x2 = 3;
	 reg [5:0] x3 = 2;
	 reg [5:0] x4 = 1;
	 reg [4:0] y1 = 1;
	 reg [4:0] y2 = 1;
	 reg [4:0] y3 = 1;
	 reg [4:0] y4 = 1;	 
	 reg kraj1;
	 reg [31:0] brojac;
	 reg stanje;
	 reg [1:0] smjer;
	 reg [1:0] control;
	 reg [4:0] koord1;
	 reg [5:0] koord2;
	
    parameter h_display =640;
    parameter h_frontporch = 27;
    parameter h_syncwidth = 96;
	 parameter h_backporch = 47;
	 parameter h_total = 800;


    parameter v_display = 485;
	 parameter v_frontporch = 8;
	 parameter v_syncwidth = 2;
	 parameter v_backporch = 26;
	 parameter v_total = 521;


	 reg clk25 = 0;


	 reg[23:0] counter=0;
	 reg[4:0] state=0;
	 reg [4:0] nasumbroj;

	wire pritisnuto;
	assign pritisnuto = UP| DOWN| LEFT| RIGHT;

 always @ (posedge clk25) begin 
		if(counter==0) begin 
			state<=state+1;
			counter<=100;
		end
		else if(pritisnuto) begin 
			state<=state+1;
			counter<=100;
		end
		else begin 
			counter<=counter-1;
		end
		case(state)
			5'b00000:nasumbroj<=0;
			5'b00001:nasumbroj<=1;
			5'b00010:nasumbroj<=2;
			5'b00011:nasumbroj<=3;
			5'b00100:nasumbroj<=4;
			5'b00101:nasumbroj<=5;
			5'b00110:nasumbroj<=6;
			5'b00111:nasumbroj<=7;
			5'b01000:nasumbroj<=8;
			5'b01001:nasumbroj<=9;
			5'b01010:nasumbroj<=10;
			5'b01011:nasumbroj<=11;
			5'b01100:nasumbroj<=12;
			5'b01101:nasumbroj<=13;
			5'b01110:nasumbroj<=14;
			5'b01111:nasumbroj<=15;
			5'b10000:nasumbroj<=16;
			5'b10001:nasumbroj<=17;
			5'b10010:nasumbroj<=18;
			5'b10011:nasumbroj<=19;
			5'b10100:nasumbroj<=20;
			5'b10101:nasumbroj<=21;
			5'b10110:nasumbroj<=22;
			5'b10111:nasumbroj<=23;
			5'b11000:nasumbroj<=24;
			5'b11001:nasumbroj<=25;
			5'b11010:nasumbroj<=26;
			5'b11011:nasumbroj<=27;
			5'b11100:nasumbroj<=28;
			5'b11101:nasumbroj<=29;
		endcase
	end


 always @(posedge clk50)
	clk25 = ~clk25;
	
	
	
 always @(posedge clk50 or posedge reset) begin
	if(reset) begin
			v_counter <= 0;
			h_counter <= 0;
			vsync <= 1'b0;
			hsync <= 1'b0;
	 end
	 else if(rst) begin
			v_counter <= 0;
			h_counter <= 0;
			vsync <= 1'b0;
			hsync <= 1'b0;
	 end
	 else begin
		v_counter <= vcount_next;
		h_counter <= hcount_next;
		vsync <= vsync_next;
		hsync <= hsync_next;
	 end
 end
	
 always @(posedge clk25 or posedge reset) begin
 
		if(reset)
			hcount_next <= 0;
		else if(rst)
			hcount_next <= 0;
		else begin
         if (h_counter == h_total - 1) 
            hcount_next <= 0;
         else 
            hcount_next <= h_counter + 1;
      end
  end
	 
	always @(posedge clk25 or posedge reset) begin
        if(reset)
			vcount_next <= 0;
		  else if(rst) 
				vcount_next <= 0;
		  else begin
				if (h_counter == h_total - 1) begin
					if(v_counter == v_total - 1)
							vcount_next <= 0;
					else 
							vcount_next <= v_counter + 1;
				end
       end
  end
		  

initial begin

		x1 = 4;
		x2 = 3;
		x3 = 2;
		x4 = 1;
		y1 = 1;
		y2 = 1;
		y3 = 1;
		y4 = 1;
		smjer = 0;
		control = 0;
		kraj1 = 0;
    end

 always @(posedge clk50 or posedge reset) begin
    if (reset) begin
		control<=0;
		end
		else if(rst)
		control<=0;
		else begin
			if(UP) begin
				if(smjer != 1)
					control <= 3;
				else
					control<=control;
			end
				else if(DOWN)begin
				if(smjer != 3)
					control <= 1;
			else
				control<=control;
			end
			else if(LEFT)begin
				if(smjer != 0)
					control <= 2;
				else
					control<=control;			
			end
			else if(RIGHT)begin
				if(smjer !=2)
				control <= 0;
			else
				control<=control;
		end
	else begin
		control <= control;
	end
 end
end 

reg [5:0] ab_g_x = 18;
reg [4:0] ab_g_y = 0;

always @(posedge clk25) 
	 begin
		koord1 <= v_counter [9:4];
		koord2 <= h_counter [9:4];
		if (reset)
		begin
			x1 <= 4;
			x2 <= 3;
			x3 <= 2;
			x4 <= 1;
	 
			y1 <= 1;
			y2 <= 1;
			y3 <= 1;
			y4 <= 1;
			kraj1 <=0;
			smjer <=0;
		end
		else begin
			if(x1==0 || x1 == 39 || y1==0 || y1==29 || kraj1==1) begin
				kraj1<=1;
				if(koord2>=0&&koord1>=0)
				begin
					blue_value<=0;
					red_value<=0;
				end
			end
			else begin
				if(koord1 < 30 && h_counter [3:0]==0) begin
						blue_value <= 0;
						red_value <=0;
				end
				else if(koord2 < 38 && v_counter [3:0]==0) begin
						blue_value <= 0;
						red_value <=0;
				end
				else if((koord1 == y1)&&(koord2 ==x1)) begin
						blue_value<=1;
						red_value <=1;
				end		
				else if(koord1== y2 && koord2==x2) begin
						blue_value<=1;
						red_value <=1;	
				end
				else if(koord1 == y3 && koord2==x3) begin
						blue_value<=1;
						red_value <=1;		
				end
				else if(koord1== y4 && koord2==x4) begin
						blue_value<=1;
						red_value <=1;	
				end
		   end
end
		
		case(smjer)
			0: begin
				if(stanje)
				begin
					x1<=x1+1;
					y1<=y1;
					x2<=x1;
					y2<=y1;
					x3<=x2;
					y3<=y2;
					x4<=x3;
					y4<=y3;
				end
			end
			
			1:begin
				if(stanje)
				begin
						
					x1<=x1;
					y1<=y1+1;
					x2<=x1;
					y2<=y1;
					x3<=x2;
					y3<=y2;
					x4<=x3;
					y4<=y3;
				end
			end
			
			
			
			2:begin
				if(stanje)
				begin
					x1<=x1-1;
					y1<=y1;
					x2<=x1;
					y2<=y1;
					x3<=x2;
					y3<=y2;
					x4<=x3;
					y4<=y3;
					
				end	
			end
			
			3:begin	
				if(stanje)
				begin
					x1<=x1;
					y1<=y1-1;
					x2<=x1;
					y2<=y1;
					x3<=x2;
					y3<=y2;
					x4<=x3;
					y4<=y3;
				end
			end
					
			endcase
		
	if(brojac==10000000) begin
			brojac <= 0;
			stanje <= 1;
			smjer<=control;
		end
	else begin
			brojac <= brojac+1;
			stanje <= 0;
		end	
	end
		
		
		
		
reg [0:39] mem [0:29];
reg [27:0] timer = 0;
reg [4:0] i;

initial begin
    for (i = 0; i <= 29; i = i + 1) begin
        mem[i] = 0;
    end
end
		
always @(posedge clk50) begin
    if (h_counter[4:0] == 0 || v_counter[4:0] == 0) begin
        green_value<=0;
    end
    else begin
        if (ab_g_y == v_counter[9:4] && ab_g_x == h_counter[9:4]) begin
            green_value<=1;
        end
        else begin
            green_value<=0;
        end

        if (v_counter[9:5] == 29) begin
            mem[29] <= {40{1'b1}};
        end
        else begin
            mem[v_counter[9:5] + 1] <= mem[v_counter[9:5]];
        end
		  end

        if (timer >= 15000000) begin 
            timer <= 0;
            if (ab_g_y < 29) begin
                ab_g_y <= ab_g_y + 1; 
            end
				else if(ab_g_y==29) begin
				    ab_g_y<=0;
					 ab_g_x<=nasumbroj;
				end
		  end
        else begin
            timer <= timer + 1;
		  end
 end
 

 always @(posedge clk25) 
 begin
   hsync_next <= (h_counter >= (h_display + h_frontporch) && h_counter <= (h_display + h_frontporch + h_syncwidth - 1));
	vsync_next <= (v_counter >= (v_display + v_frontporch) && v_counter <= (v_display + v_frontporch + v_syncwidth - 1));
 end
	 
always @(posedge clk25)
begin
	if(ab_g_x==x1 && ab_g_y==y1)
		rst<=1;
	else if(x2==ab_g_x && y2==ab_g_y)
		rst<=1;
	else if(x3==ab_g_x && y3==ab_g_y)
		rst<=1;
	else if(x4==ab_g_x && y4==ab_g_y)
		rst<=1;
end



assign xcount = h_counter;
assign ycount = v_counter;
assign vga_hsync = ~hsync;
assign vga_vsync = ~vsync;
assign vga_r = red_value;
assign vga_b = blue_value;
assign vga_g = green_value;


endmodule
