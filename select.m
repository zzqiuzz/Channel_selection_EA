function [selected_pop]=select(pop,popsize,chromosize,sum_error,errortable)

selected_pop(popsize,chromosize)=0;
for i=1:popsize
    r = rand *sum_error;%�������һ�����������0������Ӧ��֮�䣬��Ϊfitness_table(pop_size)Ϊ����Ӧ��
    first = 1;
    last = popsize;
    mid = round((last+first)/2);%��������Ӧ����ֵ
    idx = -1;
    while (first <= last) && (idx == -1) %�������з�ѡ�����
        if r > errortable(mid)%���������ֵ������Ӧ��֮��
            first = mid;%��һ��ֵȡ��ֵ����ѭ��
        elseif r < errortable(mid)%ͬ��
            last = mid;
        else
            idx = mid;
            break;%һֱѭ��ֱ���õ���ֵʱ����ѭ��
        end
        mid = round((last+first)/2);
        if (last - first) == 1
            idx = last;
            break;
        end
    end
    for j=1:chromosize
        selected_pop(i,j)=pop(idx,j);%�Ŵ�����һ����Ⱥ
    end
end









end