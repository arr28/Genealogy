-- Copyright (c) 2004 Edward A. Ridpath.  All rights reserved.
--
-- This file is made available under the terms of the Common Public License v1.0
-- which accompanies this distribution, and is available at
-- http://www.eclipse.org/legal/cpl-v10.html

CREATE DATABASE geneapro;
GRANT all ON geneapro.* TO geneapro@localhost IDENTIFIED BY 'geneapwd';
USE geneapro;

SET FOREIGN_KEY_CHECKS = 0;

-- MySQL dump 9.09
--
-- Host: localhost    Database: geneapro
-- ------------------------------------------------------
-- Server version	4.0.16-nt

--
-- Table structure for table `activity`
--

CREATE TABLE activity (
  id int(11) NOT NULL auto_increment,
  researcherid int(11) NOT NULL default '0',
  scheddate int(11) default '0',
  completedate int(11) default '0',
  typecode int(11) default '0',
  status int(11) default '0',
  description text,
  priority int(11) default '0',
  comments text,
  PRIMARY KEY  (id),
  KEY researcherid (researcherid),
  CONSTRAINT `0_452` FOREIGN KEY (`researcherid`) REFERENCES `researcher` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `activity`
--


--
-- Table structure for table `admintask`
--

CREATE TABLE admintask (
  activityid int(11) NOT NULL default '0',
  PRIMARY KEY  (activityid)
) TYPE=InnoDB;

--
-- Dumping data for table `admintask`
--


--
-- Table structure for table `assertassert`
--

CREATE TABLE assertassert (
  idlo int(11) NOT NULL default '0',
  idhi int(11) NOT NULL default '0',
  seq int(11) default NULL,
  KEY idlo (idlo),
  KEY idhi (idhi),
  CONSTRAINT `0_456` FOREIGN KEY (`idhi`) REFERENCES `assertion` (`id`),
  CONSTRAINT `0_454` FOREIGN KEY (`idlo`) REFERENCES `assertion` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `assertassert`
--

INSERT INTO assertassert VALUES (1,2,0);

--
-- Table structure for table `assertion`
--

CREATE TABLE assertion (
  id int(11) NOT NULL auto_increment,
  suretypartid int(11) default NULL,
  researcherid int(11) default NULL,
  sourceid int(11) default NULL,
  s1id int(11) NOT NULL default '0',
  s1type char(1) NOT NULL default 'P',
  s2id int(11) NOT NULL default '0',
  s2type char(1) NOT NULL default 'P',
  value_role int(11) default NULL,
  disproved tinyint(1) default '0',
  rationale text,
  PRIMARY KEY  (id),
  KEY assertions1id (s1id),
  KEY assertions2id (s2id),
  KEY suretypartid (suretypartid),
  KEY researcherid (researcherid),
  KEY sourceid (sourceid),
  CONSTRAINT `0_466` FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`),
  CONSTRAINT `0_458` FOREIGN KEY (`s1id`) REFERENCES `subject` (`id`),
  CONSTRAINT `0_460` FOREIGN KEY (`s2id`) REFERENCES `subject` (`id`),
  CONSTRAINT `0_462` FOREIGN KEY (`suretypartid`) REFERENCES `suretypart` (`id`),
  CONSTRAINT `0_464` FOREIGN KEY (`researcherid`) REFERENCES `researcher` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `assertion`
--

INSERT INTO assertion VALUES (1,2,1,1,1,'P',2,'E',1,0,NULL);
INSERT INTO assertion VALUES (2,2,1,1,3,'P',4,'E',7,0,NULL);
INSERT INTO assertion VALUES (3,2,1,1,5,'P',6,'E',2,0,NULL);
INSERT INTO assertion VALUES (4,2,1,1,6,'P',7,'E',4,0,NULL);
INSERT INTO assertion VALUES (5,2,1,1,8,'P',12,'G',3,0,NULL);
INSERT INTO assertion VALUES (6,2,1,1,9,'P',12,'G',2,0,NULL);
INSERT INTO assertion VALUES (7,1,1,1,1,'P',10,'G',27,0,NULL);
INSERT INTO assertion VALUES (8,2,1,1,3,'P',10,'G',27,0,NULL);
INSERT INTO assertion VALUES (9,2,1,1,8,'P',10,'G',27,0,NULL);
INSERT INTO assertion VALUES (10,2,1,1,5,'P',11,'G',27,0,NULL);
INSERT INTO assertion VALUES (11,2,1,1,9,'P',11,'G',27,0,NULL);
INSERT INTO assertion VALUES (12,3,1,1,6,'P',12,'G',1,0,NULL);
INSERT INTO assertion VALUES (13,2,1,1,1,'P',13,'C',NULL,0,NULL);
INSERT INTO assertion VALUES (14,2,1,1,10,'G',14,'P',NULL,0,NULL);
INSERT INTO assertion VALUES (15,2,1,1,11,'G',15,'P',27,0,NULL);

--
-- Table structure for table `calendar`
--

CREATE TABLE calendar (
  idbase int(11) NOT NULL default '0',
  idvar int(11) NOT NULL default '0',
  name text
) TYPE=InnoDB;

--
-- Dumping data for table `calendar`
--

INSERT INTO calendar VALUES (1,0,'Gregorian 1582');
INSERT INTO calendar VALUES (1,1,'Gregorian Great Britain and Colonies 1752');
INSERT INTO calendar VALUES (2,0,'Julian 8 CE');

--
-- Table structure for table `charpart`
--

CREATE TABLE charpart (
  id int(11) NOT NULL auto_increment,
  charid int(11) NOT NULL default '0',
  chartypeid int(11) NOT NULL default '0',
  charname text,
  cpseq int(11) NOT NULL default '0',
  PRIMARY KEY  (id),
  KEY charid (charid),
  KEY chartypeid (chartypeid),
  CONSTRAINT `0_470` FOREIGN KEY (`chartypeid`) REFERENCES `chartype` (`id`),
  CONSTRAINT `0_468` FOREIGN KEY (`charid`) REFERENCES `subject` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `charpart`
--

INSERT INTO charpart VALUES (1,13,4,'John',0);
INSERT INTO charpart VALUES (2,13,5,'Doe',1);

--
-- Table structure for table `chartype`
--

CREATE TABLE chartype (
  id int(11) NOT NULL auto_increment,
  name text,
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `chartype`
--

INSERT INTO chartype VALUES (1,'Occupation');
INSERT INTO chartype VALUES (2,'Government ID Number');
INSERT INTO chartype VALUES (3,'Mononame');
INSERT INTO chartype VALUES (4,'Given Name');
INSERT INTO chartype VALUES (5,'Surname');
INSERT INTO chartype VALUES (6,'Name Prefix');
INSERT INTO chartype VALUES (7,'Name Suffix');
INSERT INTO chartype VALUES (8,'Title');
INSERT INTO chartype VALUES (9,'PreSurname');
INSERT INTO chartype VALUES (10,'Religious Name');
INSERT INTO chartype VALUES (11,'Nickname');
INSERT INTO chartype VALUES (12,'dit Name');
INSERT INTO chartype VALUES (13,'Farm Name');
INSERT INTO chartype VALUES (14,'Patrynomic');
INSERT INTO chartype VALUES (15,'Matrynomic');
INSERT INTO chartype VALUES (16,'Connector name');
INSERT INTO chartype VALUES (17,'AFN');
INSERT INTO chartype VALUES (18,'Ethnicity');
INSERT INTO chartype VALUES (19,'Religion');
INSERT INTO chartype VALUES (20,'Cause of Death');
INSERT INTO chartype VALUES (21,'Number of Children');
INSERT INTO chartype VALUES (22,'Hair Color');
INSERT INTO chartype VALUES (23,'Eye Color');
INSERT INTO chartype VALUES (24,'Skin Color');
INSERT INTO chartype VALUES (25,'Physical Description');
INSERT INTO chartype VALUES (26,'Medical Condition');
INSERT INTO chartype VALUES (27,'Age');
INSERT INTO chartype VALUES (28,'Nationality');
INSERT INTO chartype VALUES (29,'Citizenship');
INSERT INTO chartype VALUES (30,'Screen Name');
INSERT INTO chartype VALUES (31,'Sex');
INSERT INTO chartype VALUES (32,'Language');
INSERT INTO chartype VALUES (33,'Literacy');
INSERT INTO chartype VALUES (34,'RFN');
INSERT INTO chartype VALUES (35,'RIN');
INSERT INTO chartype VALUES (36,'SSN');
INSERT INTO chartype VALUES (37,'Personality');
INSERT INTO chartype VALUES (38,'Attributes');
INSERT INTO chartype VALUES (39,'Living');
INSERT INTO chartype VALUES (40,'Number of Marriages');
INSERT INTO chartype VALUES (41,'Marital Status');
INSERT INTO chartype VALUES (42,'Address');
INSERT INTO chartype VALUES (43,'Telephone');
INSERT INTO chartype VALUES (44,'email');

--
-- Table structure for table `citationpart`
--

CREATE TABLE citationpart (
  sourceid int(11) NOT NULL default '0',
  citparttypeid int(11) NOT NULL default '0',
  value text NOT NULL,
  KEY sourceid (sourceid),
  KEY citparttypeid (citparttypeid),
  CONSTRAINT `0_474` FOREIGN KEY (`citparttypeid`) REFERENCES `citationparttype` (`id`),
  CONSTRAINT `0_472` FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `citationpart`
--


--
-- Table structure for table `citationparttype`
--

CREATE TABLE citationparttype (
  id int(11) NOT NULL auto_increment,
  name text,
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `citationparttype`
--


--
-- Table structure for table `datepart`
--

CREATE TABLE datepart (
  dateid int(11) NOT NULL default '0',
  parttype int(11) NOT NULL default '0',
  jdn double NOT NULL default '0',
  hi int(11) NOT NULL default '0',
  lo int(11) NOT NULL default '0',
  fuzzy int(11) NOT NULL default '0',
  beforeafter int(11) NOT NULL default '0',
  range int(11) NOT NULL default '0',
  irregular int(11) NOT NULL default '0',
  partiallevel int(11) NOT NULL default '0',
  KEY dateid (dateid),
  CONSTRAINT `0_476` FOREIGN KEY (`dateid`) REFERENCES `dates` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `datepart`
--

INSERT INTO datepart VALUES (1,0,2436332,365,0,2,1,3,0,180);
INSERT INTO datepart VALUES (1,1,2436456,365,0,3,2,4,1,90);
INSERT INTO datepart VALUES (1,2,2436332,365,0,1,1,0,2,365);
INSERT INTO datepart VALUES (2,0,2438332,0,0,1,0,0,0,0);
INSERT INTO datepart VALUES (3,0,1721426,0,0,3,0,2,2,30);
INSERT INTO datepart VALUES (4,0,0,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (5,0,2438332,365,0,1,0,0,0,365);
INSERT INTO datepart VALUES (26,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (26,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (27,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (27,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (28,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (28,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (29,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (29,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (30,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (30,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (31,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (31,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (32,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (32,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (33,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (33,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (34,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (34,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (35,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (35,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (36,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (36,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (37,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (37,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (38,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (38,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (39,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (39,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (40,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (40,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (41,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (41,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (44,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (44,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (44,2,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (45,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (45,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (45,2,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (46,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (46,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (46,2,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (47,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (47,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (47,2,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (48,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (48,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (48,2,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (50,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (50,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (50,2,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (52,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (52,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (52,2,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (53,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (53,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (53,2,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (54,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (54,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (55,0,2436332,365,0,1,0,0,0,0);
INSERT INTO datepart VALUES (55,1,2436332,0,0,3,0,2,2,12);
INSERT INTO datepart VALUES (55,2,2436332,0,0,3,0,2,2,12);

--
-- Table structure for table `dates`
--

CREATE TABLE dates (
  id int(11) NOT NULL auto_increment,
  datestr text,
  calbase int(4) NOT NULL default '0',
  calvar int(4) NOT NULL default '0',
  dplace int(11) default NULL,
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `dates`
--

INSERT INTO dates VALUES (1,'FROM before circa  1951? TO just after Sputnik launch',0,0,0);
INSERT INTO dates VALUES (2,'Testing Date String',0,0,1);
INSERT INTO dates VALUES (3,'Testing Date String',0,0,1);
INSERT INTO dates VALUES (4,'Testing Date String',0,0,1);
INSERT INTO dates VALUES (5,'Testing Date String',0,0,1);
INSERT INTO dates VALUES (6,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (7,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (8,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (9,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (10,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (11,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (12,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (13,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (14,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (15,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (16,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (17,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (18,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (19,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (20,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (21,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (22,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (23,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (24,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (25,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (26,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (27,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (28,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (29,'Testing Date String',0,0,1);
INSERT INTO dates VALUES (30,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (31,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (32,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (33,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (34,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (35,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (36,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (37,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (38,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (39,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (40,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (41,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (42,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (43,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (44,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (45,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (46,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (47,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (48,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (49,'Testing Date String',0,0,1);
INSERT INTO dates VALUES (50,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (51,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (52,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (53,'Testing Update of date string',0,0,1);
INSERT INTO dates VALUES (54,'Testing Date String',0,0,1);
INSERT INTO dates VALUES (55,'Testing Update of date string',0,0,1);

--
-- Table structure for table `egrole`
--

CREATE TABLE egrole (
  id int(11) NOT NULL auto_increment,
  egtypeid int(11) NOT NULL default '0',
  stype char(1) NOT NULL default 'E',
  role text,
  gseq int(11) NOT NULL default '0',
  PRIMARY KEY  (id),
  KEY egtypeid (egtypeid),
  CONSTRAINT `0_478` FOREIGN KEY (`egtypeid`) REFERENCES `egtype` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `egrole`
--

INSERT INTO egrole VALUES (1,1,'E','Infant',0);
INSERT INTO egrole VALUES (2,1,'E','Mother',1);
INSERT INTO egrole VALUES (3,1,'E','Father',2);
INSERT INTO egrole VALUES (4,1,'E','Midwife',3);
INSERT INTO egrole VALUES (5,1,'E','Doctor',3);
INSERT INTO egrole VALUES (6,1,'E','Clergy',3);
INSERT INTO egrole VALUES (7,3,'E','Groom',0);
INSERT INTO egrole VALUES (8,3,'E','Bride',1);
INSERT INTO egrole VALUES (9,3,'E','Father of Groom',2);
INSERT INTO egrole VALUES (10,3,'E','Mother of Groom',3);
INSERT INTO egrole VALUES (11,3,'E','Father of Bride',4);
INSERT INTO egrole VALUES (12,3,'E','Mother of Bride',5);
INSERT INTO egrole VALUES (13,3,'E','Best Man',5);
INSERT INTO egrole VALUES (14,3,'E','Bridesmaid',6);
INSERT INTO egrole VALUES (15,3,'E','Clergy',7);
INSERT INTO egrole VALUES (16,3,'E','Officiate',8);
INSERT INTO egrole VALUES (17,3,'E','Witness',9);
INSERT INTO egrole VALUES (18,4,'E','Deceased',0);
INSERT INTO egrole VALUES (19,4,'E','Widow',1);
INSERT INTO egrole VALUES (20,4,'E','Widower',1);
INSERT INTO egrole VALUES (21,4,'E','Child of Deceased',2);
INSERT INTO egrole VALUES (22,4,'E','Son of Deceased',2);
INSERT INTO egrole VALUES (23,4,'E','Daughter of Deceased',2);
INSERT INTO egrole VALUES (24,4,'E','Doctor',3);
INSERT INTO egrole VALUES (25,4,'E','Clergy',4);
INSERT INTO egrole VALUES (26,4,'E','Witness',5);
INSERT INTO egrole VALUES (27,2,'G','SamePerson',1);

--
-- Table structure for table `egtype`
--

CREATE TABLE egtype (
  id int(11) NOT NULL auto_increment,
  stype char(1) NOT NULL default 'E',
  tname text,
  gorder char(1) default NULL,
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `egtype`
--

INSERT INTO egtype VALUES (1,'E','Birth',NULL);
INSERT INTO egtype VALUES (2,'G','SamePerson','A');
INSERT INTO egtype VALUES (3,'E','Marriage','A');
INSERT INTO egtype VALUES (4,'E','Death','A');
INSERT INTO egtype VALUES (5,'E','Burial','A');
INSERT INTO egtype VALUES (6,'E','Resides','A');
INSERT INTO egtype VALUES (7,'E','Adoption','A');
INSERT INTO egtype VALUES (9,'E','Annulment','A');
INSERT INTO egtype VALUES (10,'G','Association','A');
INSERT INTO egtype VALUES (11,'E','Baptism','A');
INSERT INTO egtype VALUES (12,'E','Bar Mitzvah','A');
INSERT INTO egtype VALUES (13,'E','Bas Mitzvah','A');
INSERT INTO egtype VALUES (14,'E','Blessing','A');
INSERT INTO egtype VALUES (15,'E','Census','A');
INSERT INTO egtype VALUES (16,'E','Christening','A');
INSERT INTO egtype VALUES (17,'G','Parent/Child - Natural','A');
INSERT INTO egtype VALUES (18,'E','Adult Christening','A');
INSERT INTO egtype VALUES (19,'E','Confirmation','A');
INSERT INTO egtype VALUES (20,'E','Cremation','A');
INSERT INTO egtype VALUES (21,'E','Divorce','A');
INSERT INTO egtype VALUES (22,'E','File for Divorce','A');
INSERT INTO egtype VALUES (23,'E','Education','A');
INSERT INTO egtype VALUES (24,'E','Emigration','A');
INSERT INTO egtype VALUES (25,'E','Engagement','A');
INSERT INTO egtype VALUES (26,'E','First Communion','A');
INSERT INTO egtype VALUES (27,'E','Graduation','A');
INSERT INTO egtype VALUES (29,'E','Immigration','A');
INSERT INTO egtype VALUES (30,'E','Marriage Banns','A');
INSERT INTO egtype VALUES (31,'E','Marriage Contract','A');
INSERT INTO egtype VALUES (32,'E','Marriage License','A');
INSERT INTO egtype VALUES (33,'E','Marriage Settlement','A');
INSERT INTO egtype VALUES (34,'E','Ordination','A');
INSERT INTO egtype VALUES (35,'E','Will Probate','A');
INSERT INTO egtype VALUES (36,'E','Real Estate','A');
INSERT INTO egtype VALUES (37,'E','Retirement','A');
INSERT INTO egtype VALUES (38,'E','Will','A');
INSERT INTO egtype VALUES (39,'G','Caste','A');
INSERT INTO egtype VALUES (40,'E','Codicil','A');
INSERT INTO egtype VALUES (41,'E','Arrest','A');
INSERT INTO egtype VALUES (42,'E','Indictment','A');
INSERT INTO egtype VALUES (43,'E','Conviction','A');
INSERT INTO egtype VALUES (44,'E','Acquittal','A');
INSERT INTO egtype VALUES (45,'E','Employment','A');
INSERT INTO egtype VALUES (46,'E','Excommunication','A');
INSERT INTO egtype VALUES (47,'G','Friends','A');
INSERT INTO egtype VALUES (49,'E','Battle','A');
INSERT INTO egtype VALUES (50,'E','War','A');
INSERT INTO egtype VALUES (51,'E','Military Service','A');
INSERT INTO egtype VALUES (52,'E','Military Join','A');
INSERT INTO egtype VALUES (53,'E','Military Discharge','A');
INSERT INTO egtype VALUES (54,'E','Indenture','A');
INSERT INTO egtype VALUES (55,'E','Marriage Bond','A');
INSERT INTO egtype VALUES (56,'E','Separation','A');
INSERT INTO egtype VALUES (57,'E','Reconcile','A');
INSERT INTO egtype VALUES (58,'E','Naturalization','A');
INSERT INTO egtype VALUES (59,'E','Ordinance','A');
INSERT INTO egtype VALUES (60,'E','Civil Union','A');
INSERT INTO egtype VALUES (61,'E','Domestic Union','A');
INSERT INTO egtype VALUES (62,'G','Passenger List','A');
INSERT INTO egtype VALUES (63,'E','Voyage','A');
INSERT INTO egtype VALUES (64,'E','Religious Conversion','A');
INSERT INTO egtype VALUES (65,'E','Catastrophe','A');

--
-- Table structure for table `place`
--

CREATE TABLE place (
  id int(11) NOT NULL auto_increment,
  existdate int(11) NOT NULL default '0',
  porder char(1) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `place`
--

INSERT INTO place VALUES (1,0,'A');
INSERT INTO place VALUES (2,0,'A');
INSERT INTO place VALUES (3,0,'A');
INSERT INTO place VALUES (4,0,'A');

--
-- Table structure for table `placepart`
--

CREATE TABLE placepart (
  placeparttypeid int(11) NOT NULL default '0',
  placeid int(11) NOT NULL default '0',
  name text NOT NULL,
  seq int(11) NOT NULL default '0',
  KEY placeparttypeid (placeparttypeid),
  KEY placeid (placeid),
  CONSTRAINT `0_482` FOREIGN KEY (`placeid`) REFERENCES `place` (`id`),
  CONSTRAINT `0_480` FOREIGN KEY (`placeparttypeid`) REFERENCES `placeparttype` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `placepart`
--

INSERT INTO placepart VALUES (1,1,'Earth',1);
INSERT INTO placepart VALUES (2,1,'Europe',2);
INSERT INTO placepart VALUES (3,1,'United Kingdom',3);
INSERT INTO placepart VALUES (3,1,'Scotland',4);
INSERT INTO placepart VALUES (11,1,'Berwickshire',5);
INSERT INTO placepart VALUES (10,1,'Redpath',6);
INSERT INTO placepart VALUES (4,2,'Texas',4);
INSERT INTO placepart VALUES (4,3,'Minnesota',4);
INSERT INTO placepart VALUES (4,4,'New York',4);

--
-- Table structure for table `placeparttype`
--

CREATE TABLE placeparttype (
  id int(11) NOT NULL auto_increment,
  name text,
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `placeparttype`
--

INSERT INTO placeparttype VALUES (1,'Planet');
INSERT INTO placeparttype VALUES (2,'Continent');
INSERT INTO placeparttype VALUES (3,'Country');
INSERT INTO placeparttype VALUES (4,'State');
INSERT INTO placeparttype VALUES (5,'Province');
INSERT INTO placeparttype VALUES (6,'County');
INSERT INTO placeparttype VALUES (7,'District');
INSERT INTO placeparttype VALUES (8,'Ocean');
INSERT INTO placeparttype VALUES (9,'Township');
INSERT INTO placeparttype VALUES (10,'Borough');
INSERT INTO placeparttype VALUES (11,'Shire');

--
-- Table structure for table `project`
--

CREATE TABLE project (
  id int(11) NOT NULL auto_increment,
  name text,
  projectdesc text,
  clientdata text,
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `project`
--


--
-- Table structure for table `repository`
--

CREATE TABLE repository (
  id int(11) NOT NULL auto_increment,
  placeid int(11) default '0',
  name text,
  address text,
  phone text,
  hours text,
  comments text,
  PRIMARY KEY  (id),
  KEY placeid (placeid),
  CONSTRAINT `0_484` FOREIGN KEY (`placeid`) REFERENCES `place` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `repository`
--


--
-- Table structure for table `representation`
--

CREATE TABLE representation (
  sourceid int(11) NOT NULL default '0',
  reptypeid int(11) NOT NULL default '0',
  physfilecode text NOT NULL,
  medium text NOT NULL,
  content longblob NOT NULL,
  KEY sourceid (sourceid),
  KEY reptypeid (reptypeid),
  CONSTRAINT `0_488` FOREIGN KEY (`reptypeid`) REFERENCES `representtype` (`id`),
  CONSTRAINT `0_486` FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `representation`
--


--
-- Table structure for table `representtype`
--

CREATE TABLE representtype (
  id int(11) NOT NULL auto_increment,
  name text,
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `representtype`
--


--
-- Table structure for table `repsrc`
--

CREATE TABLE repsrc (
  repositoryid int(11) NOT NULL default '0',
  sourceid int(11) NOT NULL default '0',
  activityid int(11) default '0',
  callnumber text,
  description text,
  KEY repositoryid (repositoryid),
  KEY sourceid (sourceid),
  KEY activityid (activityid),
  CONSTRAINT `0_494` FOREIGN KEY (`activityid`) REFERENCES `activity` (`id`),
  CONSTRAINT `0_490` FOREIGN KEY (`repositoryid`) REFERENCES `repository` (`id`),
  CONSTRAINT `0_492` FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `repsrc`
--


--
-- Table structure for table `researcher`
--

CREATE TABLE researcher (
  id int(11) NOT NULL auto_increment,
  name text NOT NULL,
  addressid int(11) default NULL,
  comments text,
  PRIMARY KEY  (id),
  KEY addressid (addressid),
  CONSTRAINT `0_496` FOREIGN KEY (`addressid`) REFERENCES `place` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `researcher`
--

INSERT INTO researcher VALUES (1,'Edward A. Ridpath',1,NULL);

--
-- Table structure for table `resobject`
--

CREATE TABLE resobject (
  resobjid int(11) NOT NULL default '0',
  activityid int(11) NOT NULL default '0',
  KEY resobjid (resobjid),
  KEY activityid (activityid),
  CONSTRAINT `0_500` FOREIGN KEY (`activityid`) REFERENCES `activity` (`id`),
  CONSTRAINT `0_498` FOREIGN KEY (`resobjid`) REFERENCES `resobjective` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `resobject`
--


--
-- Table structure for table `resobjective`
--

CREATE TABLE resobjective (
  id int(11) NOT NULL auto_increment,
  projid int(11) default '0',
  name text,
  description text,
  seq int(11) default '0',
  priority int(11) default '0',
  status int(11) default '0',
  PRIMARY KEY  (id),
  KEY projid (projid),
  CONSTRAINT `0_502` FOREIGN KEY (`projid`) REFERENCES `project` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `resobjective`
--


--
-- Table structure for table `resproj`
--

CREATE TABLE resproj (
  idres int(11) NOT NULL default '0',
  idproj int(11) NOT NULL default '0',
  role text,
  KEY idres (idres),
  KEY idproj (idproj),
  CONSTRAINT `0_506` FOREIGN KEY (`idproj`) REFERENCES `project` (`id`),
  CONSTRAINT `0_504` FOREIGN KEY (`idres`) REFERENCES `researcher` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `resproj`
--


--
-- Table structure for table `search`
--

CREATE TABLE search (
  activityid int(11) NOT NULL default '0',
  sourceid int(11) default '0',
  repositoryid int(11) default '0',
  searchedfor text,
  PRIMARY KEY  (activityid),
  KEY activityid (activityid),
  KEY sourceid (sourceid),
  KEY repositoryid (repositoryid),
  CONSTRAINT `0_512` FOREIGN KEY (`repositoryid`) REFERENCES `repository` (`id`),
  CONSTRAINT `0_508` FOREIGN KEY (`activityid`) REFERENCES `activity` (`id`),
  CONSTRAINT `0_510` FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `search`
--


--
-- Table structure for table `source`
--

CREATE TABLE source (
  id int(11) NOT NULL auto_increment,
  highersourceid int(11) default '0',
  subjectplaceid int(11) default '0',
  jurisplaceid int(11) default '0',
  researcherid int(11) default '0',
  subjectdate int(11) default '0',
  medium text,
  comments text,
  PRIMARY KEY  (id),
  KEY highersourceid (highersourceid),
  KEY subjectplaceid (subjectplaceid),
  KEY jurisplaceid (jurisplaceid),
  KEY researcherid (researcherid),
  CONSTRAINT `0_520` FOREIGN KEY (`researcherid`) REFERENCES `researcher` (`id`),
  CONSTRAINT `0_514` FOREIGN KEY (`highersourceid`) REFERENCES `source` (`id`),
  CONSTRAINT `0_516` FOREIGN KEY (`subjectplaceid`) REFERENCES `place` (`id`),
  CONSTRAINT `0_518` FOREIGN KEY (`jurisplaceid`) REFERENCES `place` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `source`
--

INSERT INTO source VALUES (1,NULL,1,1,1,1,'paper','Test Source');

--
-- Table structure for table `sourcegroup`
--

CREATE TABLE sourcegroup (
  id int(11) NOT NULL auto_increment,
  name text NOT NULL,
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `sourcegroup`
--


--
-- Table structure for table `srcgrpsrc`
--

CREATE TABLE srcgrpsrc (
  sourceid int(11) NOT NULL default '0',
  sourcegroupid int(11) NOT NULL default '0',
  KEY sourceid (sourceid),
  KEY sourcegroupid (sourcegroupid),
  CONSTRAINT `0_524` FOREIGN KEY (`sourcegroupid`) REFERENCES `sourcegroup` (`id`),
  CONSTRAINT `0_522` FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `srcgrpsrc`
--


--
-- Table structure for table `subject`
--

CREATE TABLE subject (
  id int(11) NOT NULL auto_increment,
  stype char(1) NOT NULL default 'P',
  egtypeid int(11) default NULL,
  placeid int(11) default NULL,
  name text,
  comments text,
  corder char(1) default NULL,
  subjdate int(11) default NULL,
  PRIMARY KEY  (id),
  KEY egtypeid (egtypeid),
  KEY placeid (placeid),
  CONSTRAINT `0_530` FOREIGN KEY (`placeid`) REFERENCES `place` (`id`),
  CONSTRAINT `0_526` FOREIGN KEY (`egtypeid`) REFERENCES `egtype` (`id`),
  CONSTRAINT `0_528` FOREIGN KEY (`placeid`) REFERENCES `place` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `subject`
--

INSERT INTO subject VALUES (1,'P',NULL,NULL,'John Doe, Sr.','no comment','A',NULL);
INSERT INTO subject VALUES (2,'E',1,4,'Birth of John Doe, Sr.','no comment','A',1);
INSERT INTO subject VALUES (3,'P',NULL,NULL,'John Doe, Sr.',NULL,'A',NULL);
INSERT INTO subject VALUES (4,'E',3,2,'Marriage of John Doe, Sr. and Jill Roe','no comment','A',2);
INSERT INTO subject VALUES (5,'P',NULL,NULL,'Jill Moe','no comment','A',NULL);
INSERT INTO subject VALUES (6,'P',1,NULL,'John Doe, Jr.','Edward as given','A',NULL);
INSERT INTO subject VALUES (7,'E',1,3,'Birth of John Doe, Jr.',NULL,'A',3);
INSERT INTO subject VALUES (8,'P',NULL,NULL,'John Doe, Sr.','none','A',NULL);
INSERT INTO subject VALUES (9,'P',NULL,NULL,'Jill Moe','none','A',NULL);
INSERT INTO subject VALUES (10,'G',2,NULL,'SamePerson John Doe, Sr','Comment','A',NULL);
INSERT INTO subject VALUES (11,'G',2,NULL,'SamePerson Group of Jill Moe','none','A',4);
INSERT INTO subject VALUES (12,'G',17,NULL,'Parent Child Group','none','A',5);
INSERT INTO subject VALUES (13,'C',NULL,1,'John Doe, Sr. Name',NULL,'A',1);
INSERT INTO subject VALUES (14,'P',2,NULL,'Higher Level Persona John Doe, Sr.',NULL,'A',NULL);
INSERT INTO subject VALUES (15,'P',2,NULL,'Jill Moe Higher LEvel Persona',NULL,'A',NULL);

--
-- Table structure for table `suretypart`
--

CREATE TABLE suretypart (
  id int(11) NOT NULL auto_increment,
  schemeid int(11) NOT NULL default '0',
  name text,
  description text,
  seq int(11) NOT NULL default '0',
  PRIMARY KEY  (id),
  KEY schemeididx (schemeid),
  CONSTRAINT `0_532` FOREIGN KEY (`schemeid`) REFERENCES `suretyscheme` (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `suretypart`
--

INSERT INTO suretypart VALUES (1,1,'A','I was there and saw it with my own eyes',1);
INSERT INTO suretypart VALUES (2,1,'B','Official, contemporaneous, trusted record',1);
INSERT INTO suretypart VALUES (3,1,'C','Unofficial, contemporaneous, trusted record',1);

--
-- Table structure for table `suretyscheme`
--

CREATE TABLE suretyscheme (
  id int(11) NOT NULL auto_increment,
  name text,
  description text,
  PRIMARY KEY  (id)
) TYPE=InnoDB;

--
-- Dumping data for table `suretyscheme`
--

INSERT INTO suretyscheme VALUES (1,'Ed Ridpath\'s Surety Scheme','Graded A-Z');
