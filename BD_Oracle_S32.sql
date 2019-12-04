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

ALTER TABLE AFFECTER add constraint FK_AFFECTER_DEBSEMC_GRPC foreign key(DEBSEMC,JOURC,HEUREDC,GRPC)REFERENCES CRENEAU(DEBSEMC,JOURC,HEUREDC,GRPC);
ALTER TABLE ENSEIGNER add constraint FK_AFFECTER_ENSEIGNER_GRPC foreign key(DEBSEMC,JOURC,HEUREDC,GRPC)REFERENCES CRENEAU(DEBSEMC,JOURC,HEUREDC,GRPC);

