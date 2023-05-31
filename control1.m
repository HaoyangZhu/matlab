function [dx,x1,x2,x3,u,w1,noxih1,noxic1,noxia1,noxih2,noxic2,noxia2,noxih3,noxic3,noxia3,c1,c2,c3,E1,E2,E3,ym]=control1(t,x)

x1=x(1);x2=x(2);x3=x(3);
xih1=[x(4) x(5) x(6) x(7) x(8)]'; noxih1=norm(xih1);
xic1=[x(9) x(19) x(11) x(12) x(13)]'; noxic1=norm(xic1);
xia1=[x(14) x(15) x(16) x(17) x(18)]'; noxia1=norm(xia1);

xih2=[x(19) x(20) x(21) x(22) x(23)]'; noxih2=norm(xih2);
xic2=[x(24) x(25) x(26) x(27) x(28)]'; noxic2=norm(xic2);
xia2=[x(29) x(30) x(31) x(32) x(33)]'; noxia2=norm(xia2);

xih3=[x(34) x(35) x(36) x(37) x(38)]'; noxih3=norm(xih3);
xic3=[x(39) x(40) x(41) x(42) x(43)]'; noxic3=norm(xic3);
xia3=[x(44) x(45) x(46) x(47) x(48)]'; noxia3=norm(xia3);

% global barx_1 barx_2  
global barx1 barx2 barx3 w1

sigma1=50;sigma2=50;sigma3=50;
zetab1=3;zetab2=3;zetab3=3;
varthetac1=10;varthetac2=8;varthetac3=9;
varthetaa1=15;varthetaa2=12;varthetaa3=14;
L1=0.8;L2=0.8;L3=0.8;
vartheta1=10;vartheta2=7;vartheta3=10;
eta1=0.02;eta2=0.02;eta3=0.02;

%%%%%%%%%%%%%%%Membership Function%%%%%%%%%%%%%%%%%
 
phiJ1(1)=exp(-(x1+2)^2);
phiJ1(2)=exp(-(x1+1)^2);
phiJ1(3)=exp(-(x1)^2);
phiJ1(4)=exp(-(x1-1)^2);
phiJ1(5)=exp(-(x1-2)^2);

barphiJ1(1)=exp(-(barx1+2)^2);
barphiJ1(2)=exp(-(barx1+1)^2);
barphiJ1(3)=exp(-(barx1)^2);
barphiJ1(4)=exp(-(barx1-1)^2);
barphiJ1(5)=exp(-(barx1-2)^2);

phiJ2(1)=exp(-(x1+2)^2)*exp(-(x2+2)^2)*exp(-(norm(xia1)+2)^2);
phiJ2(2)=exp(-(x1+1)^2)*exp(-(x2+1)^2)*exp(-(norm(xia1)+1)^2);
phiJ2(3)=exp(-(x1)^2)*exp(-(x2)^2)*exp(-(norm(xia1)+0)^2);
phiJ2(4)=exp(-(x1-1)^2)*exp(-(x2-1)^2)*exp(-(norm(xia1)-1)^2);
phiJ2(5)=exp(-(x1-2)^2)*exp(-(x2-2)^2)*exp(-(norm(xia1)-2)^2);

barphiJ2(1)=exp(-(barx1+2)^2)*exp(-(barx2+2)^2)*exp(-(norm(xia1)+2)^2);
barphiJ2(2)=exp(-(barx1+1)^2)*exp(-(barx2+1)^2)*exp(-(norm(xia1)+1)^2);
barphiJ2(3)=exp(-(barx1)^2)*exp(-(barx2)^2)*exp(-(norm(xia1)+0)^2);
barphiJ2(4)=exp(-(barx1-1)^2)*exp(-(barx2-1)^2)*exp(-(norm(xia1)-1)^2);
barphiJ2(5)=exp(-(barx1-2)^2)*exp(-(barx2-2)^2)*exp(-(norm(xia1)-2)^2);

phiJ3(1)=exp(-(x1+2)^2)*exp(-(x2+2)^2)*exp(-(x3+2)^2)*exp(-(norm(xia1)+2)^2)*exp(-(norm(xia2)+2)^2);
phiJ3(2)=exp(-(x1+1)^2)*exp(-(x2+1)^2)*exp(-(x3+1)^2)*exp(-(norm(xia1)+1)^2)*exp(-(norm(xia2)+1)^2);
phiJ3(3)=exp(-(x1+0)^2)*exp(-(x2+0)^2)*exp(-(x3+0)^2)*exp(-(norm(xia1)+0)^2)*exp(-(norm(xia2)+0)^2);
phiJ3(4)=exp(-(x1-1)^2)*exp(-(x2-1)^2)*exp(-(x3-1)^2)*exp(-(norm(xia1)-1)^2)*exp(-(norm(xia2)-1)^2);
phiJ3(5)=exp(-(x1-2)^2)*exp(-(x2-2)^2)*exp(-(x3-2)^2)*exp(-(norm(xia1)-2)^2)*exp(-(norm(xia2)-2)^2);

