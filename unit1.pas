unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

type TCsotany=class(TShape)
  public
  energia:integer;
  bal,jobb:integer;
  irany:integer;
  sug:integer;
  szoveg:TLabel;
  generacio:integer; //hanyadik generáció
end;

type TSundiszno=class(TShape)
  public
  energia:integer;
  bal,jobb:integer;
  irany:integer;
  sug:integer;
  szoveg:TLabel;
  generacio:integer; //hanyadik generáció
end;

var lista:TList;
    sunLista:TList;


    //PÁLYABEFOLYÁSOLÓ VÁLTOZÓK
    tapmennyiseg:integer;
    hresz:integer;

    //CSÓTÁNYOK VÁLTOZÓI
    sugar:integer;
    maxenergia:integer;
    tapenergia:integer;
    mutaciorate:integer; //0-100
    toorsize:integer; //optionally 10
    uniformrate:integer; //0-100

    //SÜNÖK VÁLTOZÓI
    ssugar:integer;
    sunmaxe:integer;
    suntape:integer;
    sunmutaciorate:integer; //0-100
    suntoorsize:integer; //optionally 10
    sununiformrate:integer; //0-100

    toggle:boolean;
    stat:boolean;
    szap,sszap:boolean;
    pX:integer;
    pY:integer;
    randomizalo:integer;

{$R *.lfm}

{ TForm1 }

procedure csInici; //CSÓTÁNY
var i:integer;
    csUj:TCsotany;
begin
  lista.Clear;
  for i:=0 to toorsize*2-1 do begin
    //csUj=utód
    csUj:=TCsotany.Create(Form1);
    //szoveg
    csUj.szoveg:=TLabel.Create(csUj);
    csUj.szoveg.Parent:=Form1;
    csUj.szoveg.Visible:=false;
    csUj.szoveg.Font.Color:=63+257*204+65536*255;
    csUj.szoveg.font.Size:=12;
    csUj.szoveg.Font.Style:=[fsBold];

    csUj.sug:=sugar;
    csUj.generacio:=1;
    csUj.Width:=csUj.sug*2;
    csUj.Height:=csUj.sug*2;
    csUj.Parent:=Form1;
    csUj.Shape:=stCircle;
    csUj.Brush.Color:=clWhite;
    csUj.Left:=abs(random(Form1.Image1.Width)-random(Form1.Image1.width))+randomizalo;
    csUj.Top:=abs(random(Form1.Image1.Height)-random(Form1.Image1.height))+randomizalo;
    csUj.energia:=maxenergia div 10;
    randomize;
    csUj.irany:=random(4);
    csUj.bal:=random(51);
    csUj.jobb:=random(51);
    lista.Add(csUj);
  end;
end;

procedure sunInici; //SÜN
var i:integer;
    csUj:TSundiszno;
begin
  sunLista.Clear;
  for i:=0 to suntoorsize*2-1 do begin
    //csUj=utód
    csUj:=TSundiszno.Create(Form1);
    //szoveg
    csUj.szoveg:=TLabel.Create(csUj);
    csUj.szoveg.Parent:=Form1;
    csUj.szoveg.Visible:=false;
    csUj.szoveg.Font.Color:=63+257*204+65536*255;
    csUj.szoveg.font.Size:=12;
    csUj.szoveg.Font.Style:=[fsBold];

    csUj.sug:=ssugar;
    csUj.generacio:=1;
    csUj.Width:=csUj.sug*2;
    csUj.Height:=csUj.sug*2;
    csUj.Parent:=Form1;
    csUj.Shape:=stCircle;
    csUj.Brush.Color:=clWhite;
    csUj.Left:=random(Form1.Image1.Width);
    csUj.Top:=random(Form1.Image1.Height);
    csUj.energia:=sunmaxe div 10;
    randomize;
    csUj.irany:=random(4);
    csUj.bal:=random(51);
    csUj.jobb:=random(51);
    sunLista.Add(csUj);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i,j:integer;
