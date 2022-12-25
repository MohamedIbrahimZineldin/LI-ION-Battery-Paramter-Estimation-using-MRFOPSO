%--------------------------------------------------------------------------
%                    Developed in MATLAB R2013a                                                                                                                                         %
%                       -----------------------                                                                                                                                                        %
%                       Author and programmer:                                                                                                                                            %
%                            Mohamed Ibrahim Zineldin                                                                                                                                       %
%                      e-Mail: mozain361@gmail.com                                                                                                                                       %
% based on 
% MRFO code v1.0.
% Developed in MATLAB R2011b
% The code is based on the following papers.
% W. Zhao, Z. Zhang and L. Wang, Manta ray foraging optimization: An
% effective bio-inspired optimizer for engineering applications.
% Engineering Applications of Artifical Intelligence (2019),
% https://dio.org/10.1016/j.engappai.2019.103300.
% -------------------------------------------------------------------------
% FunIndex: Index of function.
% MaxIt: The maximum number of iterations.
% PopSize: The size of population.
% PopPos: The position of population.
% PopFit: The fitness of population.
% Dim: The dimensionality of prloblem.
% Alpha: The weight coefficient in chain foraging.
% Beta: The weight coefficient in cyclone foraging.
% S: The somersault factor.
% BestF: The best fitness corresponding to BestX. 
% HisBestFit: History best fitness over iterations. 
% Low: The low bound of search space.
% Up: The up bound of search space.

function [BestX,BestF,HisBestFit]=MRFO_PSO(F_index,MaxIt,nPop)


         [Low,Up,Dim]=FunRange(F_index); 
X1=zeros(1,Dim);   BestF1=inf; 
X2=zeros(1,Dim);   BestF2=inf; 
X3=zeros(1,Dim);   BestF3=inf; 
velocity = .3*rand(nPop,Dim);
y= .3*rand(nPop,Dim);
% velocity = .2*rand(nPop,Dim);
% y= .2*rand(nPop,Dim);
    for i=1:nPop   
        PopPos(i,:)=rand(1,Dim).*(Up-Low)+Low;
        PopFit(i)=BenFunctions(PopPos(i,:),F_index,Dim);   
    end
       BestF=inf;
       BestX=[];

    for i=1:nPop
        if PopFit(i)<=BestF
           BestF=PopFit(i);
           BestX=PopPos(i,:);
        end
    end

       HisBestFit=zeros(MaxIt,1);


for It=1:MaxIt  
     Coef=It/MaxIt; 
     
       if rand<0.5
          r1=rand;                         
          Beta=2*exp(r1*((MaxIt-It+1)/MaxIt))*(sin(2*pi*r1));    
          if  Coef>rand                                                      
              newPopPos(1,:)=BestX+rand(1,Dim).*(y(1,:)-PopPos(1,:))+Beta*(y(1,:)-PopPos(1,:)); %Equation (4)
          else
              IndivRand=rand(1,Dim).*(Up-Low)+Low;                                
              newPopPos(1,:)=IndivRand+rand(1,Dim).*(IndivRand-PopPos(1,:))+Beta*(IndivRand-PopPos(1,:)); %Equation (7)         
          end              
       else 
            Alpha=2*rand(1,Dim).*(-log(rand(1,Dim))).^0.5;           
            newPopPos(1,:)=PopPos(1,:)+rand(1,Dim).*(y(1,:)-PopPos(1,:))+Alpha.*(y(1,:)-PopPos(1,:)); %Equation (1)
       end
     
    for i=2:nPop
        if rand<0.5
           r1=rand;                         
           Beta=2*exp(r1*((MaxIt-It+1)/MaxIt))*(sin(2*pi*r1));    
             if  Coef>rand                                                      
                 newPopPos(i,:)=BestX+rand(1,Dim).*(PopPos(i-1,:)-PopPos(i,:))+Beta*(y(1,:)-PopPos(i,:)); %Equation (4)
             else
                 IndivRand=rand(1,Dim).*(Up-Low)+Low;                                
                 newPopPos(i,:)=IndivRand+rand(1,Dim).*(PopPos(i-1,:)-PopPos(i,:))+Beta*(IndivRand-PopPos(i,:));  %Equation (7)       
             end              
        else
            Alpha=2*rand(1,Dim).*(-log(rand(1,Dim))).^0.5;           
            newPopPos(i,:)=PopPos(i,:)+rand(1,Dim).*(PopPos(i-1,:)-PopPos(i,:))+Alpha.*(y(1,:)-PopPos(i,:)); %Equation (1)
       end         
    end
         
           for i=1:nPop        
               newPopPos(i,:)=SpaceBound(newPopPos(i,:),Up,Low);
               newPopFit(i)=BenFunctions(newPopPos(i,:),F_index,Dim); 
              if newPopFit(i)<PopFit(i)
                 PopFit(i)=newPopFit(i);
                 PopPos(i,:)=newPopPos(i,:);
              end
           end
     
            S=2;
        for i=1:nPop           
          
            % Eq. (3.3)
%             newPopPos(i,:)=PopPos(i,:)+S*(rand*y(i,:)-rand*PopPos(i,:)); %Equation (8)
            newPopPos(i,:)=PopPos(i,:)+S*(rand*BestX-rand*PopPos(i,:)); %Equation (8)

%            w=0.05+rand()/2;%for battery
           w=0.2+rand()/2;
%            w=1;
          C1=0.8;
          C2=0.8;          
%           C1=.5;%for battery
%           C2=.5;%for battery
%           C3=0.5;%for battery
          r1=rand;r2=rand();r3=rand;
%           velocity(i,:)=w*(velocity(1,:)+C1*r1*(X1-PopPos(i,:)))+C2*r2*(X2-PopPos(i,:))+C3*r3*(X3-PopPos(i,:));
          velocity(i,:)=w*(velocity(1,:)+C1*r1*(X1-PopPos(i,:)))+C2*r2*(X2-PopPos(i,:));
          y(i,:)=PopPos(i,:)+velocity(i,:);
        
        end
     
     for i=1:nPop        
         newPopPos(i,:)=SpaceBound(newPopPos(i,:),Up,Low);
         newPopFit(i)=BenFunctions(newPopPos(i,:),F_index,Dim);    
         if newPopFit(i)<PopFit(i)
            PopFit(i)=newPopFit(i);
            PopPos(i,:)=newPopPos(i,:);
         end
     end
     
     for i=1:nPop
        if PopFit(i)<BestF
           BestF=PopFit(i);
           BestX=PopPos(i,:);            
        end
         if PopFit(i)<BestF1 
              BestF1=PopFit(i);  X1=PopPos(i,:);
        elseif PopFit(i)>BestF1 && PopFit(i)<BestF2  
              BestF2=PopFit(i);  X2=PopPos(i,:);              
        elseif PopFit(i)>BestF1 && PopFit(i)>BestF2 && PopFit(i)<BestF3
              BestF3=PopFit(i);  X3=PopPos(i,:);
         end
     end
 
  
     HisBestFit(It)=BestF;
end


