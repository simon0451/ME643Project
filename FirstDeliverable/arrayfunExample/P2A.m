%Simon Popecki
%Main function
%Recovered 23 November 2016

clear all
close all

%% Initial Conditions
%Water is in the condenser at point 1, ready to be pumped to point 2
%Finding initial conditions with XSteam based on T1
T1 = 20; %C
%v1 = XSteam('vL_T',T1);
v1 = .001017; %(m^3/kg) Specific volume of liquid water from CAT3
P1 = 1; %(Bar) Finding the pressure at the saturation point for T1
s1 = XSteam('sL_T',T1); %(kJ/kg*C) Finding the specific entropy...

%% Isentropic Compression [States 1-2] - Pumping the water (Work in)
P2 = 45; %(Bar) The high pressure of this Rankine cycle
s2 = s1; %(kJ/kg*C) Entropy remians constant during the pumping process

T2 = XSteam('T_ps',P2,s2); %(C) Finding the temperature after pumping
v2 = XSteam('v_pt',P2,T2); %(m^3/kg) Finding the specific enthalpy after pumping

%Array values
s12 = linspace(s1,s2);
T12 = linspace(T1,T2);
P12 = linspace(P1,P2);
v12 = arrayfun(@(x) XSteam('v_ps',x,s1),P12);


%% Isobaric heating [States 2-3] - boiling the water (Heat in)
T3 = 400; %(C) Heat is added until the water becomes a superheated vapor
P3 = P2; %(Bar) Pressure remains constant because the process is isobaric
s3 = XSteam('s_pt',P3,T3); %(kJ/kg*C) Finding entropy at s3
v3 = XSteam('v_pt',P3,T3); %(m^3/kg) Finding enthalpy at h3

%Array values
T23 = linspace(T2,T3,500);
s23 = arrayfun(@(t) XSteam('s_pt',P2,t),T23);
P23 = linspace(P2,P3);
v23 = arrayfun(@(x) XSteam('v_pt',x,T2),P23);

%% Isentropic expansion [States 3-4] - turning the turbine (Work out)
s4 = s3; %(kJ/kg*C) Entropy remians constant through the turbine
T4 = T1; %(C) The temperature after the steam goes through the turbine
P4 = P1; %XSteam('psat_T',T4); %The turbine is exhausted to the condeser
v4 = XSteam('v_pt',P4,T4); %(m^3/kg) The specific volume of the water after going through the turbine


%Array values
s34 = linspace(s3,s4);
T34 = linspace(T3,T4);
P34 = linspace(P3,P4,300);
v34 = arrayfun(@(x) XSteam('v_ps',x,s4),P34);


%% Isobaric cooling [States 4-1] - the water is cooled through a condenser
%(Heat out)

T41 = linspace(T1,T4);
s41 = linspace(s1,s4);
P41 = linspace(P1,P4);
v41 = linspace(v1,v4);

%% Vapor Dome
Tdome = linspace(0,800,400);
satLiquids = arrayfun(@(t) XSteam('sL_T',t),Tdome);
satVapors = arrayfun(@(t) XSteam('sV_T',t),Tdome);

Pdome = linspace(0,1000,400);
satLiquidv = arrayfun(@(t) XSteam('vL_p',t),Pdome);
satVaporv = arrayfun(@(t) XSteam('vV_p',t),Pdome);

%% Effects of High T and High P

HIGHT = [P3 500]; %With the same high pressure value, P3 (45 Bar). T is increased from 400 C to 500 C
HIGHP = [60 T3]; %Pressure increases from 45 Bar to 50 Bar, T3 remains 400 C

[PT,vT,TT,sT,MASS_FLOW_RATE_T] = PvTs(HIGHT);
[PP,vP,TP,sP,MASS_FLOW_RATE_P] = PvTs(HIGHP);

%% Efficiency and Specific Net Work

T23E = T23+273; %Converting to Kelvin for efficiency calculations
T41E = T41+273;
QH = abs(trapz(s23,T23E));
QL = abs(trapz(s41,T41E));
Eff = ((QH-QL)/QH)*100; %(Percentage)
spWork = QH-QL; %kJ/kg
MASS_FLOW_RATE = (100000/spWork); %We are only dividing by 100000 because spWork is in kJ/kg

