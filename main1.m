%_________________________________________________________________________________
%  Equilibrium Optimizer source code (Developed in MATLAB R2015a)
%
%  programming: Afshin Faramarzi & Seyedali Mirjalili
%
%  e-Mail: afaramar@hawk.iit.edu, afshin.faramarzi@gmail.com
%          ali.mirjalili@gmail.com
%
%  paper:
%  A. Faramarzi, M. Heidarinejad, B. Stephens, S. Mirjalili, 
%  Equilibrium optimizer: A novel optimization algorithm
%  Knowledge-Based Systems
%  DOI: https://doi.org/10.1016/j.knosys.2019.105190
%____________________________________________________________________________________

% --------------------------------------------
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of iterations
% Particles_no = number of particles (search agents)
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% ---------------------------------------------------------

clear all
clc
tic;
Run_no=5;         % Number of independent runs 
Particles_no=30;   % Number of particles
Max_iteration=1000; % Maximum number of iterations
paramaters=[];
OPTIMA=[];
for i=1:2
% Function_name='F1'; 
    Function_name=['F' num2str(i) ];
        
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
    
[Convergence_curve,Ave,Sd,Min,optimalsol]=EO(Particles_no,Max_iteration,lb,ub,dim,fobj,Run_no);

% display(['The average objective function is : ', num2str(Ave,7)]);
% display(['The standard deviation is : ', num2str(Sd,7)]);
% display(['The standard min is : ', num2str(Min,7)]);
OPTIMA(i)=Min;
paramaters=[paramaters;optimalsol];

toc;
end
        