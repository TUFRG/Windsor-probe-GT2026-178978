%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIVE-HOLE PROBE UNCERTAINTY PROPAGATION

clear; clc;

%% ====================== USER SETTINGS ================================ %%
uP = 5;                    % pressure uncertainty- DSA3217 (Pa)
u_rep = 0.02;              % repeatability uncertainty (all coeffs)
urho=0.01;

%% ====================== LOAD FILES ================================== %%
cal = readtable("Calibration.xlsx");
expd = readtable("Experiment.xlsx");

%% ====================== EXTRACT CALIBRATION DATA ===================== %%
P1 = cal.P1;
P2 = cal.P2;
P3 = cal.P3;
P4 = cal.P4;
P5 = cal.P5;
P0 = cal.Ptot;
P  = cal.Pstatic;
rho=cal.rho;
V=cal.v;
alpha = cal.Alpha;
beta  = cal.Beta;

%% ====================== COMPUTE CALIBRATION COEFFICIENTS ============= %%
Pavg = 0.5*(min(P1,P3) + min(P2,P4));
den  = P5 - Pavg;

Calpha = (P1 - P3)./den;
Cbeta  = (P2 - P4)./den;
Cp     = (Pavg - P)./den;
Cp0    = (P5 - P0)./den;

%% ================== CALIBRATION COEFFICIENT UNCERTAINTIES ============= %%
N = height(cal);
% preallocate arrays
u_Calpha_cal = zeros(N,1);
u_Cbeta_cal  = zeros(N,1);
u_Cp_cal     = zeros(N,1);
u_Cp0_cal    = zeros(N,1);

for i = 1:N

    %% --- determine Pavg = 0.5(min(P1,P3) + min(P2,P4)) ---
    if P1(i) <= P3(i)
        dPavg_dP1 = 0.5;
        dPavg_dP3 = 0;
    else
        dPavg_dP1 = 0;
        dPavg_dP3 = 0.5;
    end

    if P2(i) <= P4(i)
        dPavg_dP2 = 0.5;
        dPavg_dP4 = 0;
    else
        dPavg_dP2 = 0;
        dPavg_dP4 = 0.5;
    end

    % Pressure P and P0 do not enter Pavg:
    dPavg_dP  = 0;
    dPavg_dP0 = 0;

    den_i = den(i);

    %% ===================== CALPHA = (P1 - P3) / den ===================
    % d(Ca)/dP1
    dCa_dP1 = ( 1*den_i - (P1(i)-P3(i))* (-dPavg_dP1) ) / den_i^2;

    % d(Ca)/dP3
    dCa_dP3 = ( -1*den_i - (P1(i)-P3(i))* (-dPavg_dP3) ) / den_i^2;

    % d(Ca)/dP2
    dCa_dP2 = -(P1(i)-P3(i))* (-dPavg_dP2) / den_i^2;

    % d(Ca)/dP4
    dCa_dP4 = -(P1(i)-P3(i))* (-dPavg_dP4) / den_i^2;

    % d(Ca)/dP5 : den = P5 - Pavg
    dCa_dP5 = -(P1(i)-P3(i))*(1) / den_i^2;

    % d(Ca)/dP and d(Ca)/dP0 are zero
    dCa_dP  = 0;
    dCa_dP0 = 0;

    u_Calpha_cal(i) = sqrt( ...
        (dCa_dP1*uP)^2 + (dCa_dP2*uP)^2 + (dCa_dP3*uP)^2 + ...
        (dCa_dP4*uP)^2 + (dCa_dP5*uP)^2 + ...
        (dCa_dP *uP)^2 + (dCa_dP0*uP)^2);


    %% ==================== CBETA = (P2 - P4) / den =====================
    dCb_dP1 = -(P2(i)-P4(i))*(-dPavg_dP1) / den_i^2;
    dCb_dP3 = -(P2(i)-P4(i))*(-dPavg_dP3) / den_i^2;

    dCb_dP2 = (1*den_i - (P2(i)-P4(i))*(-dPavg_dP2)) / den_i^2;
    dCb_dP4 = (-1*den_i - (P2(i)-P4(i))*(-dPavg_dP4)) / den_i^2;

    dCb_dP5 = -(P2(i)-P4(i))*1 / den_i^2;

    dCb_dP  = 0;
    dCb_dP0 = 0;

    u_Cbeta_cal(i) = sqrt( ...
        (dCb_dP1*uP)^2 + (dCb_dP2*uP)^2 + (dCb_dP3*uP)^2 + ...
        (dCb_dP4*uP)^2 + (dCb_dP5*uP)^2 + ...
        (dCb_dP *uP)^2 + (dCb_dP0*uP)^2);


    %% ======================= CP = (Pavg - P) / den =====================
    dCp_dP1 = (dPavg_dP1 * den_i - (Pavg(i)-P(i))*(-dPavg_dP1)) / den_i^2;
    dCp_dP3 = (dPavg_dP3 * den_i - (Pavg(i)-P(i))*(-dPavg_dP3)) / den_i^2;

    dCp_dP2 = (dPavg_dP2 * den_i - (Pavg(i)-P(i))*(-dPavg_dP2)) / den_i^2;
    dCp_dP4 = (dPavg_dP4 * den_i - (Pavg(i)-P(i))*(-dPavg_dP4)) / den_i^2;

    dCp_dP5 = -(Pavg(i)-P(i))*1 / den_i^2;

    dCp_dP  = -1/den_i;
    dCp_dP0 = 0;

    u_Cp_cal(i) = sqrt( ...
        (dCp_dP1*uP)^2 + (dCp_dP2*uP)^2 + (dCp_dP3*uP)^2 + ...
        (dCp_dP4*uP)^2 + (dCp_dP5*uP)^2 + (dCp_dP*uP)^2 + ...
        (dCp_dP0*uP)^2 );


    %% ===================== CP0 = (P5 - P0) / den =======================
    dCp0_dP1 = -(P5(i)-P0(i))*(-dPavg_dP1) / den_i^2;
    dCp0_dP3 = -(P5(i)-P0(i))*(-dPavg_dP3) / den_i^2;

    dCp0_dP2 = -(P5(i)-P0(i))*(-dPavg_dP2) / den_i^2;
    dCp0_dP4 = -(P5(i)-P0(i))*(-dPavg_dP4) / den_i^2;

    dCp0_dP5 = (1*den_i - (P5(i)-P0(i))*1) / den_i^2;

    dCp0_dP  = 0;
    dCp0_dP0 = (-1*den_i - (P5(i)-P0(i))*0) / den_i^2;

    u_Cp0_cal(i) = sqrt( ...
        (dCp0_dP1*uP)^2 + (dCp0_dP2*uP)^2 + (dCp0_dP3*uP)^2 + ...
        (dCp0_dP4*uP)^2 + (dCp0_dP5*uP)^2 + (dCp0_dP*uP)^2 + ...
        (dCp0_dP0*uP)^2 );

