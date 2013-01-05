DROP   DATABASE personae;
CREATE DATABASE personae;
USE             personae;

SET FOREIGN_KEY_CHECKS = 1;

/*****************************************************************************/
/* Place. (CONC)                                                             */
/*****************************************************************************/
CREATE TABLE place (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  existdate       int(11)    NOT NULL DEFAULT '0',
  porder          char(1)    NOT NULL DEFAULT '',

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Place Part Type. (CONC)                                                   */
/*****************************************************************************/
CREATE TABLE placeparttype (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  name            text           NULL,

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Place Part. (CONC)                                                        */
/*****************************************************************************/
CREATE TABLE placepart (
  placeparttypeid int(11)    NOT NULL DEFAULT '0',
  placeid         int(11)    NOT NULL DEFAULT '0',
  name            text       NOT NULL,
  seq             int(11)    NOT NULL DEFAULT '0',

  KEY placeparttypeid (placeparttypeid),
  KEY placeid (placeid),
  FOREIGN KEY (`placeid`) REFERENCES `place` (`id`),
  FOREIGN KEY (`placeparttypeid`) REFERENCES `placeparttype` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Surety Scheme. (ADM)                                                      */
/*****************************************************************************/
CREATE TABLE suretyscheme (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  name            text,
  description     text,

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Surety Part. (ADM)                                                        */
/*****************************************************************************/
CREATE TABLE suretypart (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  schemeid        int(11)    NOT NULL DEFAULT '0',
  name            text           NULL,
  description     text           NULL,
  seq             int(11)    NOT NULL DEFAULT '0',

  PRIMARY KEY (id),
  KEY schemeididx (schemeid),
  FOREIGN KEY (`schemeid`) REFERENCES `suretyscheme` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Project. (ADM)                                                            */
/*****************************************************************************/
CREATE TABLE project (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  name            text           NULL,
  projectdesc     text           NULL,
  clientdata      text           NULL,

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Researcher. (ADM)                                                         */
/*****************************************************************************/
CREATE TABLE researcher (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  name            text       NOT NULL,
  addressid       int(11)        NULL DEFAULT NULL,
  comments        text           NULL,

  PRIMARY KEY (id),
  KEY addressid (addressid),
  FOREIGN KEY (`addressid`) REFERENCES `place` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Researcher - Project. (ADM)                                               */
/*****************************************************************************/
CREATE TABLE resproj (
  idres           int(11)    NOT NULL DEFAULT '0',
  idproj          int(11)    NOT NULL DEFAULT '0',
  role            text           NULL,

  KEY idres (idres),
  KEY idproj (idproj),
  FOREIGN KEY (`idproj`) REFERENCES `project` (`id`),
  FOREIGN KEY (`idres`) REFERENCES `researcher` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Research Objective. (ADM)                                                 */
/*****************************************************************************/
CREATE TABLE resobjective (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  projid          int(11)        NULL DEFAULT '0',
  name            text           NULL,
  description     text           NULL,
  seq             int(11)        NULL DEFAULT '0',
  priority        int(11)        NULL DEFAULT '0',
  status          int(11)        NULL DEFAULT '0',

  PRIMARY KEY (id),
  KEY projid (projid),
  FOREIGN KEY (`projid`) REFERENCES `project` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Activity. (ADM)                                                           */
/*****************************************************************************/
CREATE TABLE activity (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  researcherid    int(11)    NOT NULL DEFAULT '0',
  scheddate       int(11)        NULL DEFAULT '0',
  completedate    int(11)        NULL DEFAULT '0',
  typecode        int(11)        NULL DEFAULT '0',
  status          int(11)        NULL DEFAULT '0',
  description     text           NULL,
  priority        int(11)        NULL DEFAULT '0',
  comments        text           NULL,

  PRIMARY KEY (id),

  KEY researcherid (researcherid),
  FOREIGN KEY (`researcherid`) REFERENCES `researcher` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Administrative Task. (ADM)                                                */
/*****************************************************************************/
CREATE TABLE admintask (
  activityid      int(11)    NOT NULL DEFAULT '0',

  PRIMARY KEY (activityid),
  FOREIGN KEY (`activityid`) REFERENCES `activity` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Research Objective - Activity. (ADM)                                      */
/*****************************************************************************/
CREATE TABLE resobjact (
  resobjid        int(11)    NOT NULL DEFAULT '0',
  activityid      int(11)    NOT NULL DEFAULT '0',

  KEY resobjid (resobjid),
  KEY activityid (activityid),
  FOREIGN KEY (`activityid`) REFERENCES `activity` (`id`),
  FOREIGN KEY (`resobjid`) REFERENCES `resobjective` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Repository. (EVI)                                                         */
/*****************************************************************************/
CREATE TABLE repository (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  placeid         int(11)        NULL DEFAULT '0',
  name            text           NULL,
  address         text           NULL,
  phone           text           NULL,
  hours           text           NULL,
  comments        text           NULL,

  PRIMARY KEY (id),
  KEY placeid (placeid),
  FOREIGN KEY (`placeid`) REFERENCES `place` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Source. (EVI)                                                             */
/*****************************************************************************/
CREATE TABLE source (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  highersourceid  int(11)        NULL DEFAULT '0',
  subjectplaceid  int(11)        NULL DEFAULT '0',
  jurisplaceid    int(11)        NULL DEFAULT '0',
  researcherid    int(11)        NULL DEFAULT '0',
  subjectdate     int(11)        NULL DEFAULT '0',
  medium          text           NULL,
  comments        text           NULL,

  PRIMARY KEY (id),
  KEY highersourceid (highersourceid),
  KEY subjectplaceid (subjectplaceid),
  KEY jurisplaceid (jurisplaceid),
  KEY researcherid (researcherid),
  FOREIGN KEY (`researcherid`) REFERENCES `researcher` (`id`),
  FOREIGN KEY (`highersourceid`) REFERENCES `source` (`id`),
  FOREIGN KEY (`subjectplaceid`) REFERENCES `place` (`id`),
  FOREIGN KEY (`jurisplaceid`) REFERENCES `place` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Repository - Source. (EVI)                                                */
/*****************************************************************************/
CREATE TABLE repsrc (
  repositoryid    int(11)    NOT NULL DEFAULT '0',
  sourceid        int(11)    NOT NULL DEFAULT '0',
  activityid      int(11)    NOT NULL DEFAULT '0',
  callnumber      text           NULL,
  description     text           NULL,

  KEY repositoryid (repositoryid),
  KEY sourceid (sourceid),
  KEY activityid (activityid),
  FOREIGN KEY (`activityid`) REFERENCES `activity` (`id`),
  FOREIGN KEY (`repositoryid`) REFERENCES `repository` (`id`),
  FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Citation Part Type. (EVI)                                                 */
/*****************************************************************************/
CREATE TABLE citationparttype (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  name            text,

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Citation Part. (EVI)                                                      */
/*****************************************************************************/
CREATE TABLE citationpart (
  sourceid        int(11)    NOT NULL DEFAULT '0',
  citparttypeid   int(11)    NOT NULL DEFAULT '0',
  value           text       NOT NULL,

  KEY sourceid (sourceid),
  KEY citparttypeid (citparttypeid),
  FOREIGN KEY (`citparttypeid`) REFERENCES `citationparttype` (`id`),
  FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Representation Type. (EVI)                                                */
/*****************************************************************************/
CREATE TABLE representtype (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  name            text           NULL,

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Representation. (EVI)                                                     */
/*****************************************************************************/
CREATE TABLE representation (
  sourceid        int(11)     NOT NULL DEFAULT '0',
  reptypeid       int(11)     NOT NULL DEFAULT '0',
  physfilecode    text        NOT NULL,
  medium          text        NOT NULL,
  content         longblob    NOT NULL,

  KEY sourceid (sourceid),
  KEY reptypeid (reptypeid),
  FOREIGN KEY (`reptypeid`) REFERENCES `representtype` (`id`),
  FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Search. (ADM)                                                             */
/*****************************************************************************/
CREATE TABLE search (
  activityid      int(11)    NOT NULL DEFAULT '0',
  sourceid        int(11)        NULL DEFAULT '0',
  repositoryid    int(11)        NULL DEFAULT '0',
  searchedfor     text           NULL,

  PRIMARY KEY (activityid),
  KEY activityid (activityid),
  KEY sourceid (sourceid),
  KEY repositoryid (repositoryid),
  FOREIGN KEY (`repositoryid`) REFERENCES `repository` (`id`),
  FOREIGN KEY (`activityid`) REFERENCES `activity` (`id`),
  FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Source Group. (ADM)                                                       */
/*****************************************************************************/
CREATE TABLE sourcegroup (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  name            text       NOT NULL,

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Source Group - Source. (ADM)                                              */
/*****************************************************************************/
CREATE TABLE srcgrpsrc (
  sourceid        int(11)    NOT NULL DEFAULT '0',
  sourcegroupid   int(11)    NOT NULL DEFAULT '0',

  KEY sourceid (sourceid),
  KEY sourcegroupid (sourcegroupid),
  FOREIGN KEY (`sourcegroupid`) REFERENCES `sourcegroup` (`id`),
  FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Characteristic. (CONC)                                                    */
/*****************************************************************************/
CREATE TABLE characteristic (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  placeid         int(11)    NOT NULL DEFAULT '0',
  chardate        int(11)    NOT NULL DEFAULT '0',
  porder          char(1)    NOT NULL,

  PRIMARY KEY (id),
  KEY placeid (placeid),
  FOREIGN KEY (`placeid`) REFERENCES `place` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Characteristic Part Type. (CONC)                                          */
/*****************************************************************************/
CREATE TABLE chartype (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  name            text           NULL,

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Characteristic Part. (CONC)                                               */
/*****************************************************************************/
CREATE TABLE charpart (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  charid          int(11)    NOT NULL DEFAULT '0',
  chartypeid      int(11)    NOT NULL DEFAULT '0',
  charname        text           NULL,
  cpseq           int(11)    NOT NULL DEFAULT '0',

  PRIMARY KEY (id),
  KEY charid (charid),
  KEY chartypeid (chartypeid),
  FOREIGN KEY (`charid`) REFERENCES `characteristic` (`id`),
  FOREIGN KEY (`chartypeid`) REFERENCES `chartype` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Event Type. (CONC)                                                        */
/*****************************************************************************/
CREATE TABLE eventtype (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  eventtypename   text           NULL,

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Event Type Role. (CONC)                                                   */
/*****************************************************************************/
CREATE TABLE eventtyperole (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  eventtypeid     int(11)    NOT NULL DEFAULT '0',
  role            text           NULL,

  PRIMARY KEY (id),
  KEY eventtypeid (eventtypeid),
  FOREIGN KEY (`eventtypeid`) REFERENCES `eventtype` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Event. (CONC)                                                             */
/*****************************************************************************/
CREATE TABLE event (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  eventtypeid     int(11)        NULL DEFAULT NULL,
  placeid         int(11)        NULL DEFAULT NULL,
  name            text           NULL,
  eventdate       int(11)        NULL DEFAULT NULL,

  PRIMARY KEY  (id),
  KEY eventtypeid (eventtypeid),
  KEY placeid (placeid),
  FOREIGN KEY (`placeid`) REFERENCES `place` (`id`),
  FOREIGN KEY (`eventtypeid`) REFERENCES `eventtype` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Group Type. (CONC)                                                        */
/*****************************************************************************/
CREATE TABLE grouptype (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  grouptypename   text           NULL,
  gorder          char(1)        NULL DEFAULT NULL,

  PRIMARY KEY (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Group Type Role. (CONC)                                                   */
/*****************************************************************************/
CREATE TABLE grouptyperole (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  grouptypeid     int(11)    NOT NULL DEFAULT '0',
  role            text           NULL,
  gseq            int(11)    NOT NULL DEFAULT '0',

  PRIMARY KEY (id),
  KEY grouptypeid (grouptypeid),
  FOREIGN KEY (`grouptypeid`) REFERENCES `grouptype` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Group. (CONC)                                                             */
/*****************************************************************************/
CREATE TABLE group_ (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  grouptypeid     int(11)        NULL DEFAULT NULL,
  placeid         int(11)        NULL DEFAULT NULL,
  name            text           NULL,
  criteria        text           NULL,

  PRIMARY KEY  (id),
  KEY grouptypeid (grouptypeid),
  KEY placeid (placeid),
  FOREIGN KEY (`placeid`) REFERENCES `place` (`id`),
  FOREIGN KEY (`grouptypeid`) REFERENCES `grouptype` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Persona. (CONC)                                                           */
/*****************************************************************************/
CREATE TABLE persona (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  name            text           NULL,
  comments        text           NULL,

  PRIMARY KEY  (id)

) TYPE=InnoDB;

/*****************************************************************************/
/* Assertion. (CONC)                                                         */
/*****************************************************************************/
CREATE TABLE assertion (
  id              int(11)    NOT NULL AUTO_INCREMENT,
  suretypartid    int(11)        NULL DEFAULT NULL,
  researcherid    int(11)        NULL DEFAULT NULL,
  sourceid        int(11)        NULL DEFAULT NULL,
  s1type          char(1)    NOT NULL,
  s1cid           int(11)        NULL,
  s1eid           int(11)        NULL,
  s1gid           int(11)        NULL,
  s1pid           int(11)        NULL,
  s2type          char(1)    NOT NULL,
  s2cid           int(11)        NULL,
  s2eid           int(11)        NULL,
  s2gid           int(11)        NULL,
  s2pid           int(11)        NULL,
  value_role      int(11)        NULL,
  disproved       tinyint(1) NOT NULL DEFAULT '0',
  rationale       text           NULL,

  PRIMARY KEY (id),
  KEY suretypartid (suretypartid),
  KEY researcherid (researcherid),
  KEY sourceid (sourceid),
  FOREIGN KEY (`sourceid`) REFERENCES `source` (`id`),
  FOREIGN KEY (`s1cid`) REFERENCES `characteristic` (`id`),
  FOREIGN KEY (`s1eid`) REFERENCES `event` (`id`),
  FOREIGN KEY (`s1gid`) REFERENCES `group_` (`id`),
  FOREIGN KEY (`s1pid`) REFERENCES `persona` (`id`),
  FOREIGN KEY (`s2cid`) REFERENCES `characteristic` (`id`),
  FOREIGN KEY (`s2eid`) REFERENCES `event` (`id`),
  FOREIGN KEY (`s2gid`) REFERENCES `group_` (`id`),
  FOREIGN KEY (`s2pid`) REFERENCES `persona` (`id`),
  FOREIGN KEY (`suretypartid`) REFERENCES `suretypart` (`id`),
  FOREIGN KEY (`researcherid`) REFERENCES `researcher` (`id`)

) TYPE=InnoDB;

/*****************************************************************************/
/* Assertion - Assertion. (CONC)                                             */
/*                                                                           */
/* Used to build high level assertions from low level assertions.            */
/*                                                                           */
/*****************************************************************************/
CREATE TABLE assertassert (
  idlo            int(11)    NOT NULL DEFAULT '0',
  idhi            int(11)    NOT NULL DEFAULT '0',
  seq             int(11)        NULL DEFAULT NULL,

  KEY idlo (idlo),
  KEY idhi (idhi),
  FOREIGN KEY (`idhi`) REFERENCES `assertion` (`id`),
  FOREIGN KEY (`idlo`) REFERENCES `assertion` (`id`)

) TYPE=InnoDB;









/*****************************************************************************/
/*                                                                           */
/* Create some sample data.                                                  */
/*                                                                           */
/*****************************************************************************/

/*****************************************************************************/
/* Create the Legacy Surety Scheme (and its component parts).                */
/*****************************************************************************/

INSERT INTO suretyscheme VALUES (DEFAULT, 'LSS', 'Surety scheme from Legacy 5.0');

INSERT INTO suretypart VALUES (DEFAULT, 1, '0', 'Undecided',                 0);
INSERT INTO suretypart VALUES (DEFAULT, 1, '1', 'Marginal evidence',         1);
INSERT INTO suretypart VALUES (DEFAULT, 1, '2', 'Probable conclusion',       2);
INSERT INTO suretypart VALUES (DEFAULT, 1, '3', 'Almost certain conclusion', 3);
INSERT INTO suretypart VALUES (DEFAULT, 1, '4', 'Convincing evidence',       4);

/*****************************************************************************/
/* Create my own surety scheme.                                              */
/*****************************************************************************/

INSERT INTO suretyscheme VALUES (DEFAULT, 'ARSS', 'Andrew Rose Surety Scheme');

INSERT INTO suretypart VALUES (DEFAULT, 2, 'Personally witnessed',           '', 6);
INSERT INTO suretypart VALUES (DEFAULT, 2, 'Official record from the time',  '', 5);
INSERT INTO suretypart VALUES (DEFAULT, 2, 'Official record',                '', 4);
-- What about transcripts?
INSERT INTO suretypart VALUES (DEFAULT, 2, 'Unoffical record from the time', '', 3);
INSERT INTO suretypart VALUES (DEFAULT, 2, 'Unofficial record',              '', 2);
INSERT INTO suretypart VALUES (DEFAULT, 2, 'Unsubstantiated claim',          '', 1);
INSERT INTO suretypart VALUES (DEFAULT, 2, 'Undecided',                      '', 0);







--
-- Dumping data for table `chartype`
--

INSERT INTO chartype VALUES (1,  'Occupation');
INSERT INTO chartype VALUES (2,  'Government ID Number');
INSERT INTO chartype VALUES (3,  'Mononame');
INSERT INTO chartype VALUES (4,  'Given Name');
INSERT INTO chartype VALUES (5,  'Surname');
INSERT INTO chartype VALUES (6,  'Name Prefix');
INSERT INTO chartype VALUES (7,  'Name Suffix');
INSERT INTO chartype VALUES (8,  'Title');
INSERT INTO chartype VALUES (9,  'PreSurname');
INSERT INTO chartype VALUES (10, 'Religious Name');
INSERT INTO chartype VALUES (11, 'Nickname');
INSERT INTO chartype VALUES (12, 'dit Name');
INSERT INTO chartype VALUES (13, 'Farm Name');
INSERT INTO chartype VALUES (14, 'Patrynomic');
INSERT INTO chartype VALUES (15, 'Matrynomic');
INSERT INTO chartype VALUES (16, 'Connector name');
INSERT INTO chartype VALUES (17, 'AFN');
INSERT INTO chartype VALUES (18, 'Ethnicity');
INSERT INTO chartype VALUES (19, 'Religion');
INSERT INTO chartype VALUES (20, 'Cause of Death');
INSERT INTO chartype VALUES (21, 'Number of Children');
INSERT INTO chartype VALUES (22, 'Hair Color');
INSERT INTO chartype VALUES (23, 'Eye Color');
INSERT INTO chartype VALUES (24, 'Skin Color');
INSERT INTO chartype VALUES (25, 'Physical Description');
INSERT INTO chartype VALUES (26, 'Medical Condition');
INSERT INTO chartype VALUES (27, 'Age');
INSERT INTO chartype VALUES (28, 'Nationality');
INSERT INTO chartype VALUES (29, 'Citizenship');
INSERT INTO chartype VALUES (30, 'Screen Name');
INSERT INTO chartype VALUES (31, 'Sex');
INSERT INTO chartype VALUES (32, 'Language');
INSERT INTO chartype VALUES (33, 'Literacy');
INSERT INTO chartype VALUES (34, 'RFN');
INSERT INTO chartype VALUES (35, 'RIN');
INSERT INTO chartype VALUES (36, 'SSN');
INSERT INTO chartype VALUES (37, 'Personality');
INSERT INTO chartype VALUES (38, 'Attributes');
INSERT INTO chartype VALUES (39, 'Living');
INSERT INTO chartype VALUES (40, 'Number of Marriages');
INSERT INTO chartype VALUES (41, 'Marital Status');
INSERT INTO chartype VALUES (42, 'Address');
INSERT INTO chartype VALUES (43, 'Telephone');
INSERT INTO chartype VALUES (44, 'email');

--
-- Dumping data for table `eventrole`
--

INSERT INTO eventtyperole VALUES (1,1,'E','Infant',0);
INSERT INTO eventtyperole VALUES (2,1,'E','Mother',1);
INSERT INTO eventtyperole VALUES (3,1,'E','Father',2);
INSERT INTO eventtyperole VALUES (4,1,'E','Midwife',3);
INSERT INTO eventtyperole VALUES (5,1,'E','Doctor',3);
INSERT INTO eventtyperole VALUES (6,1,'E','Clergy',3);
INSERT INTO eventtyperole VALUES (7,3,'E','Groom',0);
INSERT INTO eventtyperole VALUES (8,3,'E','Bride',1);
INSERT INTO eventtyperole VALUES (9,3,'E','Father of Groom',2);
INSERT INTO eventtyperole VALUES (10,3,'E','Mother of Groom',3);
INSERT INTO eventtyperole VALUES (11,3,'E','Father of Bride',4);
INSERT INTO eventtyperole VALUES (12,3,'E','Mother of Bride',5);
INSERT INTO eventtyperole VALUES (13,3,'E','Best Man',5);
INSERT INTO eventtyperole VALUES (14,3,'E','Bridesmaid',6);
INSERT INTO eventtyperole VALUES (15,3,'E','Clergy',7);
INSERT INTO eventtyperole VALUES (16,3,'E','Officiate',8);
INSERT INTO eventtyperole VALUES (17,3,'E','Witness',9);
INSERT INTO eventtyperole VALUES (18,4,'E','Deceased',0);
INSERT INTO eventtyperole VALUES (19,4,'E','Widow',1);
INSERT INTO eventtyperole VALUES (20,4,'E','Widower',1);
INSERT INTO eventtyperole VALUES (21,4,'E','Child of Deceased',2);
INSERT INTO eventtyperole VALUES (22,4,'E','Son of Deceased',2);
INSERT INTO eventtyperole VALUES (23,4,'E','Daughter of Deceased',2);
INSERT INTO eventtyperole VALUES (24,4,'E','Doctor',3);
INSERT INTO eventtyperole VALUES (25,4,'E','Clergy',4);
INSERT INTO eventtyperole VALUES (26,4,'E','Witness',5);
INSERT INTO eventtyperole VALUES (27,2,'G','SamePerson',1);

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

