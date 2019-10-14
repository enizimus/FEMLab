function [fun_K, fun_R] = get_integral_fun(optProb)

[type1, type2] = def.getProbTypeVals();
type = def.getProbType(optProb.type);

if(type == type1)
    if(optProb.int == 1)
        fun_K = @slv.int_tri_K;
        fun_R = @slv.int_tri_R;
    else
        fun_K = @slv.pre_int_K;
        fun_R = @slv.pre_int_R;
    end
elseif(type == type2)
    if(strcmp(optProb.class, 'mstatic'))
        fun_K = @slv.int_tri_K_as;
        fun_R = @slv.int_tri_R;
    else
        fun_K = @slv.int_tri_K_as;
        fun_R = @slv.int_tri_R;
    end
end