begin
 {Image1.Top:=0;
  Image1.Left:=0;
  Image1.Width:=Width;
  Image1.Height:=Height;  }
  Image1.Canvas.Brush.Color:=clBlack;
  Image1.Canvas.Clear;
  lista:=TList.Create();
  sunLista:=TList.Create();
  Image1.Canvas.Brush.Color:=clWhite;
  //width,height
  hresz:=15;
  tapmennyiseg:=25;

  //Csótányok inici
  randomize;
  sugar:=4;
  maxenergia:=1000;
  tapenergia:=8;
  mutaciorate:=3;
  toorsize:=10;
  uniformrate:=50;

  //Sünök inici
  ssugar:=6;
  sunmaxe:=1000;
  suntape:=40;
  sunmutaciorate:=3;
  suntoorsize:=10;
  sununiformrate:=50;

  toggle:=true;
  stat:=false;
  pX:=0;
  pY:=0;
  Edit1.Text:=inttostr(sugar);
  Edit2.text:=inttostr(maxenergia);
  Edit3.text:=inttostr(tapenergia);
  edit5.text:=inttostr(hresz);
  edit6.text:=inttostr(tapmennyiseg);
  Edit7.Text:=inttostr(mutaciorate);
  Edit8.Text:=inttostr(toorsize);
  Edit9.Text:=inttostr(uniformrate);
  Edit4.Text:=inttostr(ssugar);
  Edit10.Text:=inttostr(sunmaxe);
  Edit11.Text:=inttostr(suntape);
  Edit12.Text:=inttostr(sunmutaciorate);
  Edit13.Text:=inttostr(suntoorsize);
  Edit14.Text:=inttostr(sununiformrate);
  Button2.Caption:='Csótány';
  Button3.Caption:='Genetika OFF';
  Edit1.ShowHint:=true;
  Edit2.ShowHint:=true;
  Edit3.ShowHint:=true;
  Edit5.ShowHint:=true;
  Edit1.Hint:='sugar';
  Edit2.Hint:='maxenergia';
  Edit3.Hint:='tapenergia';
  Edit5.Hint:='hresz';
  for i:=0 to Image1.Width do
    for j:=0 to Image1.Height do begin
      if random(hresz)=0 then Image1.Canvas.Pixels[i,j]:=clWhite;
    end;
  for i:=0 to Image2.width do begin
    for j:=0 to Image2.height do
      Image2.Canvas.Pixels[i,j]:=clWhite;
  end;
  csInici;
  sunInici;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,j:integer;
    cso:TCsotany;
    so:TSundiszno;
begin
  Image1.Canvas.Brush.Color:=clBlack;
  Image1.Canvas.Clear;
  sugar:=strToInt(Edit1.Text);
  maxenergia:=strToInt(Edit2.Text);
  tapenergia:=strToInt(Edit3.Text);
  hresz:=strToInt(Edit5.Text);
  tapmennyiseg:=strToInt(Edit6.Text);
  mutaciorate:=strToInt(Edit7.Text);
  toorsize:=strToInt(Edit8.Text);
  uniformrate:=strToInt(Edit8.Text);
  ssugar:=strToInt(Edit4.Text);
  sunmaxe:=strToInt(Edit10.Text);
  suntape:=strToInt(Edit11.Text);
  sunmutaciorate:=strToInt(Edit12.Text);
  suntoorsize:=strToInt(Edit13.Text);
  sununiformrate:=strToInt(Edit14.Text);
  Image1.Canvas.Brush.Color:=clWhite;
  for i:=0 to Image1.Width do
    for j:=0 to Image1.Height do begin
      if random(hresz)=0 then Image1.Canvas.Pixels[i,j]:=clWhite;
    end;
  for i:=lista.Count-1 downto 0 do begin
    cso:=TCsotany(lista.Items[i]);
    cso.Destroy;
    lista.Remove(cso);
  end;
  for i:=sunLista.Count-1 downto 0 do begin
    so:=TSundiszno(sunLista.Items[i]);
    so.Destroy;
    sunLista.Remove(so);
  end;
  pX:=0;
  for i:=0 to Image2.Width do
    for j:=0 to Image2.Height do
      Image2.Canvas.Pixels[i,j]:=clWhite;
  csInici;
  sunInici;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  toggle:=not toggle;
  if toggle then Button2.Caption:='Csótány'
  else Button2.Caption:='Kaja';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  stat:=not stat;
  if stat then Button3.Caption:='Genetika ON'
  else Button3.Caption:='Genetika OFF';
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var cs:TCsotany;
begin
  if toggle then begin
   cs:=TCsotany.Create(Form1);
   cs.sug:=sugar;
   cs.generacio:=1;
   cs.Width:=cs.sug*2;
   cs.Height:=cs.sug*2;
   cs.Parent:=Form1;
   cs.Shape:=stCircle;
   cs.Brush.Color:=clWhite;
   cs.Left:=X-cs.sug;
   cs.Top:=Y-cs.sug;
   cs.energia:=maxenergia div 10;
   randomize;
   cs.bal:=random(51);
   cs.jobb:=random(51);
   randomize;
   cs.irany:=random(4);
   //szoveg
   cs.szoveg:=TLabel.Create(cs);
   cs.szoveg.Parent:=Form1;
   cs.szoveg.Visible:=false;
   cs.szoveg.Font.Color:=63+257*204+65536*255;
   cs.szoveg.Font.Style:=[fsBold];
   cs.szoveg.font.Size:=12;

   lista.Add(cs);
  end else begin
    Image1.Canvas.Brush.Color:=clWhite;
    Image1.Canvas.Pen.Color:=clNone;
    Image1.Canvas.Rectangle(X,Y,X+TrackBar1.Position*4,Y+TrackBar1.Position*4);
    Image1.Canvas.Brush.Color:=clBlack;
    Image1.Canvas.Pen.Color:=clBlack;
  end;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

