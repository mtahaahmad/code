clear all

iM = 1;
f = 6;
w = 2 * pi * f;
t = 0 : 0.001 : 1;
theta = pi/3;

iA = iM * sin(w*t);
iB = iM * sin(w*t - 2*pi/3);
iC = iM * sin(w*t + 2*pi/3);

plot(t, [iA; iB; iC])
title('Three phase time varying system')

clarkeTF = [3/2 0 0; 0 sqrt(3)/2 -sqrt(3)/2];
invClarkeTF = [2/3 0; -1/3 1/sqrt(3); -1/3 -1/sqrt(3)];

for j = 1:length(t)
    
    parkTF([1 2], [(2*j)-1, 2*j]) = [cos(w*t(j) + theta) sin(w*t(j) + theta); -sin(w*t(j) + theta) cos(w*t(j) + theta)];
    invParkTF([1 2], [(2*j)-1, 2*j]) = [cos(w*t(j) + theta) -sin(w*t(j) + theta); sin(w*t(j) + theta) cos(w*t(j) + theta)];
    
end

iClarke = clarkeTF * [iA; iB; iC];

figure
hold on
plot(t, iClarke)
title('Clarke Transformaion')

for i = 1:length(t)
   
    iPark([1 2], i) =  [parkTF(1, (2*i)-1) parkTF(1, 2*i); parkTF(2, (2*i)-1) parkTF(2, 2*i)] * [iClarke(1, i); iClarke(2, i)];
    
end

figure
hold on
axis([0 1 -1.5 0])
plot(t, iPark)
title('Park Transformation')

for i = 1:length(t)
   
    inv_iClarke([1 2], i) =  [invParkTF(1, (2*i)-1) invParkTF(1, 2*i); invParkTF(2, (2*i)-1) invParkTF(2, 2*i)] * [iPark(1, i); iPark(2, i)];
    
end

figure
hold on
plot(t, inv_iClarke)
title('Inverse Clarke Transformation')

inv_sinusoid = invClarkeTF * inv_iClarke;
inv_iA = inv_sinusoid(1,:);
inv_iB = inv_sinusoid(2,:);
inv_iC = inv_sinusoid(3,:);

figure
hold on
plot(t, [inv_iA; inv_iB; inv_iC])
title('Inverse Park Transformation')