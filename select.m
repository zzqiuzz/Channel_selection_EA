function [selected_pop]=select(pop,popsize,chromosize,sum_error,errortable)

selected_pop(popsize,chromosize)=0;
for i=1:popsize
    r = rand *sum_error;%随机生成一个随机数，在0和总适应度之间，因为fitness_table(pop_size)为总适应度
    first = 1;
    last = popsize;
    mid = round((last+first)/2);%计算总适应度中值
    idx = -1;
    while (first <= last) && (idx == -1) %按照排中法选择个体
        if r > errortable(mid)%如果介于中值和总适应度之间
            first = mid;%第一个值取中值继续循环
        elseif r < errortable(mid)%同理
            last = mid;
        else
            idx = mid;
            break;%一直循环直到得到中值时跳出循环
        end
        mid = round((last+first)/2);
        if (last - first) == 1
            idx = last;
            break;
        end
    end
    for j=1:chromosize
        selected_pop(i,j)=pop(idx,j);%遗传到下一代种群
    end
end









end