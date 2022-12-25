%--------------------------------------------------------------------------
% MRFO code v1.0.
% Developed in MATLAB R2011b
% The code is based on the following papers.
% W. Zhao, Z. Zhang and L. Wang, Manta ray foraging optimization: An
% effective bio-inspired optimizer for engineering applications.
% Engineering Applications of Artifical Intelligence (2019),
% https://dio.org/10.1016/j.engappai.2019.103300.
% -------------------------------------------------------------------------

% clc;
% clear;
 
MaxIteration=1000; 
PopSize=50;
Run_no=5;% runs 
%  FunIndex=5;
OPTIMA2=[];paramaters2=[];
for i=1:3
    for ui=1:Run_no
 FunIndex=100+i;
% [BestX,BestF,HisBestF]=MRFO(FunIndex,MaxIteration,PopSize);

[BestX,BestF,HisBestF]=MRFO_PSO(FunIndex,MaxIteration,PopSize);

% display(['F_index=', num2str(FunIndex)]);
% display(['The best fitness is: ', num2str(BestF)]);
Optimal(FunIndex)=BestF;

%display(['The best solution is: ', num2str(BestX)]);
%  if BestF>=0
%      semilogy(HisBestF,'r','LineWidth',2);
%  else
%      plot(HisBestF,'r','LineWidth',2);
%  end
%  xlabel('Iterations');
%  ylabel('Fitness');
%  title(['F',num2str(FunIndex)]);
 OPTIMA2(ui)=BestF;
 paramaters2=[paramaters2;BestX];
    end
    
    
end








