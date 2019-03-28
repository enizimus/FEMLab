function [fun_K, fun_R] = get_integral_fun(prob_opt)

[type1, type2] = hlp.get_prob_type_vals();
type = hlp.get_prob_type(prob_opt.type);

if(type == type1)
    if(prob_opt.int == 1)
        fun_K = @slvr.int_tri_K;
        fun_R = @slvr.int_tri_R;
    else
        fun_K = @slvr.pre_int_K;
        fun_R = @slvr.pre_int_R;
    end
elseif(type == type2)
    fun_K = @slvr.int_tri_K_as;
    fun_R = @slvr.int_tri_R;
end