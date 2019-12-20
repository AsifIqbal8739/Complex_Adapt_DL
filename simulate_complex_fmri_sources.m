clear all;
close all;
xdim=60;
ydim=60;
xy_dim=xdim*ydim;
timeset=100;
num_sources=8;
figure;
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%Source 1
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *

pd1=2;
pd2=3;
w=[0:2*pi/(xdim-1):2*pi];
S1=sin(pd1.*w')*sin(pd2.*w);
image(100*S1); 
S1n=zeros(60,60);
for j=41:50
    for k=31:45
        S1n(k,j)=S1(k,j);
    end;
    for k=1:15
        S1n(k,j)=S1(k,j);
    end;
end;
S1=S1n;

    phase = (rand(xdim)*20-10)/180*pi;
cS1 = S1.*exp(i*phase);

subplot(num_sources,2,1);
imagesc(S1); 
colormap gray;

%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%Source 2
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *

pd1=3;
pd2=4;
w=[0:2*pi/(xdim-1):2*pi];
S2=sin(pd1.*w')*sin(pd2.*w);
S2n=zeros(60,60);
for k=11:20
    for j=9:15
        S2n(k,j)=S2(k,j);
    end;
end;
for k=31:40
    for j=9:15
        S2n(k,j)=S2(k,j);
    end;
end;
for k=21:30
    for j=31:37
        S2n(k,j)=S2(k,j);
    end;
end;
S2n=S2n+0.5;
S2=S2n;
A=S2(11:20, 9:15);
S2(31:40, 39:45)=A;

    phase = (rand(xdim)*20-10)/180*pi;

S2 = S2-0.5;
cS2 = S2.*exp(i*phase);

subplot(num_sources,2,3);
imagesc(S2);
colormap gray;

%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%Source 3
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
pd1=0.5;
pd2=0.4;
w=[0:3*pi/(xdim-1):3*pi];
S3=sin(pd1.*w')*cos(pd2.*w);
temp=zeros(60,60);
temp(1:38,1:26)=S3(1:38,1:26);
S3=fliplr(temp);

    phase = (rand(xdim)*20-10)/180*pi;

S3 = abs(S3);
cS3 = S3.*exp(i*phase);

subplot(num_sources,2,5),imagesc(S3);colormap gray;

%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%Source 4
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *

S4 = zeros(60,60);

cnt=1;
for k=20-cnt:-1:16
    for j=20+cnt:40-cnt
        S4(k,j)=0.25;
    end
    cnt=cnt+2;
end
cnt=1;
for j=20:40
    for k=25:-1:20
       S4(k,j)=0.25;
    end
end 
for k=22+cnt:1:25
    for j=30-cnt:30+cnt
        S4(k,j)=S4(k,j)-0.20;
    end
    cnt=cnt+3;
end
cnt=1;
 for k=40+cnt:1:44
    for j=20+cnt:40-cnt
        S4(k,j)=-0.25;
    end
    cnt=cnt+2;
end       
 cnt=1;
for j=20:40
    for k=40:-1:34
       S4(k,j)=-0.25;
    end
end 
for k=38-cnt:-1:34
    for j=30-cnt:30+cnt
        S4(k,j)=S4(k,j)+0.20;
    end
    cnt=cnt+3;
end       

S_4=zeros(60,60);
for k=2:59
    for j=2:59
        for s=1:3
            for t=1:3
                S_4(k,j)=S_4(k,j)+S4(k-2+s,j-2+t);
                t=t+1;
            end
            s=s+1;
        end
    end
end

S4=S_4;
S4 = abs(S4);
    phase = (rand(xdim)*20-10)/180*pi;
cS4 = S4.*exp(i*phase);

subplot(num_sources,2,7);
imagesc(S4);
colormap gray; 

%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%Source 5
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
pd1=.5;
pd2=.9;
w=[0:4*pi/(xdim-1):4*pi];
t3=sin(pd1.*w')*sin(pd2.*w);
test=t3(33:57,35:50);
B=imresize(test,[21 11], 'bilinear');
S5=zeros(60,60);

S5(40:60,50:60)=-5*B;
    phase = (rand(xdim)*20-10)/180*pi;

S5 = abs(S5);
cS5 = S5.*exp(i*phase);

subplot(num_sources,2,9);
imagesc(S5);
colormap gray;

%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%Source 6
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
pd1=.5;
pd2=.9;
w=[0:4*pi/(xdim-1):4*pi];
S6=sin(pd1.*w')*sin(pd2.*w);
S6(:,1:33)=0;
S6(:,51:end)=0;
S6=rot90(rot90(S6));
s6=zeros(60,60);
s6(15:44,1:20)=S6(31:60,11:30);
s6(15:44,41:60)=S6(31:60,11:30);
s6=rot90(s6);
S6=s6;

    phase = (rand(xdim)*20-10)/180*pi;
cS6 = S6.*exp(i*phase);

subplot(num_sources,2,11),imagesc(S6);
colormap gray;

%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%Source 7
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *

S7 = zeros(60,60);
a=[0:pi/5:pi];
b=[0:pi/40:pi];
c = sin(b')*sin(a);
S7(10:50,27:32) = c;
S7(10:50,47:52) = c;

    phase = (rand(xdim)*20-10)/180*pi;
cS7 = S7.*exp(i*phase);

subplot(num_sources,2,13),imagesc(S7);
colormap gray;

%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%Source 8
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *

S8=zeros(60,60);
for j=59:-1:1
    for k=1:60
        S8(k,j)=S8(k,j+1)+1/60;
    end;
end;

    phase = (rand(xdim)*20-10)/180*pi;
cS8 = S8.*exp(i*phase);

subplot(num_sources,2,15);
imagesc(S8);
colormap gray;


S(1,:)=reshape(S1,1,xy_dim);
cS(1,:)=reshape(cS1,1,xy_dim);

S(2,:)=reshape(S2,1,xy_dim);
cS(2,:)=reshape(cS2,1,xy_dim);

S(3,:)=reshape(S3,1,xy_dim);
cS(3,:)=reshape(cS3,1,xy_dim);

S(4,:)=reshape(S4,1,xy_dim);
cS(4,:)=reshape(cS4,1,xy_dim);

S(5,:)=reshape(S5,1,xy_dim);
cS(5,:)=reshape(cS5,1,xy_dim);

S(6,:)=reshape(S6,1,xy_dim);
cS(6,:)=reshape(cS6,1,xy_dim);

S(7,:)=reshape(S7,1,xy_dim);
cS(7,:)=reshape(cS7,1,xy_dim);

S(8,:)=reshape(S8,1,xy_dim);
cS(8,:)=reshape(cS8,1,xy_dim);

%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%*  *   *                                       *   *   *
%*  *   *                                       *   *   *
%               create timecourses:
%*  *   *                                       *   *   *
%*  *   *                                       *   *   *
%*  *   *   *   *   *   *   *   *   *   *   *   *   *   *
%spike_col               = zeros([timeset 1]);
rand_col                = zeros([timeset 1]);  %Time course 5
rand_plus_constant_col  = zeros([timeset 1]);  %Time course 4
sin_col                 = zeros([timeset 1]);  %Time course 3
a_col                   = ones([timeset+20 1]);%Time course 1
derivative_col          = zeros([1 timeset+1]);%Time course 2
constant                =0.25;

%Time course 1
a_col_n = ones([timeset+20 1]);
for k=1:2:10
a_col_n(12*k+1:12*k+12)=-1;
end
x = (1:1:12);
y = normpdf(x,6,0.8);
y=y';
z=conv(a_col_n,y);
for k=1:100
alternating_col_new(k)=z(k+7);
end

for k=1:2:12
a_col(10*k+1:10*k+10)=-1;
end

x = (1:1:12);
y = normpdf(x,6,0.8);
y=y';
z=conv(a_col,y);
for k=1:timeset
alternating_col(k)=z(k+7);
end


%Time course 2
alternating_col=alternating_col';
for k=1:timeset
d(k)=alternating_col(k);
end
d(1,101)=z(108,1);
dif=diff(d);
derivative_col=dif';

%Time course 3
w_col= [0:2*pi/(timeset-1):2*pi];
sin_col= sin(w_col');
tmp=zeros(size(sin_col));
tmp(1:50,:)=sin_col(1:50,1);
tmp(51:100,:)=sin_col(51:100,1)-1;
sin_col=tmp;

% Time course 4
rand_plus_constant_col  = 0.5 + 0.05* randn([timeset 1]);
rand_plus_constant_col(timeset-30:timeset)=rand_plus_constant_col(timeset-30:timeset)+constant; 

%Time course 5
rand_col  = 0.75 + 0.07* randn([timeset 1]);

%Time Course 6
triangle_col=zeros(100,1);
count=0;
for k=1:100
    value=count/10+ 0.05* randn;
    triangle_col(k,1)=value;
    count=count+1;
    count=mod(count,10);
end
triangle_col=(-1)*triangle_col+1;

t=1:1:20;
x = (0.01:0.1:10);
p  = fpdf(x,5,20);
x1=zeros(1,20);
j=1;
for k=1: 20
x1(1,k)=p(1,j);
j=j+2;
end;
t=1:1:100;
x2=zeros(1,100);
c=0;
for k=1:5
    for j=1:20
        x2(1,j+c)=x1(1,j);
    end;
    c=c+20;
end;
t=zeros(1,100);
t(1,1:20)=x2(1,1:20);
t(1,9:18)=t(1,9:18)+x2(1,21:30);
t(1,21:40)=t(1,1:20);
t(1,41:60)=t(1,1:20);
t(1,61:80)=t(1,1:20);
t(1,81:100)=t(1,1:20);

%Time Course 7
exponential_col=zeros(100,1);
for k=1:100
    exponential_col(k,1)=k^2/7000;
end
    exponential_col(1:33,1) = exponential_col(67:99,1);
    exponential_col(34:66,1) = exponential_col(67:99,1);
    exponential_col(:,1) = exponential_col(:,1) + 0.03*randn(100,1);

%Time Course 8
spike_col=zeros(1,100);
spike_col= 0.2 + 0.1* randn([timeset 1]);
A=23;
spike_col(35,1)=spike_col(35,1)-2;

%populate W with columns we have created
W(:,1)=(alternating_col_new'+2)*0.8;
W(:,2)=abs(derivative_col)*1.3;
W(:,3)=spike_col+2;
W(:,4)=rand_plus_constant_col;
W(:,5)=(rand_col+0.3*cos(0.05*[1:2:200]'))*0.6;
W(:,6)=t'*1.2;
W(:,7)=(-1)*exponential_col+1.5;
W(:,8)=0.3*flipud(abs(sin_col));

ph = 0.05;
for j = 1:8
    cW(:,j)=W(:,j).*exp(i*ph*W(:,j));
end


subplot(num_sources,2,2);   plot(1:timeset, W(:,1)); 
subplot(num_sources,2,4);   plot(1:timeset, W(:,2));
subplot(num_sources,2,6);   plot(1:timeset,W(:,3));
subplot(num_sources,2,8);  plot(1:timeset,W(:,4));
subplot(num_sources,2,10);  plot(1:timeset, W(:,5));
subplot(num_sources,2,12);   plot(1:timeset,W(:,6));
subplot(num_sources,2,14);  plot(1:timeset,W(:,7));
subplot(num_sources,2,16);  plot(1:timeset, W(:,8));

% calculation of complex kurtosis
%for k = 1:8
%    ckurt(k) = kurtc(cS(k,:));
%end

cX = cW*cS;
     
%save('complex_data','cXN','cS','S','ckurt','W','cW');
% cS - Complex Sources
% cW - Complex TCs