barphiJ3(1)=exp(-(barx1+2)^2)*exp(-(barx2+2)^2)*exp(-(barx3+2)^2)*exp(-(norm(xia1)+2)^2)*exp(-(norm(xia2)+2)^2);
barphiJ3(2)=exp(-(barx1+1)^2)*exp(-(barx2+1)^2)*exp(-(barx3+1)^2)*exp(-(norm(xia1)+1)^2)*exp(-(norm(xia2)+1)^2);
barphiJ3(3)=exp(-(barx1)^2)*exp(-(barx2)^2)*exp(-(barx3)^2)*exp(-(norm(xia1)+0)^2)*exp(-(norm(xia2)+0)^2);
barphiJ3(4)=exp(-(barx1-1)^2)*exp(-(barx2-1)^2)*exp(-(barx3-1)^2)*exp(-(norm(xia1)-1)^2)*exp(-(norm(xia2)-1)^2);
barphiJ3(5)=exp(-(barx1-2)^2)*exp(-(barx2-2)^2)*exp(-(barx3-2)^2)*exp(-(norm(xia1)-2)^2)*exp(-(norm(xia2)-2)^2);


phih1(1)=exp(-(x1+2)^2);
phih1(2)=exp(-(x1+1)^2);
phih1(3)=exp(-(x1)^2);
phih1(4)=exp(-(x1-1)^2);
phih1(5)=exp(-(x1-2)^2);

barphih1(1)=exp(-(barx1+2)^2);
barphih1(2)=exp(-(barx1+1)^2);
barphih1(3)=exp(-(barx1)^2);
barphih1(4)=exp(-(barx1-1)^2);
barphih1(5)=exp(-(barx1-2)^2);

phih2(1)=exp(-(x1+2)^2)*exp(-(x2+2)^2)*exp(-(norm(xia1)+2)^2);
phih2(2)=exp(-(x1+1)^2)*exp(-(x2+1)^2)*exp(-(norm(xia1)+1)^2);
phih2(3)=exp(-(x1)^2)*exp(-(x2)^2)*exp(-(norm(xia1)+0)^2);
phih2(4)=exp(-(x1-1)^2)*exp(-(x2-1)^2)*exp(-(norm(xia1)-1)^2);
phih2(5)=exp(-(x1-2)^2)*exp(-(x2-2)^2)*exp(-(norm(xia1)-2)^2);

barphih2(1)=exp(-(barx1+2)^2)*exp(-(barx2+2)^2)*exp(-(norm(xia1)+2)^2);
barphih2(2)=exp(-(barx1+1)^2)*exp(-(barx2+1)^2)*exp(-(norm(xia1)+1)^2);
barphih2(3)=exp(-(barx1)^2)*exp(-(barx2)^2)*exp(-(norm(xia1)+0)^2);
barphih2(4)=exp(-(barx1-1)^2)*exp(-(barx2-1)^2)*exp(-(norm(xia1)-1)^2);
barphih2(5)=exp(-(barx1-2)^2)*exp(-(barx2-2)^2)*exp(-(norm(xia1)-2)^2);

phih3(1)=exp(-(x1+2)^2)*exp(-(x2+2)^2)*exp(-(x3+2)^2)*exp(-(norm(xia1)+2)^2)*exp(-(norm(xia2)+2)^2);
phih3(2)=exp(-(x1+1)^2)*exp(-(x2+1)^2)*exp(-(x3+1)^2)*exp(-(norm(xia1)+1)^2)*exp(-(norm(xia2)+1)^2);
phih3(3)=exp(-(x1+0)^2)*exp(-(x2+0)^2)*exp(-(x3+0)^2)*exp(-(norm(xia1)+0)^2)*exp(-(norm(xia2)+0)^2);
phih3(4)=exp(-(x1-1)^2)*exp(-(x2-1)^2)*exp(-(x3-1)^2)*exp(-(norm(xia1)-1)^2)*exp(-(norm(xia2)-1)^2);
phih3(5)=exp(-(x1-2)^2)*exp(-(x2-2)^2)*exp(-(x3-2)^2)*exp(-(norm(xia1)-2)^2)*exp(-(norm(xia2)-2)^2);

