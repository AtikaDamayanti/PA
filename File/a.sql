/*==============================================================*/
/* Database name:  MODEL_1                                      */
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     31/05/2017 12:53:00                          */
/*==============================================================*/


/*==============================================================*/
/* Database: MODEL_1                                            */
/*==============================================================*/


/*==============================================================*/
/* Table: ALKET                                                 */
/*==============================================================*/
create table ALKET
(
   NO_ALKET             VARCHAR(10) not null,
   NIP                  VARCHAR(10),
   KODE_JENIS_DOKUMEN   VARCHAR(10),
   KODE_WP              VARCHAR(10),
   KODE_NON_WP          VARCHAR(10),
   KODE_STATUS_DOKUMEN  VARCHAR(10),
   UNIT_KERJA_ASAL      VARCHAR(10),
   UNIT_KERJA_TUJUAN    VARCHAR(10),
   TGL_KIRIM            DATE,
   TGL_TERIMA           DATE,
   LEMBAR               INTEGER,
   NILAI_ALKET          INTEGER,
   TGL_REALISASI        DATE,
   KETERANGAN           VARCHAR(300),
   NILAI_REALISASI      INTEGER,
   DOKUMEN              VARCHAR(50),
   TGL_LAPORAN          DATE,
   primary key (NO_ALKET)
);

/*==============================================================*/
/* Table: DISPOSISI                                             */
/*==============================================================*/
create table DISPOSISI
(
   NO_DISPOSISI         INTEGER not null,
   NO_ALKET             VARCHAR(10) not null,
   PENGIRIM_DISPOSISI   VARCHAR(10),
   PENERIMA_DISPOSISI   VARCHAR(10),
   TGL_DISPOSISI        DATETIME,
   KETERANGAN_DISPOSI   VARCHAR(150),
   primary key (NO_DISPOSISI)
);

/*==============================================================*/
/* Table: DIVISI                                                */
/*==============================================================*/
create table DIVISI
(
   KODE_DIVISI          VARCHAR(10) not null,
   NAMA_DIVISI          VARCHAR(50),
   primary key (KODE_DIVISI)
);

/*==============================================================*/
/* Table: JABATAN                                               */
/*==============================================================*/
create table JABATAN
(
   KODE_JABATAN         VARCHAR(10) not null,
   JABATAN_INDUK        VARCHAR(10),
   KODE_DIVISI          VARCHAR(10) not null,
   NAMA_JABATAN         VARCHAR(40),
   LEVEL                INTEGER,
   primary key (KODE_JABATAN)
);

/*==============================================================*/
/* Table: JENIS_DOKUMEN                                         */
/*==============================================================*/
create table JENIS_DOKUMEN
(
   KODE_JENIS_DOKUMEN   VARCHAR(10) not null,
   NAMA_JENIS_DOKUMEN   VARCHAR(30),
   primary key (KODE_JENIS_DOKUMEN)
);

/*==============================================================*/
/* Table: NON_WAJIB_PAJAK                                       */
/*==============================================================*/
create table NON_WAJIB_PAJAK
(
   KODE_NON_WP          VARCHAR(10) not null,
   NAMA_NON_WP          VARCHAR(30),
   KOTA_NON_WP          VARCHAR(20),
   TELP_NON_WP          VARCHAR(15),
   KPP_NON_WP           VARCHAR(10),
   ALAMAT_NON_WP        VARCHAR(100),
   primary key (KODE_NON_WP)
);

/*==============================================================*/
/* Table: PEGAWAI                                               */
/*==============================================================*/
create table PEGAWAI
(
   NIP                  VARCHAR(10) not null,
   KODE_JABATAN         VARCHAR(10),
   KODE_UNIT_KERJA      VARCHAR(10),
   PASSWORD             VARCHAR(20),
   NAMA_PEGAWAI         VARCHAR(30),
   ALAMAT_PEGAWAI       VARCHAR(300),
   TELP_PEGAWAI         VARCHAR(15),
   FOTO_PEGAWAI         VARCHAR(30),
   primary key (NIP)
);

