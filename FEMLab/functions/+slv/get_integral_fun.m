function [fun_K, fun_R] = get_integral_fun(prob_opt)

[type1, type2] = def.get_prob_type_vals();
type = def.get_prob_type(prob_opt.type);

if(type == type1)
    if(prob_opt.int == 1)
        fun_K = @slv.int_tri_K;
        fun_R = @slv.int_tri_R;
    else
        fun_K = @slv.pre_int_K;
        fun_R = @slv.pre_int_R;
    end
elseif(type == type2)
    fun_K = @slv.int_tri_K_as;
    fun_R = @slv.int_tri_R;
end