





// ideas from http://www.flightgear.org/Docs/XMLAutopilot/node3.html#SECTION00031000000000000000

float proportional_constant = xx.xxx;
float integration_time = xx.xxx;
float differentiation_time = xx.xxx;
float alpha = 0.1;
float beta = 1.0;
float gamma = 0.0;
float filter_time = alpha * differentiation_time;

float output_value = 0.0;
float last_last_error_d_f = 0.0;
float last_error_d_f = 0.0;
float last_error_p = 0.0;
float lasttime = now();

void update_pid(float new_setpoint) {
   float curtime, curval, delta_t, 
          error_p, error_d, error_d_f, 
          d_factor1, d_factor2, d_factor3,
          output_delta;          
   curtime = now();
   curval = get_process_value();
   delta_t = curtime - lasttime;
   d_factor1 = delta_t / filter_time;
   d_factor2 = d_factor1 + 1;
   d_factor3 = d_factor1 / d_factor2;
   error = new_setpoint - curval;
   error_p = beta * new_setpoint - curval;
   error_d = gamma * new_setpoint - curval;
   error_d_f = ( (last_error_d_f / d_factor2) + 
                  (error_d * d_factor3) 
                   );
   output_delta = proportional_constant * (
                  (error_p - last_error_p) + 
                  ((delta_t/integration_time) * error) + 
                  (differentiation_time/delta_t) * (error_d_f - (2 * last_error_d_f) + last_last_error_d_f)
                  );
   last_last_error_d_f = last_error_d_f;
   last_error_d_f = error_d_f;
   last_error_p = error_p;
   lasttime = curtime;
   output_value = output_value + output_delta;
   }