procedure csMozgas(cs:TCsotany); //CSÓTÁNY
begin
   if cs.irany=0 then cs.top:=cs.top-1
   else if cs.irany=1 then cs.left:=cs.left+1
   else if cs.irany=2 then cs.top:=cs.top+1
   else cs.left:=cs.left-1;
   if cs.Top<0 then cs.Top:=0;
   if cs.Top>Form1.Image1.Height-cs.Height then cs.Top:=Form1.Image1.Height-cs.Height;
   if cs.Left<0 then cs.Left:=0;
   if cs.Left>Form1.Image1.Width-cs.Width then cs.Left:=Form1.Image1.Width-cs.Width;
end;

procedure sunMozgas(cs:TSundiszno); //SÜN
begin
   if cs.irany=0 then cs.top:=cs.top-1
   else if cs.irany=1 then cs.left:=cs.left+1
   else if cs.irany=2 then cs.top:=cs.top+1
   else cs.left:=cs.left-1;
   if cs.Top<0 then cs.Top:=0;
   if cs.Top>Form1.Image1.Height-cs.Height then cs.Top:=Form1.Image1.Height-cs.Height;
   if cs.Left<0 then cs.Left:=0;
   if cs.Left>Form1.Image1.Width-cs.Width then cs.Left:=Form1.Image1.Width-cs.Width;
end;

procedure szoras;
var i:integer;
begin
  for i:=1 to tapmennyiseg do
    Form1.Image1.Canvas.Pixels[random(Form1.Width),random(Form1.Height)]:=clWhite;
end;

procedure csForgas(cs:TCsotany); //CSÓTÁNY
var r:integer;
begin
  randomize;
  r:=random(100);
  if r<cs.bal then cs.irany:=(cs.irany+3) mod 4
  else if r<cs.bal+cs.jobb then cs.irany:=(cs.irany+1) mod 4;
end;

procedure sunForgas(cs:TSundiszno); //SÜN
var r:integer;
begin
  randomize;
  r:=random(100);
  if r<cs.bal then cs.irany:=(cs.irany+3) mod 4
  else if r<cs.bal+cs.jobb then cs.irany:=(cs.irany+1) mod 4;
end;

procedure csFogyasztas(cs:TCsotany); //CSÓTÁNY
begin
  cs.energia:=cs.energia-1;
  if cs.energia<0 then cs.energia:=0;
end;

procedure sunFogyasztas(cs:TSundiszno); //SÜN
begin
  cs.energia:=cs.energia-1;
  if cs.energia<0 then cs.energia:=0;
