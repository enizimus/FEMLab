function [fun_K, fun_R] = get_integral_fun(prob_opt)

if(strcmp(prob_opt.type, 'planar'))
    if(prob_opt.int == 1)
        fun_K = @slvr.int_tri_K;
        fun_R = @slvr.int_tri_R;
    else
        fun_K = @slvr.pre_int_K;
        fun_R = @slvr.pre_int_R;
    end
else
    fun_K = @slvr.int_tri_K_as;
    fun_R = @slvr.int_tri_R;
end