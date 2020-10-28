program timer;

uses dos {gettime}, crt {color}, keyboard {readkey};

//Sise of the cube
procedure sise (var n:integer);

begin;
repeat
begin
write ('Sise (2,3,4) : ');
read (n);
writeln (' ');
end
until ((n>1) and (n<5));
end;

//Research of a combination
procedure combinaison (n:integer);

type possibilite = (U,D,R,L,F,B,Up,Dp,Rp,Lp,Fp,Bp,U2,D2,R2,L2,F2,B2);

const max=40;
var i,a1,a2,a3,rst,m1,m2:integer;
var pos : array [1..max] of possibilite;
var comb : array [1..max] of possibilite; 

begin;
pos [1]:=U;
pos [2]:=D;
pos [3]:=R;
pos [4]:=L;
pos [5]:=F;
pos [6]:=B;
pos [7]:=Up;
pos [8]:=Dp;
pos [9]:=Rp;
pos [10]:=Lp;
pos [11]:=Fp;
pos [12]:=Bp;
pos [13]:=U2;
pos [14]:=D2;
pos [15]:=R2;
pos [16]:=L2;
pos [17]:=F2;
pos [18]:=B2;
pos [19]:=u;
pos [20]:=d;
pos [21]:=r;
pos [22]:=l;
pos [23]:=f;
pos [24]:=b;
pos [25]:=up;
pos [26]:=dp;
pos [27]:=rp;
pos [28]:=lp;
pos [29]:=fp;
pos [30]:=bp; 
pos [31]:=u2;
pos [32]:=d2;
pos [33]:=r2;
pos [34]:=l2;
pos [35]:=f2;
pos [36]:=b2;

a2:=0;
a3:=0;

randomize;

if n=2 then 
begin;
m1:=9;
m2:=17;
end;

if n=3 then 
begin;
m1:=20;
m2:=17;
end;

if n=4 then 
begin;
m1:=40;
m2:=35;
end;

write ('Scramble : ');
for i:=1 to m1 do
	begin
	repeat 
	begin
	a1:=random(m2)+1;
	rst:=a1 mod 2;
	if rst=0 then repeat a1:=random(m2)+1;
		until (((a1<>a3-2*6) and (a1<>a3-6) and (a1<>a3) and (a1<>a3+6) and (a1<>a3+2*6))
		and ((a1<>a2-1-2*6) and (a1<>a2-1-6) and (a1<>a2-1) and (a1<>a2-1+6) and (a1<>a2-1+2*6)))
		else repeat a1:=random(m2)+1;
			until (((a1<>a3-2*6) and (a1<>a3-6) and (a1<>a3) and (a1<>a3+6) and (a1<>a3+2*6))
			and ((a1<>a2+1-2*6) and (a1<>a2+1-6) and (a1<>a2+1) and (a1<>a2+1+6) and (a1<>a2+1+2*6)));
	end;
	until ((a1<>a2-2*6) and (a1<>a2-6) and (a1<>a2) and (a1<>a2+6) and (a1<>a2+2*6));
	a3:=a2;
	a2:=a1;
	comb [i]:= pos [a1];
	if i=m1 then
	writeln (comb [i],' ')
	else write (comb [i],' ');
	end;
writeln (' ');
end;

//Stopwatch
procedure chronometre(var t:longint);

var t1,t2,min,sec:integer;
var cent:longint;
var h,m,s,c:word;
var ch:char;

begin
write ('START (space bar) ');
repeat
ch:=readkey;
if ch=' ' then
begin
gettime (h,m,s,c);
t1:=(h*36000+m*6000+s*100+c);
end;
until ch=' ';

write ('/ STOP (space bar) ');
repeat
ch:=readkey;
if ch=' ' then
begin
gettime (h,m,s,c);
t2:=(h*36000+m*6000+s*100+c);
end;
until ch=' ';

t:=t2-t1;
sec:=(t div 100);
cent:=(t-100*sec);

if sec>=60 then
begin
min:=sec div 60;
sec:=sec-60*min;
textcolor (green);
writeln (min,':',sec,'.',cent,' min');
textcolor (white);
end
else
begin
textcolor (green);
writeln (sec,'.',cent,' sec');
textcolor (white);
end;
end;

//Main program

const max=100;
var n,i,j,mmin,msec,bmin,bsec:integer;
var t,tt,mcent,m,bcent:longint;
var tab : array[1..100] of longint;

BEGIN;
i:=2;
j:=1;

writeln  ('space bar x2 to exit');
writeln (' ');
sise (n);
combinaison (n);
chronometre (t);
tab [1]:=t;
tt:=t;
writeln (' ');

repeat
begin
combinaison (n);
chronometre (t);
if tab [i-1]>t then
begin
j:=i;
repeat
tab [j]:=tab [j-1];
tab [j-1]:=t;
j:=j-1;
until ((j=1) or (tab [j-1]<t))
end
else tab [i]:=t;
bsec:=tab [1] div 100;
bcent:=tab [1]-100*bsec;
tt:=tt+t;
m:=tt div i;
msec:=m div 100;
mcent:=m-100*msec;

if msec>=60 then
begin
mmin:=msec div 60;
msec:=msec-60*mmin;
writeln ('Average of ',i,' : ',mmin,':',msec,'.',mcent,' min');
end
else writeln ('Average of ',i,' : ',msec,'.',mcent,' sec');

if bsec>=60 then
begin
bmin:=bsec div 60;
bsec:=bsec-60*mmin;
writeln ('Best : ',bmin,':',bsec,'.',bcent,' min');
end
else writeln ('Best : ',bsec,'.',bcent,' sec');
writeln (' ');
i:=i+1;
end;
until t<50
END.