end;

procedure csEves(cs:TCsotany); //CSÓTÁNY
begin
  if Form1.Image1.Canvas.Pixels[cs.Left+cs.sug,cs.Top+cs.sug]=clWhite then begin
    cs.energia:=cs.energia+tapenergia;
    if cs.energia>maxenergia then cs.energia:=maxenergia;
    Form1.Image1.Canvas.Pixels[cs.Left+cs.sug,cs.Top+cs.sug]:=clBlack;
  end;
end;

procedure sunEves(cs:TSundiszno); //SÜN
var i:integer;
    cso:TCsotany;
    tav:double;
    x1,x2,y1,y2:integer;
begin
  x2:=cs.left+ssugar;
  y2:=cs.top+ssugar;
  for i:=lista.Count-1 downto 0 do begin
    cso:=TCsotany(lista.Items[i]);
    x1:=cso.left+sugar;
    y1:=cso.Top+sugar;
    tav:=sqrt(sqr(x1-x2)+sqr(y1-y2));
    if tav<=3 then begin
      lista.remove(cso);
      cso.destroy;
      cs.energia:=cs.energia+suntape;
    end;
  end;
end;

procedure csSzinezes(cs:TCsotany); //CSÓTÁNY
begin
  cs.Brush.Color:=round(cs.energia/maxenergia*255)+257*100+65536*255;
end;

procedure sunSzinezes(cs:TSundiszno); //SÜN
begin
  cs.Brush.Color:=round(cs.energia/maxenergia*255)+257*100;
end;

procedure csSzaporodas; //CSÓTÁNY
var csUj,csCurrent:TCsotany;
    maxFittness,i:integer;
    toor1,toor2:TList;
    selected1,selected2:TCsotany;
begin
   randomizalo:=random(75);
   //random egyedekből 2 csoport
   toor1:=TList.Create();
   toor2:=TList.Create();

   //2 csoport feltöltése
   randomize;
   for i:=0 to toorsize-1 do begin
     toor1.Add(lista.Items[random(lista.Count)]);
     toor2.Add(lista.Items[random(lista.Count)]);
   end;

   //2 legjobb kiválasztása : selected1,selected2
   maxFittness:=-1;
   for i:=0 to toorsize-1 do begin
     csCurrent:=TCsotany(toor1.Items[i]);
     if csCurrent.energia>maxFittness then begin
       maxFittness:=csCurrent.energia;
       selected1:=csCurrent;
     end;
   end;
   maxFittness:=-1;
   for i:=0 to toorsize-1 do begin
     csCurrent:=TCsotany(toor2.Items[i]);
     if csCurrent.energia>maxFittness then begin
       maxFittness:=csCurrent.energia;
       selected2:=csCurrent;
     end;
   end;

   //csUj=utód
   csUj:=TCsotany.Create(Form1);
   //szoveg
   csUj.szoveg:=TLabel.Create(csUj);
   csUj.szoveg.Parent:=Form1;
   csUj.szoveg.Visible:=false;
   csUj.szoveg.Font.Color:=63+257*204+65536*255;
   csUj.szoveg.font.Size:=12;
   csUj.szoveg.Font.Style:=[fsBold];

   csUj.sug:=sugar;
   if random(100)<=uniformrate then
     csUj.generacio:=selected1.generacio+1
   else
     csUj.generacio:=selected2.generacio+1;
   csUj.Width:=csUj.sug*2;
   csUj.Height:=csUj.sug*2;
   csUj.Parent:=Form1;
   csUj.Shape:=stCircle;
   csUj.Brush.Color:=clWhite;
   randomize;
   csUj.Left:=abs(random(Form1.Image1.Width)-(random(Form1.Image1.width)))+randomizalo;
   csUj.Top:=abs(random(Form1.Image1.Height)-(random(Form1.Image1.height)))+randomizalo;
   csUj.energia:=maxenergia div 10;
   randomize;
   csUj.irany:=random(4);

   //crossover
   if random(100)<=uniformrate then begin
     csUj.bal:=selected1.bal;
   end else begin
     csUj.bal:=selected2.bal;
   end;
   if random(100)<=uniformrate then begin
     csUj.jobb:=selected1.jobb;
   end else begin
     csUj.jobb:=selected2.jobb;
   end;

   //mutáció
   if random(100)<=mutaciorate then begin
     csUj.bal:=random(51);
     csUj.jobb:=random(51);
   end;

   lista.Add(csUj);
