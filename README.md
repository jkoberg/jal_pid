* jal_pid

JALv2 PID controller with USB communications and fixed-point math for PIC18F (18F2553)

The goal of this code was to operate a rice cooker as a sous-vide cooker.  That takes precise temperature sensing, 
a way to control the heating element, and the ability to do some math to deal with the PID loop algorithm. 

** PICs

The 8-but Microchip PIC microcontrollers are cheap, reliable, very available, and have been well known in the hobbyist electronic
community since the 80s.  The later parts in the series have a nice set of built-in perhipherals, including a USB transciever.
the 18F parts have more memory, a more logical memory layout, better performance than their older 10x, 12x, and 16x parts.

** JALv2 

This processsor series is normally programmed in its native assembly language, or with C using a specialized compiler.  
But, several other language compilers are available for free for it.  One of these languages is JAL, "Just Another Language" by
Wouter van Ooijen, and a modern derivative called JALv2.  These languages are Pascal-inspired and specifically designed for 
the needs of these small devices.  They have a nice set of libraries and compile to the native machine code.

** PID control

PID is a control technique that models a process with three terms.  The Present Value (PV) is measured, and compared to the 
Setpoint Value (SV) to determine the current deviation from the setpoint, or "error".  The P or proportional term is simply
a multiplicative factor of the error.  Over time, ongoing error is summed up and the I or integrative term is applied to that
sum.  The rate of change in the error signal may also be used with a D or differential term to respond more quickly to 
external forces (such as opening the cooker lid).

** Fixed-point math

Because the PICs have very basic arithmetic built in, anything more than integer addition and subtraction must be performed
in software.  The JALv2 compiler can generate arithmetic code for integers of arbitrary size, but there is no floating point
or fractional math. So I wrote a simple 64-bit fixed point math library in `fx8.jal`

** Realtime clock

It's not really needed for the controller, but since there's a quartz crystal I figured, why not go ahead and count up
time.  `clock.jal` contains interrupt-driven timer routines that maintain a clock.

** per-cycle Breshenham-style proportional control with zero-crossing detection

The PID algorithm produces an output power level to control the heater.  Most PID controllers do proportional control
of the output at a slow rate, turning it on for 0.1s and off for 0.9s for a desired output value of 10%.  However, the
use of an embedded interrupt-driven micro made me desire a more realtime solution.  So, the AC waveform is sampled through
a high-value resistor, and is used as an interrupt source to drive the proportional control.  The current output value
is subtracted from a fixed-point fractional field, and if it reaches zero, "1.0" is added and the output is turned on for
that cycle. So, at a 1.0 power output setting, every cycle is turned on.  Otherwise, the input level is approximated closely.
`zerocross.jal` contains the interrupt handler and `heater.jal` contains the Breshenham code.

 ** Tying it together
 
 `main.jal` contains the main loop, which handles the USB-Serial IO and runs the PID algorithm.
 
 
 * Lessons Learned
 
  - Small, purpose-driven languages can be very nice to work with, if you're in their niche. 
 
  - C is probably better for it breadth of libraries and mindshare.
  
  - When you're not reducing per-unit cost, it's probably nicer to use a bigger CPU
  

