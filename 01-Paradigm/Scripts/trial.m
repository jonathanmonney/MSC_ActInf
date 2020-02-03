% Does alpha window work [shows that yes, it does]
config_display (0)

start_cogent;

cgloadlib
cgopen(1000,1000,0,0,0)

cgloadbmp(1,'Ancoeus.bmp',1000,1000)
cgloadbmp(2,'ahole.bmp')
cgtrncol(2,'n')
cgdrawsprite(1,0,0)
cgdrawsprite(2,0,0)
cgflip;
wait (5000);


stop_cogent;