function [error,best_individual,smallest_error,ordered_pop]=error_cal(pop,popsize,chromosize,channel_wise,weight,x,bias,y,r,samplesize)
error(popsize)=0;
for each_indiv=1:popsize
    
    index=find(pop(each_indiv,:)==1);
    col_stored=length(index)*channel_wise;
    
    %select channels
    id=pop(each_indiv,:)'*ones(1,channel_wise);
    [row_id,col_id]=size(id);
    id=reshape(id',1,row_id*col_id);
    iid= id==1;
    new_weight=weight(:,iid);
    new_data_x=x(iid,:);
    [~,col]=size(new_weight);
    assert(col==col_stored);
    [data_row,~]=size(new_data_x);
    assert(data_row==col_stored);
    %error calculated
    if(length(index)<=round(chromosize*r))
        
        %         error(each_indiv)=0.5*sqrt(sum(abs(y-new_weight*new_data_x-repmat(bias,1,samplesize)).^2));
        error(each_indiv)=norm(y-new_weight*new_data_x-repmat(bias,1,samplesize),2);
%         result = y-new_weight*new_data_x-repmat(bias,1,samplesize);
%         error(each_indiv)=sqrt(trace(result'*result));
    else
        error(each_indiv)=inf;
    end
    
end


[smallest_error,best_individual_index]=min(error);
best_individual=pop(best_individual_index,:);
%ranked by error
[error,I]=sort(error);
ordered_pop(popsize,chromosize)=0;
for i=1:popsize
    ordered_pop(i,:)=pop(I(i),:);
end
















end