end

%% ====================== BUILDING INTERPOLATION MAPS ====================== %%
F_alpha = scatteredInterpolant(Calpha, Cbeta, alpha, 'natural');
F_beta  = scatteredInterpolant(Calpha, Cbeta, beta,  'natural');
F_Cp    = scatteredInterpolant(Calpha, Cbeta, Cp,    'natural');
F_Cp0   = scatteredInterpolant(Calpha, Cbeta, Cp0,   'natural');

%% ====================== PROCESSING EXPERIMENTAL DATA ======================= %%
P1e = expd.P1;
P2e = expd.P2;
P3e = expd.P3;
P4e = expd.P4;
P5e = expd.P5;

Pavge = 0.5*(min(P1e,P3e) + min(P2e,P4e));
dene  = P5e - Pavge;

Calpha_exp = (P1e - P3e)./dene;
Cbeta_exp  = (P2e - P4e)./dene;

%% ==================Experimental  COEFFICIENT UNCERTAINTIES ============= %%
N = height(expd);

% preallocate arrays
u_Calpha_exp = zeros(N,1);
u_Cbeta_exp  = zeros(N,1);


for i = 1:N

    %% --- determine Pavg = 0.5(min(P1,P3) + min(P2,P4)) ---
    if P1e(i) <= P3e(i)
        dPavge_dP1e = 0.5;
        dPavge_dP3e= 0;
    else
        dPavge_dP1e = 0;
        dPavge_dP3e = 0.5;
    end

    if P2e(i) <= P4e(i)
        dPavge_dP2e = 0.5;
        dPavge_dP4e = 0;
    else
        dPavge_dP2e = 0;
        dPavge_dP4e = 0.5;
    end

    % Pressure P and P0 do not enter Pavg:
    dPavge_dPe  = 0;
    dPavge_dP0e = 0;

    dene_i = den(i);

    %% ===================== CALPHAexp = (P1e - P3e) / dene ===================
    % d(Ca)/dP1e
    dCa_dP1e = ( 1*dene_i - (P1e(i)-P3e(i))* (-dPavge_dP1e) ) / dene_i^2;

    % d(Ca)/dP3e
    dCa_dP3e = ( -1*dene_i - (P1e(i)-P3e(i))* (-dPavge_dP3e) ) / dene_i^2;

    % d(Ca)/dP2e
    dCa_dP2e = -(P1e(i)-P3e(i))* (-dPavge_dP2e) / dene_i^2;

    % d(Ca)/dP4e
    dCa_dP4e = -(P1e(i)-P3e(i))* (-dPavge_dP4e) / dene_i^2;

    % d(Ca)/dP5e : dene = P5e - Pavge
    dCa_dP5e = -(P1e(i)-P3e(i))*(1) / dene_i^2;

    % d(Ca)/dP and d(Ca)/dP0 are zero
    dCa_dPe  = 0;
    dCa_dP0e = 0;

    u_Calpha_exp(i) = sqrt( ...
        (dCa_dP1e*uP)^2 + (dCa_dP2e*uP)^2 + (dCa_dP3e*uP)^2 + ...
        (dCa_dP4e*uP)^2 + (dCa_dP5e*uP)^2 + ...
        (dCa_dPe *uP)^2 + (dCa_dP0e*uP)^2);


    %% ==================== CBETAexp = (P2e - P4e) / dene =====================
    dCb_dP1e = -(P2e(i)-P4e(i))*(-dPavge_dP1e) / dene_i^2;
    dCb_dP3e = -(P2e(i)-P4e(i))*(-dPavge_dP3e) / dene_i^2;

    dCb_dP2e = (1*dene_i - (P2e(i)-P4e(i))*(-dPavge_dP2e)) / dene_i^2;
    dCb_dP4e = (-1*dene_i - (P2e(i)-P4e(i))*(-dPavge_dP4e)) / dene_i^2;

    dCb_dP5e = -(P2e(i)-P4e(i))*1 / dene_i^2;

    dCb_dPe  = 0;
    dCb_dP0e = 0;

    u_Cbeta_exp(i) = sqrt( ...
        (dCb_dP1e*uP)^2 + (dCb_dP2e*uP)^2 + (dCb_dP3e*uP)^2 + ...
        (dCb_dP4e*uP)^2 + (dCb_dP5e*uP)^2 + ...
        (dCb_dPe *uP)^2 + (dCb_dP0e*uP)^2);