%Effects of pressure and temperature on the efficiency and specific net
%work of the cycle
Tarray = linspace(300,600,400); %(C)
[spWorkT,EffT] = arrayfun(@(x) PvTsT(x),Tarray); %Sp. work and efficiency go up with higher T-high
Parray = linspace(35,80,400); %(Bar)
[spWorkP,EffP] = arrayfun(@(x) PvTsP(x),Parray); %Sp. work and efficiency go up with higher P-high as well

%% Seasonal Changes on the Power Plant

%Winter/Summer Pv Ts
[PW,vW,TW,sW] = PvTsSW(1); %(C)
[PS,vS,TS,sS] = PvTsSW(20); %(C)

rTemps = linspace(1,30);
[EffR,spWorkR] = arrayfun(@(x) EffspW(x),rTemps);

%% Plotting

%Plotting Arrays
P = [P12 P23 P34 P41];
v = [v12 v23 v34 v41];
T = [T12 T23 T34 T41];
s = [s12 s23 s34 s41];
DOMEv = [satVaporv satLiquidv];
PDOME = [Pdome Pdome];
DOMEs = [satVapors satLiquids];
TDOME = [Tdome Tdome];

%% Reference Cycle
%P-v Diagram
figure
subplot(1,2,1)
semilogx(v,P,DOMEv,PDOME,':r',vT,PT,vP,PP)
grid on
%title('Rankine Cycle P-v Diagram')
xlabel('Specific volume (m^3/kg)')
ylabel('Pressure (Bar)')
hold on
legend('Reference','Vapor Dome','Elevated Temperature','Elevated Pressure')

%T-s Diagram
subplot(1,2,2)
plot(s,T,DOMEs,TDOME,':r',sT,TT,sP,TP)
%grid on
%title('Rankine Cycle T-s Diagram')
xlabel('Specific Entropy (kJ/(kg*C))')
ylabel('Temperature (C)')
hold on
legend('Location','northwest','Reference','Vapor Dome','Elevated Temperature','Elevated Pressure')

%% Effect of pressure and temperature on efficiency
figure
subplot(1,2,1)
%title('Effect of High Temperature on Efficiency and Specific Net Work')
plot(Tarray,spWorkT)
xlabel('Temperature (C)')
ylabel('Specific Net Work (kJ/kg)')
yyaxis right
plot(Tarray,EffT)
legend('Location','northwest','Specific Net Work','Efficiency')
ylabel('Efficiency (%)')

subplot(1,2,2)
%title('Effect of High Pressure on Efficiency and Specific Net Work')
plot(Parray,spWorkP)
xlabel('Pressure (Bar)')
ylabel('Specific Net Work (kJ/kg)')
yyaxis right
plot(Parray,EffP)
legend('Location','northwest','Specific Net Work','Efficiency')
ylabel('Efficiency (%)')                                                               

%% Seasonal Effects

%P-v Diagram
figure
subplot(1,2,1)
semilogx(DOMEv,PDOME,':r',vW,PW,vS,PS)
grid on
%title('Rankine Cycle P-v Diagram')
xlabel('Specific volume (m^3/kg)')
ylabel('Pressure (Bar)')
hold on
legend('Vapor Dome','Winter','Summer')

%T-s Diagram
subplot(1,2,2)
plot(DOMEs,TDOME,':r',sW,TW,sS,TS)
%grid on
%title('Rankine Cycle T-s Diagram')
xlabel('Specific Entropy (kJ/(kg*C))')
ylabel('Temperature (C)')
hold on
legend('Location','northwest','Vapor Dome','Winter','Summer')

%Efficiency and Specific Net Work
figure
plot(rTemps,spWorkR)
xlabel('River Temperature (C)')
ylabel('Specific Net Work (kJ/kg)')
yyaxis right
plot(rTemps,EffR)
legend('Location','northwest','Specific Net Work','Efficiency')
ylabel('Efficiency (%)')                                                               