/*==============================================================*/
/* Table: STATUS_DOKUMEN                                        */
/*==============================================================*/
create table STATUS_DOKUMEN
(
   KODE_STATUS_DOKUMEN  VARCHAR(10) not null,
   NAMA_STATUS_DOKUMEN  VARCHAR(20),
   primary key (KODE_STATUS_DOKUMEN)
);

/*==============================================================*/
/* Table: UNIT_KERJA                                            */
/*==============================================================*/
create table UNIT_KERJA
(
   KODE_UNIT_KERJA      VARCHAR(10) not null,
   NAMA_UNIT_KERJA      VARCHAR(50),
   ALAMAT_UNIT_KERJA    VARCHAR(70),
   primary key (KODE_UNIT_KERJA)
);

/*==============================================================*/
/* Table: WAJIB_PAJAK                                           */
/*==============================================================*/
create table WAJIB_PAJAK
(
   KODE_WP              VARCHAR(10) not null,
   AR                   VARCHAR(10),
   NPWP                 VARCHAR(20),
   NAMA_WP              VARCHAR(30),
   ALAMAT_WP            VARCHAR(100),
   KOTA_WP              VARCHAR(20),
   primary key (KODE_WP)
);

alter table ALKET add constraint FK_BERJENIS foreign key (KODE_JENIS_DOKUMEN)
      references JENIS_DOKUMEN (KODE_JENIS_DOKUMEN) on delete restrict on update restrict;

alter table ALKET add constraint FK_BERSTATUS foreign key (KODE_STATUS_DOKUMEN)
      references STATUS_DOKUMEN (KODE_STATUS_DOKUMEN) on delete restrict on update restrict;

alter table ALKET add constraint FK_MEMILIKI foreign key (KODE_WP)
      references WAJIB_PAJAK (KODE_WP) on delete restrict on update restrict;

alter table ALKET add constraint FK_MENERIMA foreign key (UNIT_KERJA_TUJUAN)
      references UNIT_KERJA (KODE_UNIT_KERJA) on delete restrict on update restrict;

alter table ALKET add constraint FK_MENGELOLA foreign key (NIP)
      references PEGAWAI (NIP) on delete restrict on update restrict;

alter table ALKET add constraint FK_MENGIRIM foreign key (UNIT_KERJA_ASAL)
      references UNIT_KERJA (KODE_UNIT_KERJA) on delete restrict on update restrict;

alter table ALKET add constraint FK_RELATION_464 foreign key (KODE_NON_WP)
      references NON_WAJIB_PAJAK (KODE_NON_WP) on delete restrict on update restrict;

alter table DISPOSISI add constraint FK_MENERIMA2 foreign key (PENGIRIM_DISPOSISI)
      references PEGAWAI (NIP) on delete restrict on update restrict;

alter table DISPOSISI add constraint FK_MENGIRIM2 foreign key (PENERIMA_DISPOSISI)
      references PEGAWAI (NIP) on delete restrict on update restrict;

alter table DISPOSISI add constraint FK_SUMBER_DATA foreign key (NO_ALKET)
      references ALKET (NO_ALKET) on delete restrict on update restrict;

alter table JABATAN add constraint FK_BERDIVISI foreign key (KODE_DIVISI)
      references DIVISI (KODE_DIVISI) on delete restrict on update restrict;

alter table JABATAN add constraint FK_SUPERVISI foreign key (JABATAN_INDUK)
      references JABATAN (KODE_JABATAN) on delete restrict on update restrict;

alter table PEGAWAI add constraint FK_BERTEMPAT foreign key (KODE_UNIT_KERJA)
      references UNIT_KERJA (KODE_UNIT_KERJA) on delete restrict on update restrict;

alter table PEGAWAI add constraint FK_MENJABAT foreign key (KODE_JABATAN)
      references JABATAN (KODE_JABATAN) on delete restrict on update restrict;

alter table WAJIB_PAJAK add constraint FK_MEMBAWAHI foreign key (AR)
      references PEGAWAI (NIP) on delete restrict on update restrict;

