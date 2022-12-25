%============================================================================%
%                                                                                   BATTERY                                                                                                              % 
%                             version 1.0                                                                                                                                                                 %
%                       -----------------------                                                                                                                                                        %
%                    Developed in MATLAB R2013a                                                                                                                                         %
%                       -----------------------                                                                                                                                                        %
%                       Authors and programmers:                                                                                                                                            %
%                            Mohamed Ibrahim Zineldin                                                                                                                                       %
%                      e-Mail: mozain361@gmail.com                                                                                                                                       %
%                       -----------------------                                                                                                                                                          %
%   
%============================================================================%
%_______________________________________________________________________________________________
% % clear all 
% % clc
% % close all
main1
EO1=OPTIMA;
EOPARA=paramaters;

Main
[MRFO, ind]=min(OPTIMA2);
MRFOPARA=paramaters2(ind,:);
RESULTS=[EO1, MRFO];
% resultsEO(i)=[Min];
% [BestX,BestF,HisBestF]=MRFO(FunIndex,Max_iteration,SearchAgents_no);
% resultsMRFO(i)=[BestF];
% resultsEO=resultsEO';
% resultsMRFO=resultsMRFO';
% RESULTS=[resultsEO,resultsMRFO];
