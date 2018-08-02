function [pop]=mutate(pop,popsize, chromosize, mutaterate)%变异操作函数
 for i=1:popsize
    if rand < mutaterate%生成一个随机数判断是否需要变异（mutate_rate为变异概率，一般为一个比较小的实数）
        mutate_pos1 = ceil(rand*chromosize);%确定变异位置
        mutate_pos2=ceil(rand*chromosize);
        pop(i,mutate_pos1) = 1 - pop(i, mutate_pos1);%对该位置的二进制数字进行变异：1变成0, 0变成1.
        pop(i,mutate_pos2) = 1 - pop(i, mutate_pos2);%对该位置的二进制数字进行变异：1变成0, 0变成1.
    end
 end 
end
