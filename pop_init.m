function [pop]=pop_init(pop_size,chromo_size,compression_rate)

pop(pop_size,chromo_size)=0;
used_filters_num=round(chromo_size*compression_rate);
for each_indiv=1:pop_size 
    rand_nums=randperm(chromo_size);
    rand_num=rand_nums(1:used_filters_num);
    assert(length(rand_num)==used_filters_num) 
    for each_rand=1:length(rand_num)
        pop(each_indiv,rand_num(each_rand))=1;
    end
end