end;

procedure sunSzaporodas; //SÜN
var csUj,csCurrent:TSundiszno;
    maxFittness,i:integer;
    toor1,toor2:TList;
    selected1,selected2:TSundiszno;
begin
   //random egyedekből 2 csoport
   toor1:=TList.Create();
   toor2:=TList.Create();

   //2 csoport feltöltése
   randomize;
   for i:=0 to suntoorsize-1 do begin
     toor1.Add(sunLista.Items[random(sunLista.Count)]);
     toor2.Add(sunLista.Items[random(sunLista.Count)]);
   end;

   //2 legjobb kiválasztása : selected1,selected2
   maxFittness:=-1;
   for i:=0 to suntoorsize-1 do begin
     csCurrent:=TSundiszno(toor1.Items[i]);
     if csCurrent.energia>maxFittness then begin
       maxFittness:=csCurrent.energia;
       selected1:=csCurrent;
     end;
   end;
   maxFittness:=-1;
   for i:=0 to suntoorsize-1 do begin
     csCurrent:=TSundiszno(toor2.Items[i]);
     if csCurrent.energia>maxFittness then begin
       maxFittness:=csCurrent.energia;
       selected2:=csCurrent;
     end;
   end;

   //csUj=utód
   csUj:=TSundiszno.Create(Form1);
   //szoveg
   csUj.szoveg:=TLabel.Create(csUj);
   csUj.szoveg.Parent:=Form1;
   csUj.szoveg.Visible:=false;
   csUj.szoveg.Font.Color:=63+257*204+65536*255;
   csUj.szoveg.font.Size:=12;
   csUj.szoveg.Font.Style:=[fsBold];

   csUj.sug:=ssugar;
   if random(100)<=sununiformrate then
     csUj.generacio:=selected1.generacio+1
   else
     csUj.generacio:=selected2.generacio+1;
   csUj.Width:=csUj.sug*2;
   csUj.Height:=csUj.sug*2;
   csUj.Parent:=Form1;
   csUj.Shape:=stCircle;
   csUj.Brush.Color:=clWhite;
   randomize;
   csUj.Left:=random(Form1.Image1.Width);
   csUj.Top:=random(Form1.Image1.Height);
   csUj.energia:=sunmaxe div 10;
   randomize;
   csUj.irany:=random(4);

   //crossover
   if random(100)<=sununiformrate then begin
     csUj.bal:=selected1.bal;
   end else begin
     csUj.bal:=selected2.bal;
   end;
   if random(100)<=sununiformrate then begin
     csUj.jobb:=selected1.jobb;
   end else begin
     csUj.jobb:=selected2.jobb;
   end;

   //mutáció
   if random(100)<=sunmutaciorate then begin
     csUj.bal:=random(51);
     csUj.jobb:=random(51);
   end;

   sunLista.Add(csUj);
end;

procedure csSzovegMozg(cs:TCsotany); //CSÓTÁNY
begin
  if stat then begin
     cs.szoveg.Caption:=intToStr(cs.bal)+'+'+intToStr(cs.jobb);
     cs.szoveg.Visible:=true;
     cs.szoveg.Top:=cs.Top-cs.szoveg.Height;
     cs.szoveg.Left:=cs.Left-cs.szoveg.width div 2+sugar;
   end else begin
     cs.szoveg.Visible:=false;
   end;
end;

procedure sunSzovegMozg(cs:TSundiszno); //SÜN
begin
  if stat then begin
     cs.szoveg.Caption:=intToStr(cs.bal)+'+'+intToStr(cs.jobb);
     cs.szoveg.Visible:=true;
     cs.szoveg.Top:=cs.Top-cs.szoveg.Height;
     cs.szoveg.Left:=cs.Left-cs.szoveg.width div 2+ssugar;
   end else begin
     cs.szoveg.Visible:=false;
   end;
