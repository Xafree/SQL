--tp1
SELECT *
FROM thierry_millan.CELCAT2017;

SELECT MATC , count(distinct SALC)
FROM thierry_millan.CELCAT2017 t
WHERE MATC  is not null
    --AND HEUREFC is not null
    GROUP BY t.MATC
having count(distinct SALC)>1;

-- crée la table MAT
create table MAT( 
    MATC varchar2(10) PRIMARY key not null , 
    INTC VARCHAR2(70)
);

desc thierry_millan.CELCAT2017; -- pour voir les type de chaque colones

insert into MAT(MATC,INTC)
select DISTINCT MATC, INTC
from thierry_millan.CELCAT2017
where MATC is not null;

--Tp2
create table GROUPE(GRPC varchar2(20),ANNEEC char(3));
create table CRENEAU(DEBSEMC date,JOURC char(8),HEUREDC char(5),TYPEC varchar2(20), HEUREFC char(5),GRPC varchar(20), MATC varchar2(10));
create table ENSEIGNER(DEBSEMC date,JOURC char(8),HEUREDC char(5),GRPC varchar(20),ENSC char(3));
create table AFFECTER(DEBSEMC date,JOURC char(8),HEUREDC char(5),GRPC varchar(20),SALC char(15));

alter table GROUPE add constraint PK_GROUPE primary key (GRPC);
alter table CRENEAU add constraint PK_CRENEAU primary key(DEBSEMC,JOURC,HEUREDC,GRPC);
alter table ENSEIGNER add constraint PK_ENSEIGNER primary key(DEBSEMC,JOURC,HEUREDC,GRPC,ENSC);
alter table AFFECTER add constraint PK_AFFECTER primary key(DEBSEMC,JOURC,HEUREDC,GRPC,SALC);

alter table GROUPE add constraint PK_GROUPE primary key (GRPC);
alter table CRENEAU add constraint PK_CRENEAU primary key(DEBSEMC,JOURC,HEUREDC,GRPC);
alter table ENSEIGNER add constraint PK_ENSEIGNER primary key(DEBSEMC,JOURC,HEUREDC,GRPC,ENSC);
alter table AFFECTER add constraint PK_AFFECTER primary key(DEBSEMC,JOURC,HEUREDC,GRPC,SALC);

ALTER TABLE CRENEAU add constraint PK_CRENEAU_MATC foreign key (MATC) references MAT(MATC);
ALTER TABLE CRENEAU add constraint PK_CRENEAU_GRPC foreign key (GRPC) references GROUPE(GRPC);
ALTER TABLE AFFECTER add constraint PK_AFFECTER_GRPC foreign key (GRPC) references GROUPE(GRPC);
ALTER TABLE ENSEIGNER add constraint PK_ENSEIGNER_GRPC foreign key (GRPC) references GROUPE(GRPC);

insert into GROUPE(GRPC,ANNEEC)
select DISTINCT GRPC, ANNEEC
from thierry_millan.CELCAT2017
where GRPC is not null;

insert into CRENEAU(DEBSEMC,JOURC,HEUREDC,TYPEC,HEUREFC,GRPC,MATC)
select DISTINCT DEBSEMC,JOURC,HEUREDC,TYPEC,HEUREFC,GRPC,MATC
from thierry_millan.CELCAT2017;

insert into ENSEIGNER(DEBSEMC,JOURC,HEUREDC,GRPC, ENSC)
select DISTINCT DEBSEMC,JOURC,HEUREDC,GRPC, ENSC
from thierry_millan.CELCAT2017
where ENSC is not null;

insert into AFFECTER(DEBSEMC,JOURC,HEUREDC,GRPC, SALC)
select DISTINCT DEBSEMC,JOURC,HEUREDC,GRPC, SALC
from thierry_millan.CELCAT2017
where SALC is not null;

select CRENEAU.DEBSEMC, CRENEAU.JOURC, CRENEAU.HEUREDC, TYPEC, HEUREFC, CRENEAU.GRPC, CRENEAU.MATC, SALC,ENSC,ANNEEC, INTC
from CRENEAU, MAT, GROUPE, ENSEIGNER, AFFECTER
where CRENEAU.GRPC = GROUPE.GRPC
and MAT.MATC(+)         = CRENEAU.MATC
and AFFECTER.DEBSEMC(+) = creneau.debsemc
and AFFECTER.JOURC(+)   = CRENEAU.JOURC
and AFFECTER.HEUREDC(+) = CRENEAU.HEUREDC
and AFFECTER.GRPC(+)    = CRENEAU.GRPC
and ENSEIGNER.DEBSEMC(+)= CRENEAU.DEBSEMC
and ENSEIGNER.JOURC(+)  = CRENEAU.JOURC
and ENSEIGNER.HEUREDC(+)= CRENEAU.HEUREDC
and ENSEIGNER.GRPC(+)   = CRENEAU.GRPC
minus 
select DEBSEMC, JOURC, HEUREDC, TYPEC, HEUREFC, GRPC,MATC, SALC,ENSC, ANNEEC, INTC
from thierry_millan.CELCAT2017;

select DEBSEMC, JOURC, HEUREDC, TYPEC, HEUREFC, GRPC,MATC, SALC,ENSC, ANNEEC, INTC
from thierry_millan.CELCAT2017
minus
select CRENEAU.DEBSEMC, CRENEAU.JOURC, CRENEAU.HEUREDC, TYPEC, HEUREFC, CRENEAU.GRPC, CRENEAU.MATC, SALC,ENSC,ANNEEC, INTC
from CRENEAU, MAT, GROUPE, ENSEIGNER, AFFECTER
where CRENEAU.GRPC = GROUPE.GRPC
and MAT.MATC(+)         = CRENEAU.MATC
and AFFECTER.DEBSEMC(+) = creneau.debsemc
and AFFECTER.JOURC(+)   = CRENEAU.JOURC
and AFFECTER.HEUREDC(+) = CRENEAU.HEUREDC
and AFFECTER.GRPC(+)    = CRENEAU.GRPC
and ENSEIGNER.DEBSEMC(+)= CRENEAU.DEBSEMC
and ENSEIGNER.JOURC(+)  = CRENEAU.JOURC
and ENSEIGNER.HEUREDC(+)= CRENEAU.HEUREDC
and ENSEIGNER.GRPC(+)   = CRENEAU.GRPC;

create table FORMATION as select * from thierry_millan.FORMATION2018;
create table SALLE as select * from thierry_millan.SALLE2018;
create table ENSEIGNANT as select * from thierry_millan.ENSEIGNANT2018;
create table STATUT as select * from thierry_millan.STATUT2018;

alter table FORMATION add constraint PK_FORMATION primary key (IDFOR);
alter table SALLE add constraint PK_SALLE primary key (NSalle);
alter table ENSEIGNANT add constraint PK_ENSEIGNANT primary key (idEnseign);
alter table STATUT add constraint PK_STATU primary key (Grade);

alter table GROUPE add constraint FK_GROUPE_ANNEEC foreign key(ANNEEC) references FORMATION(idFor);
alter table ENSEIGNANT add constraint FK_ENSEIGNANT_GRADE foreign key(Grade) references STATUT(Grade);
alter table ENSEIGNER add constraint FK_ENSEIGNER_ENSC foreign key(ENSC) references ENSEIGNANT(idEnseign);
alter table AFFECTER add constraint FK_AFFECTER_SALC foreign key(SALC) references SALLE(NSALLE);
desc SALLE;
desc AFFECTER;
alter table AFFECTER
modify SALC VARCHAR2(15);
commit;

