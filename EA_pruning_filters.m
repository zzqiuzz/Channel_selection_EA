clear
clc
addpath 'new_data'

%% parameters of filters
filter_num=512; %to be modified.
filter_channel=512;
filter_height=3;
filter_width=3;
filter_channel_wise=filter_height*filter_width;%weights number in a channel
col_buffer=filter_channel*filter_height*filter_width;
sample_size=10000;
%% load data
target_layer='conv4_3';% to be modified. layers for data sampling to select channels for the former layer.
file_data_x=[target_layer,'data_x.bin'];
file_data_y=[target_layer,'data_y.bin'];
file_bias=[target_layer,'bias.bin'];
file_weight=[target_layer,'weight.bin'];
fid_x=fopen(file_data_x,'r');
[data_x, ~]=fread(fid_x,'float');
fid_y=fopen(file_data_y,'r');
[data_y, ~]=fread(fid_y,'float');
fid_bias=fopen(file_bias,'r');
%read bias
[data_bias,~]=fread(fid_bias,'float');
fid_weight=fopen(file_weight,'r');
%read weight
[data_weight, ~]=fread(fid_weight,[filter_channel*filter_height*filter_width,filter_num],'float'); 
data_weight=data_weight';
data_x=reshape(data_x,[col_buffer,sample_size]);
data_y=reshape(data_y,[filter_num,sample_size]);
answer=data_weight*data_x+repmat(data_bias,1,sample_size);
%% parameters of EA
pop_size=10;%smaller may be better.
chromo_size=filter_channel;%filter's channel number 0.7 0.2 0.5 2000 77.303009
Pc=0.8;
Pm=0.2;
rate=0.5;
iterations=5000;
error(pop_size)=0;
error_table(pop_size)=0;
pop_sum_error=0;
best_individual(chromo_size)=0;
smallest_error=0;
smallest_error_store=zeros(1,iterations);
pop=pop_init(pop_size,chromo_size,rate);
% pop(pop_size,chromo_size)=0;
%% main of EA

for iter=1:iterations
    tic;
    pre_smallest_error=smallest_error;
     pre_best_individual=best_individual;
    [error,best_individual,smallest_error,pop]=error_cal(pop,pop_size,chromo_size,filter_channel_wise,data_weight,data_x,data_bias,data_y,rate,sample_size);
    [cross_pop]=cross(pop,pop_size,chromo_size,Pc);
    [mutate_pop]=mutate(cross_pop,pop_size,chromo_size,Pm);
    %select
    %cross
    %mutation'
    pop=[best_individual;mutate_pop];
%         pop=pop(1:pop_size,:);%this strategy has lower convergence speed than the latter.
        
    inf_index=find(error==inf);%re-init individual whose error==inf
    if length(inf_index)>=1
        pop_reinit=pop_init(length(inf_index),chromo_size,rate);
        pop=[pop(1:pop_size-length(inf_index),:);pop_reinit];
    else
        pop=pop(1:pop_size,:);
    end
    if(pre_smallest_error~=smallest_error)
    diff_num=length(find(pre_best_individual~=best_individual));
    fprintf('diff_num:%d\n',diff_num);
    end
    fprintf('iter:%d error:%f \n',iter,smallest_error);
    smallest_error_store(1,iter)=smallest_error; 
    toc;
end 
channel_selection=['prune_4_3_',num2str(smallest_error),'.bin',];
%write best_individual to .bin file for C++ to read.
fid=fopen(channel_selection,'wb');
assert(fid>0,'File open error!');
pruned_filter_index=find(best_individual==0);
fwrite(fid,pruned_filter_index,'int');
fclose(fid);    
plot(1:iterations,smallest_error_store,'-')
legend('GA')
ylabel('Error')
xlabel('iters')
save_file_name=[target_layer,'Pc',num2str(Pc),'Pm',num2str(Pm),'iter',num2str(iterations),'error',num2str(smallest_error),'rate',num2str(rate),'.mat'];
save(save_file_name,'Pc','Pm','iterations','smallest_error','best_individual','smallest_error_store','rate','pruned_filter_index','pop');