end;

procedure csHalal(cs:TCsotany); //CSÓTÁNY
begin
  if cs.energia<=0 then begin
     cs.destroy;
     lista.Remove(cs);
   end;
end;

procedure sunHalal(cs:TSundiszno); //SÜN
begin
  if cs.energia<=0 then begin
     cs.destroy;
     sunLista.Remove(cs);
   end;
end;

procedure szovegFriss;
var csmax,smax,csmin,smin,i:integer;
    cs2:TCsotany;
    so:TSundiszno;
begin
  csmax:=0;
  for i:=0 to lista.Count-1 do begin
    cs2:=TCsotany(lista.Items[i]);
    if cs2.generacio>csmax then csmax:=cs2.generacio;
  end;
  csmin:=20000000;
  for i:=0 to lista.Count-1 do begin
    cs2:=TCsotany(lista.Items[i]);
    if cs2.generacio<csmin then csmin:=cs2.generacio;
  end;
  smax:=0;
  for i:=0 to sunLista.Count-1 do begin
    so:=TSundiszno(sunLista.Items[i]);
    if so.generacio>smax then smax:=so.generacio;
  end;
  smin:=20000000;
  for i:=0 to sunLista.Count-1 do begin
    so:=TSundiszno(sunLista.Items[i]);
    if so.generacio<smin then smin:=so.generacio;
  end;
  if smin=20000000 then smin:=0;
  if csmin=20000000 then csmin:=0;
  Form1.Label1.Caption:=inttostr(lista.Count);
  Form1.Label4.Caption:=inttostr(sunLista.Count);
  Form1.Label5.Caption:='min gen: '+inttostr(smin);
  Form1.Label6.Caption:='max gen: '+inttostr(smax);
  Form1.Label2.Caption:='min gen: '+inttostr(csmin);
  Form1.Label3.Caption:='max gen: '+inttostr(csmax);
end;

procedure grafikonFriss;
var i:integer;
begin
  if pX<Form1.Image2.Width then pX:=pX+1
  else pX:=0;
  pY:=(Form1.Image2.height-1)-(lista.count div 3);
  if pY<0 then pY:=0;
  for i:=0 to Form1.Image2.height do begin
    Form1.Image2.Canvas.Pixels[pX,i]:=clWhite;
    Form1.Image2.Canvas.Pixels[pX+1,i]:=clWhite;
    Form1.Image2.Canvas.Pixels[pX+2,i]:=clWhite;
    Form1.Image2.Canvas.Pixels[pX+3,i]:=clWhite;
  end;
  Form1.Image2.Canvas.Pixels[pX,pY]:=clRed;

  pY:=(Form1.Image2.height-1)-(sunLista.count div 3);
  if pY<0 then pY:=0;
  Form1.Image2.Canvas.Pixels[pX,pY]:=clGreen;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var cs:TCsotany;
    s:TSundiszno;
    i:integer;
begin
  //tápszórás
  szoras;
  if (lista.Count>=1) and (sszap) then
    csSzaporodas;
  sszap:=not sszap;
  if (sunLista.Count>=1) and (szap) then
    sunSzaporodas;
  szap:=not szap;


  //CSÓTÁNYOK VEZÉRLÉSE
  for i:=lista.count-1 downto 0 do begin
    cs:=TCsotany(lista.Items[i]);
    csMozgas(cs);
    csForgas(cs);
    csFogyasztas(cs);
    csEves(cs);
    csSzinezes(cs);  //színezés -- rózsaszín=maxenergia -- kék=kevés energia
    csSzovegMozg(cs);
    csHalal(cs);
  end;

  //SÜNÖK VEZÉRLÉSE
  for i:=sunLista.count-1 downto 0 do begin
    s:=TSundiszno(sunLista.Items[i]);
    sunMozgas(s);
    sunForgas(s);
    sunFogyasztas(s);
    sunEves(s);
    sunSzinezes(s);  //színezés -- piros-narancs=maxenergia -- zöld=kevés energia
    sunSzovegMozg(s);
    sunHalal(s);
  end;


  szovegFriss;
  grafikonFriss;
end;

end.