barphih3(1)=exp(-(barx1+2)^2)*exp(-(barx2+2)^2)*exp(-(barx3+2)^2)*exp(-(norm(xia1)+2)^2)*exp(-(norm(xia2)+2)^2);
barphih3(2)=exp(-(barx1+1)^2)*exp(-(barx2+1)^2)*exp(-(barx3+1)^2)*exp(-(norm(xia1)+1)^2)*exp(-(norm(xia2)+1)^2);
barphih3(3)=exp(-(barx1)^2)*exp(-(barx2)^2)*exp(-(barx3)^2)*exp(-(norm(xia1)+0)^2)*exp(-(norm(xia2)+0)^2);
barphih3(4)=exp(-(barx1-1)^2)*exp(-(barx2-1)^2)*exp(-(barx3-1)^2)*exp(-(norm(xia1)-1)^2)*exp(-(norm(xia2)-1)^2);
barphih3(5)=exp(-(barx1-2)^2)*exp(-(barx2-2)^2)*exp(-(barx3-2)^2)*exp(-(norm(xia1)-2)^2)*exp(-(norm(xia2)-2)^2);

%%%%%%%%%%%%%%%Membership Function%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%Event-Triggering%%%%%%%%%%%%%%%%%%%


E1=eta1/(vartheta1+L1*norm(xih1)+0.5*L1*norm(xia1));
E2=eta2/(vartheta2+L2*norm(xih2)+0.5*L2*norm(xia2));
E3=eta3/(vartheta3+L3*norm(xih3)+0.5*L3*norm(xia3));

if abs(barx1-x1)>=E1 || ((barx1-x1)^2+(barx2-x2)^2)^0.5>=E2 ||((barx1-x1)^2+(barx2-x2)^2+(barx3-x3)^2)^0.5>=E3
    barx1=x1;
    barx2=x2;
    barx3=x3;
end

%%%%%%%%%%%%%%%%%%%Event-Triggering%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%Control Law%%%%%%%%%%%%%%%%%
ym=0.8*sin(0.8*t);

z1=x1-ym;
alpha1=-vartheta1*z1-xih1'*phih1'-0.5*xia1'*phiJ1';
c1=alpha1^2+log(zetab1^2/(zetab1^2-z1^2));
barz1=barx1-ym;
baralpha1=-vartheta1*barz1-xih1'*barphih1'-0.5*xia1'*barphiJ1';
z2=x2-alpha1;
alpha2=-vartheta2*z2-xih2'*phih2'-0.5*xia2'*phiJ2';
c2=alpha2^2+log(zetab2^2/(zetab2^2-z2^2));
barz2=barx2-baralpha1;
baralpha2=-vartheta2*barz2-xih2'*barphih2'-0.5*xia2'*barphiJ2';
z3=x3-alpha2;
barz3=barx3-baralpha2;
u=-vartheta3*barz3-xih3'*barphih3'-0.5*xia3'*barphiJ3';
c3=u^2+log(zetab3^2/(zetab3^2-z3^2));
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%Stochastic System%%%%%%%%%%%%%%%%%%%%%%%%%%%%


x1dot=x2;
x2dot=x3-x2-10*sin(x1)+cos(x2);
x3dot=w1*4-(0.9/0.25)*x2-2*x3+2*sin(x1);
%%%%%%%%%%%%%%%%%%%%%%%%%Adaptive Laws%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xih1dot=(phih1'*z1)/(zetab1^2-z1^2)-sigma1*xih1;
xic1dot=-varthetac1*(norm(phiJ1)^2)*xic1;
xia1dot=-(norm(phiJ1)^2)*(varthetaa1*(xia1-xic1)+varthetac1*xic1);

xih2dot=(phih2'*z2)/(zetab2^2-z2^2)-sigma2*xih2;
xic2dot=-varthetac2*(norm(phiJ2)^2)*xic2;
xia2dot=-(norm(phiJ2)^2)*(varthetaa2*(xia2-xic2)+varthetac2*xic2);

xih3dot=(phih3'*z3)/(zetab3^2-z3^2)-sigma3*xih3;
xic3dot=-varthetac3*(norm(phiJ3)^2)*xic3;
xia3dot=-(norm(phiJ3)^2)*(varthetaa3*(xia3-xic3)+varthetac3*xic3);
%%%%%%%%%%%%%%%%%%%%%%%%%Adaptive Laws%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tt=t
dx=[x1dot;x2dot;x3dot;xih1dot;xic1dot;xia1dot;xih2dot;xic2dot;xia2dot;xih3dot;xic3dot;xia3dot;];