end

%% ====================== UNCERTAINTY PROPAGATION ====================== %%
% numerical gradients ∂α/∂Calpha, ∂α/∂Cbeta
[dadCa, dadCb] = calc_grad(F_alpha, Calpha_exp, Cbeta_exp);
[dbdCa, dbdCb] = calc_grad(F_beta , Calpha_exp, Cbeta_exp);
[dcpdCa, dcpdCb] = calc_grad(F_Cp, Calpha_exp, Cbeta_exp);
[dcp0dCa, dcp0dCb] = calc_grad(F_Cp0 , Calpha_exp, Cbeta_exp);

u_Calpha_tot=sqrt(u_Calpha_exp.^2 +u_Calpha_cal.^2 + u_rep^2);
u_Cbeta_tot=sqrt(u_Cbeta_exp.^2 +u_Cbeta_cal.^2 + u_rep^2);

% Angle uncertainties 
u_alpha = sqrt( (dadCa.*u_Calpha_tot).^2 + (dadCb.*u_Cbeta_tot).^2 );
u_beta  = sqrt( (dbdCa.*u_Calpha_tot).^2 + (dbdCb.*u_Cbeta_tot).^2);
u_Cpexp = sqrt( (dcpdCa.*u_Calpha_tot).^2 + (dcpdCb.*u_Cbeta_tot).^2 );
u_Cp0exp  = sqrt( (dcp0dCa.*u_Calpha_tot).^2 + (dcp0dCb.*u_Cbeta_tot).^2);

u_Cp_tot=sqrt(u_Cpexp.^2 +u_Cp_cal.^2 + u_rep^2);
u_Cp0_tot=sqrt(u_Cp0exp.^2 +u_Cp0_cal.^2 + u_rep^2);

%P and P0 uncertainities
p  = Pavg - Cp .* (P5 - Pavg);
p0 = P5 - Cp0 .* (P5 -Pavg);
u_p = sqrt( 12.5*(1 + 2*Cp + Cp.^2) + 25*(Cp.^2) + (Pavg - P5).^2 .* (u_Cp_tot.^2) );
u_p0 = sqrt( (Cp0.^2).*12.5 + ((1 - Cp0).^2).*25 + (Pavg - P5).^2 .* (u_Cp0_tot.^2) );
u_vd = sqrt(u_p0.^2 + u_p.^2 + ((p0 - p).*urho./rho).^2) ./ (rho.*V);
ualphap=100*u_alpha./alpha;
ubetap=100*u_beta./beta;
uvdpercentage=100*u_vd./V;

%% ====================== SAVE OUTPUT ================================= %%
result = table(alpha,beta,V,u_alpha,u_beta,u_vd,ualphap,ubetap,uvdpercentage);
writetable(result,"Uncertainity8000.xlsx");
fprintf("Saved → uncertainty_results.xlsx\n");

%CENTRAL DIFFERENCE CALCULATOR / GRADIENT OF MAPS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dfdCa, dfdCb] = calc_grad(F, Ca, Cb)
    h = 1e-5;
    f1 = F(Ca+h, Cb);
    f2 = F(Ca-h, Cb);
    f3 = F(Ca, Cb+h);
    f4 = F(Ca, Cb-h);

    dfdCa = (f1 - f2)/(2*h);
    dfdCb = (f3 - f4)/(2*h);
end
