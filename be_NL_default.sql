# Be account plan for frontaccounting 2.3.24'
# Create Date and Time: 20161217
# Built by SanRemo NG bvba
# http://www.srng.be
# Company: SanRemoNextGeneration
# User: cita mgt


### Structure of table `0_areas` ###

DROP TABLE IF EXISTS `0_areas`;

CREATE TABLE `0_areas` (
  `area_code` int(11) NOT NULL auto_increment,
  `description` varchar(60) NOT NULL default '',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`area_code`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM;

### Data of table `0_areas` ###

INSERT INTO `0_areas` VALUES
('1', 'Belgie', '0'),
('2', 'Binnen EU', '0'),
('3', 'Buiten EU', '0');


### Structure of table `0_attachments` ###

DROP TABLE IF EXISTS `0_attachments`;

CREATE TABLE `0_attachments` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `description` varchar(60) NOT NULL default '',
  `type_no` int(11) NOT NULL default '0',
  `trans_no` int(11) NOT NULL default '0',
  `unique_name` varchar(60) NOT NULL default '',
  `tran_date` date NOT NULL default '0000-00-00',
  `filename` varchar(60) NOT NULL default '',
  `filesize` int(11) NOT NULL default '0',
  `filetype` varchar(60) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `type_no` (`type_no`,`trans_no`)
) ENGINE=MyISAM;

### Data of table `0_attachments` ###


### Structure of table `0_audit_trail` ###

DROP TABLE IF EXISTS `0_audit_trail`;

CREATE TABLE `0_audit_trail` (
  `id` int(11) NOT NULL auto_increment,
  `type` smallint(6) unsigned NOT NULL default '0',
  `trans_no` int(11) unsigned NOT NULL default '0',
  `user` smallint(6) unsigned NOT NULL default '0',
  `stamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `description` varchar(60) default NULL,
  `fiscal_year` int(11) NOT NULL,
  `gl_date` date NOT NULL default '0000-00-00',
  `gl_seq` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `Seq` (`fiscal_year`,`gl_date`,`gl_seq`),
  KEY `Type_and_Number` (`type`,`trans_no`)
) ENGINE=InnoDB;

### Data of table `0_audit_trail` ###


### Structure of table `0_bank_accounts` ###

DROP TABLE IF EXISTS `0_bank_accounts`;

CREATE TABLE `0_bank_accounts` (
  `account_code` varchar(15) NOT NULL default '',
  `account_type` smallint(6) NOT NULL default '0',
  `bank_account_name` varchar(60) NOT NULL default '',
  `bank_account_number` varchar(100) NOT NULL default '',
  `bank_name` varchar(60) NOT NULL default '',
  `bank_address` tinytext,
  `bank_curr_code` char(3) NOT NULL default '',
  `dflt_curr_act` tinyint(1) NOT NULL default '0',
  `id` smallint(6) NOT NULL auto_increment,
  `last_reconciled_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `ending_reconcile_balance` double NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `bank_account_name` (`bank_account_name`),
  KEY `bank_account_number` (`bank_account_number`),
  KEY `account_code` (`account_code`)
) ENGINE=MyISAM;

### Data of table `0_bank_accounts` ###

INSERT INTO `0_bank_accounts` VALUES
('550001', '2', 'XYZ Bank zichtrekening', '12345678', 'XYZ Bank', 'Adres XYZ bank 1\n1234 GEMEENTE', 'EUR', '1', '1', '0000-00-00 00:00:00', '0', '0'),
('570000', '3', 'Kas', 'N/A', 'N/A', 'N/A', 'EUR', '0', '2', '0000-00-00 00:00:00', '0', '0'),
('550002', '0', 'XYZ Bank spaarrekening', '12345678', 'XYZ Bank', 'Adres XYZ bank 1 \n1234 GEMEENTE', 'EUR', '0', '4', '0000-00-00 00:00:00', '0', '0');

### Structure of table `0_bank_trans` ###

DROP TABLE IF EXISTS `0_bank_trans`;

CREATE TABLE `0_bank_trans` (
  `id` int(11) NOT NULL auto_increment,
  `type` smallint(6) default NULL,
  `trans_no` int(11) default NULL,
  `bank_act` varchar(15) NOT NULL default '',
  `ref` varchar(40) default NULL,
  `trans_date` date NOT NULL default '0000-00-00',
  `bank_trans_type_id` int(10) unsigned default NULL,
  `amount` double default NULL,
  `dimension_id` int(11) NOT NULL default '0',
  `dimension2_id` int(11) NOT NULL default '0',
  `person_type_id` int(11) NOT NULL default '0',
  `person_id` tinyblob,
  `reconciled` date default NULL,
  PRIMARY KEY  (`id`),
  KEY `bank_act` (`bank_act`,`ref`),
  KEY `type` (`type`,`trans_no`),
  KEY `bank_act_2` (`bank_act`,`reconciled`),
  KEY `bank_act_3` (`bank_act`,`trans_date`)
) ENGINE=InnoDB ;

### Data of table `0_bank_trans` ###


### Structure of table `0_bom` ###

DROP TABLE IF EXISTS `0_bom`;

CREATE TABLE `0_bom` (
  `id` int(11) NOT NULL auto_increment,
  `parent` char(20) NOT NULL default '',
  `component` char(20) NOT NULL default '',
  `workcentre_added` int(11) NOT NULL default '0',
  `loc_code` char(5) NOT NULL default '',
  `quantity` double NOT NULL default '1',
  PRIMARY KEY  (`parent`,`component`,`workcentre_added`,`loc_code`),
  KEY `component` (`component`),
  KEY `id` (`id`),
  KEY `loc_code` (`loc_code`),
  KEY `parent` (`parent`,`loc_code`),
  KEY `workcentre_added` (`workcentre_added`)
) ENGINE=MyISAM ;

### Data of table `0_bom` ###


### Structure of table `0_budget_trans` ###

DROP TABLE IF EXISTS `0_budget_trans`;

CREATE TABLE `0_budget_trans` (
  `counter` int(11) NOT NULL auto_increment,
  `type` smallint(6) NOT NULL default '0',
  `type_no` bigint(16) NOT NULL default '1',
  `tran_date` date NOT NULL default '0000-00-00',
  `account` varchar(15) NOT NULL default '',
  `memo_` tinytext NOT NULL,
  `amount` double NOT NULL default '0',
  `dimension_id` int(11) default '0',
  `dimension2_id` int(11) default '0',
  `person_type_id` int(11) default NULL,
  `person_id` tinyblob,
  PRIMARY KEY  (`counter`),
  KEY `Type_and_Number` (`type`,`type_no`),
  KEY `Account` (`account`,`tran_date`,`dimension_id`,`dimension2_id`)
) ENGINE=InnoDB ;

### Data of table `0_budget_trans` ###


### Structure of table `0_chart_class` ###

DROP TABLE IF EXISTS `0_chart_class`;

CREATE TABLE `0_chart_class` (
  `cid` varchar(3) NOT NULL,
  `class_name` varchar(60) NOT NULL default '',
  `ctype` tinyint(1) NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`cid`)
) ENGINE=MyISAM ;

### Data of table `0_chart_class` ###

INSERT INTO `0_chart_class` VALUES ('1', '1 Eigen Vermogen', '3', '0');
INSERT INTO `0_chart_class` VALUES ('2', '2 Vaste Activa en vorderingen op meerd dan een jaar', '1', '0');
INSERT INTO `0_chart_class` VALUES ('3', '3 Voorraden en bestellingen in uitvoering', '1', '0');
INSERT INTO `0_chart_class` VALUES ('40', '4 Vorderingen op ten hoogste een jaar', '1', '0');
INSERT INTO `0_chart_class` VALUES ('41', '4 Vorderingen op ten hoogste een jaar', '1', '0');
INSERT INTO `0_chart_class` VALUES ('42', '4 Vorderingen op ten hoogste een jaar', '1', '0');
INSERT INTO `0_chart_class` VALUES ('43', '4 Vorderingen op ten hoogste een jaar', '1', '0');
INSERT INTO `0_chart_class` VALUES ('44', '4 Vorderingen op ten hoogste een jaar', '1', '0');
INSERT INTO `0_chart_class` VALUES ('490', '4 Vorderingen op ten hoogste een jaar', '1', '0');
INSERT INTO `0_chart_class` VALUES ('491', '4 Vorderingen op ten hoogste een jaar', '1', '0');
INSERT INTO `0_chart_class` VALUES ('44', '4 Schulden op ten hoogste een jaar', '2', '0');
INSERT INTO `0_chart_class` VALUES ('45', '4 Schulden op ten hoogste een jaar', '2', '0');
INSERT INTO `0_chart_class` VALUES ('46', '4 Schulden op ten hoogste een jaar', '2', '0');
INSERT INTO `0_chart_class` VALUES ('47', '4 Schulden op ten hoogste een jaar', '2', '0');
INSERT INTO `0_chart_class` VALUES ('48', '4 Schulden op ten hoogste een jaar', '2', '0');
INSERT INTO `0_chart_class` VALUES ('4', '4 Schulden op ten hoogste een jaar', '2', '0');
INSERT INTO `0_chart_class` VALUES ('492', '4 Schulden op ten hoogste een jaar', '2', '0');
INSERT INTO `0_chart_class` VALUES ('493', '4 Schulden op ten hoogste een jaar', '2', '0');
INSERT INTO `0_chart_class` VALUES ('5', '5 Geldbeleggingen en liquide', '1', '0');
INSERT INTO `0_chart_class` VALUES ('6', '6 Kosten', '6', '0');
INSERT INTO `0_chart_class` VALUES ('7', '7 Opbrengsten', '4', '0');
INSERT INTO `0_chart_class` VALUES ('0', '0 Niet in de balans opgenomen rechten en verplichtingen', '1', '0');

### Structure of table `0_chart_master` ###

DROP TABLE IF EXISTS `0_chart_master`;

CREATE TABLE `0_chart_master` (
  `account_code` varchar(15) NOT NULL default '',
  `account_code2` varchar(15) NOT NULL default '',
  `account_name` varchar(60) NOT NULL default '',
  `account_type` varchar(10) NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`account_code`),
  KEY `account_name` (`account_name`),
  KEY `accounts_by_type` (`account_type`,`account_code`)
) ENGINE=MyISAM ;

### Data of table `0_chart_master` ###

INSERT INTO `0_chart_master` VALUES ('100000', '', 'Geplaatst kapitaal', '10', '0');
INSERT INTO `0_chart_master` VALUES ('101000', '', 'Niet opgevraagd kapitaal (-)', '101', '0');
INSERT INTO `0_chart_master` VALUES ('109000', '', 'Rekeningen van de uitbater', '10', '0');
INSERT INTO `0_chart_master` VALUES ('110000', '', 'Uitgiftepremies', '11', '0');
INSERT INTO `0_chart_master` VALUES ('120000', '', 'Herwaarderingsmeerwaarde immateriele vaste activa', '120', '0');
INSERT INTO `0_chart_master` VALUES ('121000', '', 'Herwaarderingsmeerwaarde materiele vaste activa', '121', '0');
INSERT INTO `0_chart_master` VALUES ('122000', '', 'Herwaarderingsmeerwaarde financiele vaste activa', '122', '0');
INSERT INTO `0_chart_master` VALUES ('123000', '', 'Herwaarderingsmeerwaarde voorraden', '123', '0');
INSERT INTO `0_chart_master` VALUES ('124000', '', 'Terugneming waardeverminderingen op geldbelegging', '124', '0');
INSERT INTO `0_chart_master` VALUES ('130000', '', 'Wettelijke reserve', '130', '0');
INSERT INTO `0_chart_master` VALUES ('131000', '', 'Onbeschikbare reserves voor eigen aandelen', '131', '0');
INSERT INTO `0_chart_master` VALUES ('131100', '', 'Andere onbeschikbare reserves', '1311', '0');
INSERT INTO `0_chart_master` VALUES ('132000', '', 'Belastingvrije reserves', '132', '0');
INSERT INTO `0_chart_master` VALUES ('133000', '', 'Beschikbare reserves', '133', '0');
INSERT INTO `0_chart_master` VALUES ('140000', '', 'Overgedragen winst', '14', '0');
INSERT INTO `0_chart_master` VALUES ('141000', '', 'Overgedragen verlies (-)', '14', '0');
INSERT INTO `0_chart_master` VALUES ('148', '', 'Openingsrekening algemeen', '148', '0');
INSERT INTO `0_chart_master` VALUES ('148000', '', 'Openingsrekening algemeen', '148', '0');
INSERT INTO `0_chart_master` VALUES ('150000', '', 'Kapitaalsubsidies', '15', '0');
INSERT INTO `0_chart_master` VALUES ('151000', '', 'In resultaat opgenomen subsidies (-)', '15', '0');
INSERT INTO `0_chart_master` VALUES ('160000', '', 'Voorziening voor pensioenen en soortgelijke verpl.', '16', '0');
INSERT INTO `0_chart_master` VALUES ('161000', '', 'Voorzieningen voor belastingen', '161', '0');
INSERT INTO `0_chart_master` VALUES ('162000', '', 'Voorziening voor grote herstelling en onderhoud', '162', '0');
INSERT INTO `0_chart_master` VALUES ('163000', '', 'Voorziening voor milieuverplichtingen', '163', '0');
INSERT INTO `0_chart_master` VALUES ('164000', '', 'Voorziening voor overige risicos en kosten', '164', '0');
INSERT INTO `0_chart_master` VALUES ('1680', '', 'Uitgestelde belastingen op kapitaalsubsidies', '1680', '0');
INSERT INTO `0_chart_master` VALUES ('168000', '', 'Uitgestelde belastingen op kapitaalsubsidies', '1680', '0');
INSERT INTO `0_chart_master` VALUES ('1681', '', 'Uitgest. belast. gereal. meerw. immat. vaste act.', '1681', '0');
INSERT INTO `0_chart_master` VALUES ('168100', '', 'Uitgestelde belastingen op gereal. meerwaarde IVA', '1681', '0');
INSERT INTO `0_chart_master` VALUES ('1682', '', 'Uitgest. belast. gereal. meerw. mat. vaste act.', '1682', '0');
INSERT INTO `0_chart_master` VALUES ('168200', '', 'Uitgestelde belastingen op gereal. meerwaarde MVA', '1682', '0');
INSERT INTO `0_chart_master` VALUES ('168700', '', 'Uitgestelde belastingen op gereal. meerwaarde eff.', '1687', '0');
INSERT INTO `0_chart_master` VALUES ('168800', '', 'Buitenlandse uitgestelde belastingen', '1688', '0');
INSERT INTO `0_chart_master` VALUES ('170000', '', 'Converteerbare achtergestelde leningen', '1700', '0');
INSERT INTO `0_chart_master` VALUES ('170100', '', 'Niet-converteerbare achtergestelde leningen', '1701', '0');
INSERT INTO `0_chart_master` VALUES ('171000', '', 'Converteerbare niet-achtergestelde oblig.leningen', '1710', '0');
INSERT INTO `0_chart_master` VALUES ('171100', '', 'Niet-converteerb. niet-achtergestelde oblig.lening', '1711', '0');
INSERT INTO `0_chart_master` VALUES ('172000', '', 'Leasingschulden en soortgelijke schulden', '172', '0');
INSERT INTO `0_chart_master` VALUES ('173000', '', 'Schulden op rekening', '173', '0');
INSERT INTO `0_chart_master` VALUES ('173100', '', 'Promessen', '1731', '0');
INSERT INTO `0_chart_master` VALUES ('173200', '', 'Acceptkredieten', '1732', '0');
INSERT INTO `0_chart_master` VALUES ('174000', '', 'Overige leningen', '174', '0');
INSERT INTO `0_chart_master` VALUES ('175000', '', 'Handelsschulden: leveranciers', '175', '0');
INSERT INTO `0_chart_master` VALUES ('175100', '', 'Handelsschulden: te betalen wissels', '1751', '0');
INSERT INTO `0_chart_master` VALUES ('176000', '', 'Ontvangen vooruitbetalingen op bestellingen', '176', '0');
INSERT INTO `0_chart_master` VALUES ('178000', '', 'Borgtochten ontvangen in contanten', '178', '0');
INSERT INTO `0_chart_master` VALUES ('179000', '', 'Permanente voorschotten bestuurders', '179', '0');
INSERT INTO `0_chart_master` VALUES ('179100', '', 'Permanente voorschotten aandeelhouders', '179', '0');
INSERT INTO `0_chart_master` VALUES ('179200', '', 'Boekhoudkundig verwerkte lijfrente', '179', '0');
INSERT INTO `0_chart_master` VALUES ('190000', '', 'Voorschot op de verdeling van het netto-actief', '19', '0');
INSERT INTO `0_chart_master` VALUES ('200000', '', 'Kosten van oprichting en kapitaalsverhoging', '20', '0');
INSERT INTO `0_chart_master` VALUES ('200009', '', 'Geboekte afschr. oprichtingskosten en kapitaalverh', '200', '0');
INSERT INTO `0_chart_master` VALUES ('201000', '', 'Kosten bij uitgifte van leningen en disagio', '201', '0');
INSERT INTO `0_chart_master` VALUES ('201009', '', 'Geboekte afschr. kosten bij uitgifte van leningen', '201', '0');
INSERT INTO `0_chart_master` VALUES ('202000', '', 'Overige oprichtingskosten', '202', '0');
INSERT INTO `0_chart_master` VALUES ('202009', '', 'Geboekte afschr. overige oprichtingskosten', '202', '0');
INSERT INTO `0_chart_master` VALUES ('204000', '', 'Herstructureringskosten', '204', '0');
INSERT INTO `0_chart_master` VALUES ('204009', '', 'Geboekte afschr. herstructureringskosten', '204', '0');
INSERT INTO `0_chart_master` VALUES ('210000', '', 'Kosten van onderzoek en ontwikkeling', '21', '0');
INSERT INTO `0_chart_master` VALUES ('210009', '', 'Geboekte afschr. kosten onderzoek en ontwikkeling', '210', '0');
INSERT INTO `0_chart_master` VALUES ('211000', '', 'Concessie, octrooien, licenties, know-how, merken', '211', '0');
INSERT INTO `0_chart_master` VALUES ('211009', '', 'Geboekte afschr. concessies, octrooien, licenties', '211', '0');
INSERT INTO `0_chart_master` VALUES ('212000', '', 'Goodwill', '212', '0');
INSERT INTO `0_chart_master` VALUES ('212009', '', 'Geboekte afschr. goodwill', '212', '0');
INSERT INTO `0_chart_master` VALUES ('213000', '', 'Vooruitbetalingen', '213', '0');
INSERT INTO `0_chart_master` VALUES ('213009', '', 'Geboekte afschr. vooruitbetalingen', '213', '0');
INSERT INTO `0_chart_master` VALUES ('220000', '', 'Terreinen', '22', '0');
INSERT INTO `0_chart_master` VALUES ('220008', '', 'Geboekte MW terreinen', '220', '0');
INSERT INTO `0_chart_master` VALUES ('220009', '', 'Geboekte afschr. terreinen', '220', '0');
INSERT INTO `0_chart_master` VALUES ('221000', '', 'Gebouwen', '221', '0');
INSERT INTO `0_chart_master` VALUES ('221008', '', 'Geboekte MW gebouwen', '221', '0');
INSERT INTO `0_chart_master` VALUES ('221009', '', 'Geboekte afschr. gebouwen', '221', '0');
INSERT INTO `0_chart_master` VALUES ('222000', '', 'Bebouwde terreinen', '222', '0');
INSERT INTO `0_chart_master` VALUES ('222008', '', 'Geboekte MW bebouwde terreinen', '222', '0');
INSERT INTO `0_chart_master` VALUES ('222009', '', 'Geboekte afschr. bebouwde terreinen', '222', '0');
INSERT INTO `0_chart_master` VALUES ('223000', '', 'Overige zakelijke rechten op onroerende goederen', '223', '0');
INSERT INTO `0_chart_master` VALUES ('223008', '', 'Geboekte MW overige zakelijke rechten op onr. goed', '223', '0');
INSERT INTO `0_chart_master` VALUES ('223009', '', 'Geboekte afschr. overige zakelijke rechten op OG', '223', '0');
INSERT INTO `0_chart_master` VALUES ('230000', '', 'Technische installaties', '23', '0');
INSERT INTO `0_chart_master` VALUES ('230008', '', 'Geboekte MW technische installaties', '23', '0');
INSERT INTO `0_chart_master` VALUES ('230009', '', 'Geboekte afschr. technische installaties', '23', '0');
INSERT INTO `0_chart_master` VALUES ('230100', '', 'Machines', '23', '0');
INSERT INTO `0_chart_master` VALUES ('230108', '', 'Geboekte MW machines', '23', '0');
INSERT INTO `0_chart_master` VALUES ('230109', '', 'Geboekte afschr. machines', '23', '0');
INSERT INTO `0_chart_master` VALUES ('231000', '', 'Andere installaties', '23', '0');
INSERT INTO `0_chart_master` VALUES ('231008', '', 'Geboekte MW andere installaties', '23', '0');
INSERT INTO `0_chart_master` VALUES ('231009', '', 'Geboekte afschr. andere installaties', '23', '0');
INSERT INTO `0_chart_master` VALUES ('232000', '', 'Uitrusting', '23', '0');
INSERT INTO `0_chart_master` VALUES ('232008', '', 'Geboekte MW uitrusting', '23', '0');
INSERT INTO `0_chart_master` VALUES ('232009', '', 'Geboekte afschr. uitrusting', '23', '0');
INSERT INTO `0_chart_master` VALUES ('240000', '', 'Meubilair en materieel', '24', '0');
INSERT INTO `0_chart_master` VALUES ('240008', '', 'Geboekte MW meubilair en materieel', '24', '0');
INSERT INTO `0_chart_master` VALUES ('240009', '', 'Geboekte afschr. meubilair en materieel', '24', '0');
INSERT INTO `0_chart_master` VALUES ('241000', '', 'Personenwagens', '24', '0');
INSERT INTO `0_chart_master` VALUES ('241008', '', 'Geboekte MW personenwagens', '24', '0');
INSERT INTO `0_chart_master` VALUES ('241009', '', 'Geboekte afschr. personenwagens', '24', '0');
INSERT INTO `0_chart_master` VALUES ('241100', '', 'Bedrijfswagens', '24', '0');
INSERT INTO `0_chart_master` VALUES ('241108', '', 'Geboekte MW bedrijfswagens', '24', '0');
INSERT INTO `0_chart_master` VALUES ('241109', '', 'Geboekte afschr. bedrijfswagens', '24', '0');
INSERT INTO `0_chart_master` VALUES ('250000', '', 'Terreinen en gebouwen in leasing', '250', '0');
INSERT INTO `0_chart_master` VALUES ('250008', '', 'Geboekte MW terreinen en gebouwen in leasing', '250', '0');
INSERT INTO `0_chart_master` VALUES ('250009', '', 'Geboekte afschr. terreinen en gebouwen in leasing', '250', '0');
INSERT INTO `0_chart_master` VALUES ('251000', '', 'Installaties, machines en uitrusting in leasing', '251', '0');
INSERT INTO `0_chart_master` VALUES ('251008', '', 'Geboekte MW inst., mach. en uitrusting in leasing', '251', '0');
INSERT INTO `0_chart_master` VALUES ('251009', '', 'Geboekte afschr. inst., mach. en uitr. in leasing', '251', '0');
INSERT INTO `0_chart_master` VALUES ('252000', '', 'Meubilair in leasing', '252', '0');
INSERT INTO `0_chart_master` VALUES ('252008', '', 'Geboekte MW meubilair in leasing', '252', '0');
INSERT INTO `0_chart_master` VALUES ('252009', '', 'Geboekte afschr. meubilair in leasing', '252', '0');
INSERT INTO `0_chart_master` VALUES ('252010', '', 'Rollend materieel in leasing - personenwagens', '252', '0');
INSERT INTO `0_chart_master` VALUES ('252018', '', 'Geboekte MW roll. mat. in leasing - personenwagens', '252', '0');
INSERT INTO `0_chart_master` VALUES ('252019', '', 'Geboekte afschr. rol. mat. in leasing - personenw.', '252', '0');
INSERT INTO `0_chart_master` VALUES ('252020', '', 'Rollend materieel in leasing - bedrijfswagens', '252', '0');
INSERT INTO `0_chart_master` VALUES ('252028', '', 'Geboekte MW roll. mat. in leasing - bedrijfswagens', '252', '0');
INSERT INTO `0_chart_master` VALUES ('252029', '', 'Geboekte afschr. rol. mat. in leasing - bedrijfsw.', '252', '0');
INSERT INTO `0_chart_master` VALUES ('260000', '', 'Overige materiele vaste activa', '26', '0');
INSERT INTO `0_chart_master` VALUES ('260008', '', 'Geboekte MW overige materiele vaste activa', '26', '0');
INSERT INTO `0_chart_master` VALUES ('260009', '', 'Geboekte afschr. overige materiele vaste activa', '26', '0');
INSERT INTO `0_chart_master` VALUES ('270000', '', 'Vaste activa in aanbouw', '27', '0');
INSERT INTO `0_chart_master` VALUES ('270008', '', 'Geboekte MW vaste activa in aanbouw', '27', '0');
INSERT INTO `0_chart_master` VALUES ('270009', '', 'Geboekte afschr. vaste activa in aanbouw', '27', '0');
INSERT INTO `0_chart_master` VALUES ('271000', '', 'Vooruitbetaling vaste activa in aanbouw', '27', '0');
INSERT INTO `0_chart_master` VALUES ('271008', '', 'Geboekte MW vooruitbetal. vaste activa in aanbouw', '27', '0');
INSERT INTO `0_chart_master` VALUES ('271009', '', 'Geboekte afschr. vooruitbet. vaste activa in aanb.', '27', '0');
INSERT INTO `0_chart_master` VALUES ('280000', '', 'Deelnemingen in verbonden ondernemingen', '2800', '0');
INSERT INTO `0_chart_master` VALUES ('280100', '', 'Nog te storten bedragen (-)', '2801', '0');
INSERT INTO `0_chart_master` VALUES ('281000', '', 'Vorderingen op verbonden ondernemingen', '2810', '0');
INSERT INTO `0_chart_master` VALUES ('281100', '', 'Te innen wissels', '2811', '0');
INSERT INTO `0_chart_master` VALUES ('281200', '', 'Vastrentende effecten', '2812', '0');
INSERT INTO `0_chart_master` VALUES ('281700', '', 'Dubieuze debiteuren', '2817', '0');
INSERT INTO `0_chart_master` VALUES ('282000', '', 'Deelneming in onderneming met deelnemingsverhoud.', '2820', '0');
INSERT INTO `0_chart_master` VALUES ('282100', '', 'Nog te storten bedragen (-)', '2821', '0');
INSERT INTO `0_chart_master` VALUES ('283000', '', 'Vorderingen op rekening', '2830', '0');
INSERT INTO `0_chart_master` VALUES ('283100', '', 'Te innen wissels', '2831', '0');
INSERT INTO `0_chart_master` VALUES ('283200', '', 'Vastrentende effecten', '2832', '0');
INSERT INTO `0_chart_master` VALUES ('283700', '', 'Dubieuze debiteuren', '2837', '0');
INSERT INTO `0_chart_master` VALUES ('284000', '', 'Andere aandelen', '2840', '0');
INSERT INTO `0_chart_master` VALUES ('284100', '', 'Nog te storten bedragen (-)', '2841', '0');
INSERT INTO `0_chart_master` VALUES ('285000', '', 'Vorderingen op rekening', '2850', '0');
INSERT INTO `0_chart_master` VALUES ('285100', '', 'Te innen wissels', '2851', '0');
INSERT INTO `0_chart_master` VALUES ('285200', '', 'Vastrentende effecten', '2852', '0');
INSERT INTO `0_chart_master` VALUES ('285700', '', 'Dubieuze debiteuren', '2857', '0');
INSERT INTO `0_chart_master` VALUES ('288000', '', 'Borgtochten betaald in contanten', '288', '0');
INSERT INTO `0_chart_master` VALUES ('290000', '', 'Handelsdebiteuren', '2900', '0');
INSERT INTO `0_chart_master` VALUES ('290100', '', 'Te innen wissels', '2901', '0');
INSERT INTO `0_chart_master` VALUES ('290600', '', 'Vooruitbetalingen', '2906', '0');
INSERT INTO `0_chart_master` VALUES ('290700', '', 'Dubieuze debiteuren', '2907', '0');
INSERT INTO `0_chart_master` VALUES ('291000', '', 'Vorderingen op rekening', '2910', '0');
INSERT INTO `0_chart_master` VALUES ('291100', '', 'Te innen wissels', '2911', '0');
INSERT INTO `0_chart_master` VALUES ('291700', '', 'Dubieuze debiteuren', '2917', '0');
INSERT INTO `0_chart_master` VALUES ('300000', '', 'Grondstoffen', '300', '0');
INSERT INTO `0_chart_master` VALUES ('310000', '', 'Hulpstoffen', '310', '0');
INSERT INTO `0_chart_master` VALUES ('320000', '', 'Goederen in bewerking', '320', '0');
INSERT INTO `0_chart_master` VALUES ('330000', '', 'Gereed product', '330', '0');
INSERT INTO `0_chart_master` VALUES ('340000', '', 'Handelsgoederen', '340', '0');
INSERT INTO `0_chart_master` VALUES ('350000', '', 'Onroerende goederen bestemd voor verkoop', '350', '0');
INSERT INTO `0_chart_master` VALUES ('360000', '', 'Vooruitbetalingen op voorraadinkopen', '360', '0');
INSERT INTO `0_chart_master` VALUES ('370000', '', 'Bestellingen in uitvoering', '370', '0');
INSERT INTO `0_chart_master` VALUES ('371000', '', 'Toegerekende winst', '371', '0');
INSERT INTO `0_chart_master` VALUES ('400000', '', 'Klanten', '400', '0');
INSERT INTO `0_chart_master` VALUES ('401000', '', 'Te innen wissels', '401', '0');
INSERT INTO `0_chart_master` VALUES ('404000', '', 'Te innen opbrengsten', '404', '0');
INSERT INTO `0_chart_master` VALUES ('405', '', 'Hangende domiciliëringsopdrachten', '40', '0');
INSERT INTO `0_chart_master` VALUES ('406000', '', 'Vooruitbetalingen', '406', '0');
INSERT INTO `0_chart_master` VALUES ('407000', '', 'Dubieuze debiteuren', '407', '0');
INSERT INTO `0_chart_master` VALUES ('408000', '', 'Openingsrekening klanten', '408', '0');
INSERT INTO `0_chart_master` VALUES ('409000', '', 'Geboekte waardeverminderingen (-)', '409', '0');
INSERT INTO `0_chart_master` VALUES ('410000', '', 'Opgevraagd, niet gestort kapitaal', '410', '0');
INSERT INTO `0_chart_master` VALUES ('411000', '', 'R/C BTW', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411010', '', 'Teruggevraagde BTW', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411059', '', 'Terug te vorderen BTW - vak 59', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411062', '', 'Terug te vorderen BTW (MC,IC,VL) - vak 62', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411064', '', 'Terug te vorderen BTW - vak 64', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411600', '', 'Btw (Belasting Bij Oorsprong)', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411810', '', 'Aftrekbare BTW - Terug te krijgen', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411820', '', 'Aftrekbare BTW - Herziening aftrek', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411830', '', 'Aftrekbare BTW - Regul. admin. beslissing', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411862', '', 'Aftrekbare BTW (bank, invoer en andere)', '411', '0');
INSERT INTO `0_chart_master` VALUES ('411900', '', 'Betaalde voorschotten BTW', '411', '0');
INSERT INTO `0_chart_master` VALUES ('412000', '', 'Terug te vorderen belastingen en voorheffingen', '412', '0');
INSERT INTO `0_chart_master` VALUES ('412100', '', 'Terug te vorderen Belgische winstbelastingen', '412', '0');
INSERT INTO `0_chart_master` VALUES ('412500', '', 'Terug te vorderen andere Belgische belastingen', '412', '0');
INSERT INTO `0_chart_master` VALUES ('412800', '', 'Terug te vorderen buitenlandse belastingen', '4128', '0');
INSERT INTO `0_chart_master` VALUES ('414000', '', 'Te innen opbrengsten', '414', '0');
INSERT INTO `0_chart_master` VALUES ('416000', '', 'Diverse vorderingen', '416', '0');
INSERT INTO `0_chart_master` VALUES ('417000', '', 'Dubieuze debiteuren', '417', '0');
INSERT INTO `0_chart_master` VALUES ('418000', '', 'Borgtochten betaald in contanten', '418', '0');
INSERT INTO `0_chart_master` VALUES ('419000', '', 'Geboekte waardeverminderingen (-)', '419', '0');
INSERT INTO `0_chart_master` VALUES ('420000', '', 'Converteerbare achtergestelde leningen', '4200', '0');
INSERT INTO `0_chart_master` VALUES ('430000', '', 'Kredietinstel.: leningen op rekening vaste termijn', '430', '0');
INSERT INTO `0_chart_master` VALUES ('431000', '', 'Kredietinstel.: promessen', '431', '0');
INSERT INTO `0_chart_master` VALUES ('432000', '', 'Kredietinstel.: acceptkredieten', '432', '0');
INSERT INTO `0_chart_master` VALUES ('433000', '', 'Kredietinstel.: schulden in rekening courant', '433', '0');
INSERT INTO `0_chart_master` VALUES ('439000', '', 'Overige leningen', '439', '0');
INSERT INTO `0_chart_master` VALUES ('440000', '', 'Leveranciers', '440', '0');
INSERT INTO `0_chart_master` VALUES ('441000', '', 'Te betalen wissels', '441', '0');
INSERT INTO `0_chart_master` VALUES ('444000', '', 'Te ontvangen facturen', '444', '0');
INSERT INTO `0_chart_master` VALUES ('448000', '', 'Openingsrekening leveranciers', '448', '0');
INSERT INTO `0_chart_master` VALUES ('450000', '', 'Geraamd bedrag belastingsschulden', '4500', '0');
INSERT INTO `0_chart_master` VALUES ('450500', '', 'Geraamd bedrag Belgische winstbelasting en taks', '4505', '0');
INSERT INTO `0_chart_master` VALUES ('450800', '', 'Geraamd bedrag buitenlandse winstbelasting en taks', '4508', '0');
INSERT INTO `0_chart_master` VALUES ('451000', '', 'R/C BTW', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451010', '', 'R/C BTW Transfert', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451054', '', 'BTW - Verschuldigd - Vak 54', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451055', '', 'BTW - Verschuldigd Intracom. - Vak 55', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451056', '', 'BTW - Verschuldigd medecontractant - Vak 56', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451057', '', 'BTW - Verschuldigd Verlegging - Vak 57', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451063', '', 'BTW - Verschuldigd Creditnota - Vak 63', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451600', '', 'Btw (Belasting Bij Oorsprong)', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451800', '', 'Verschuldigde BTW - Ontoer. Heffing', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451820', '', 'Verschuldigde BTW - Herzien. Aftrek', '451', '0');
INSERT INTO `0_chart_master` VALUES ('451830', '', 'Verschuldigde BTW - Regularisaties', '451', '0');
INSERT INTO `0_chart_master` VALUES ('452000', '', 'Te betalen belastingen en taksen', '4520', '0');
INSERT INTO `0_chart_master` VALUES ('452100', '', 'Belgische winstbelastingen', '4521', '0');
INSERT INTO `0_chart_master` VALUES ('452500', '', 'Andere Belgische belastingen en taksen', '4525', '0');
INSERT INTO `0_chart_master` VALUES ('452800', '', 'Buitenlandse belastingen en taksen', '4528', '0');
INSERT INTO `0_chart_master` VALUES ('453000', '', 'Ingehouden bedrijfsvoorheffingen', '453', '0');
INSERT INTO `0_chart_master` VALUES ('454000', '', 'Rijksdienst voor Sociale Zekerheid (RSZ)', '454', '0');
INSERT INTO `0_chart_master` VALUES ('455000', '', 'Bezoldigingen', '455', '0');
INSERT INTO `0_chart_master` VALUES ('455800', '', 'Provisie eindejaarspremie', '455', '0');
INSERT INTO `0_chart_master` VALUES ('456000', '', 'Provisie vakantiegeld', '456', '0');
INSERT INTO `0_chart_master` VALUES ('459000', '', 'Andere sociale schulden', '459', '0');
INSERT INTO `0_chart_master` VALUES ('460000', '', 'Ontvangen vooruitbetalingen op bestellingen', '46', '0');
INSERT INTO `0_chart_master` VALUES ('470000', '', 'Dividenden en tantièmes over vorige boekjaren', '470', '0');
INSERT INTO `0_chart_master` VALUES ('471000', '', 'Dividenden over het boekjaar', '471', '0');
INSERT INTO `0_chart_master` VALUES ('472000', '', 'Tantiemes over het boekjaar', '472', '0');
INSERT INTO `0_chart_master` VALUES ('473000', '', 'Andere rechthebbenden', '473', '0');
INSERT INTO `0_chart_master` VALUES ('480000', '', 'Vervallen obligaties en coupons', '480', '0');
INSERT INTO `0_chart_master` VALUES ('483000', '', 'R/C bestuurder-zaakvoerder', '483', '0');
INSERT INTO `0_chart_master` VALUES ('483010', '', 'R/C vennoot 1', '483', '0');
INSERT INTO `0_chart_master` VALUES ('483020', '', 'R/C Vennoot 2', '483', '0');
INSERT INTO `0_chart_master` VALUES ('485000', '', 'Hangende betaalopdrachten', '485', '0');
INSERT INTO `0_chart_master` VALUES ('488000', '', 'Borgtochten ontvangen in contanten', '488', '0');
INSERT INTO `0_chart_master` VALUES ('489000', '', 'Andere diverse schulden', '489', '0');
INSERT INTO `0_chart_master` VALUES ('489001', '', 'RC exvennoot 1', '489', '0');
INSERT INTO `0_chart_master` VALUES ('489002', '', 'RC exvennoot 2', '489', '0');
INSERT INTO `0_chart_master` VALUES ('489003', '', 'RC exvennoot 3', '489', '0');
INSERT INTO `0_chart_master` VALUES ('490000', '', 'Af te grenzen kosten', '490', '0');
INSERT INTO `0_chart_master` VALUES ('490000', '', 'Over te dragen kosten', '490', '0');
INSERT INTO `0_chart_master` VALUES ('491000', '', 'Verkregen opbrengsten', '491', '0');
INSERT INTO `0_chart_master` VALUES ('491999', '', 'Wachtrekeningen actief', '491', '0');
INSERT INTO `0_chart_master` VALUES ('492000', '', 'Toe te rekenen kosten', '492', '0');
INSERT INTO `0_chart_master` VALUES ('493000', '', 'Af te grenzen opbrengsten', '493', '0');
INSERT INTO `0_chart_master` VALUES ('493000', '', 'Over te dragen opbrengsten', '493', '0');
INSERT INTO `0_chart_master` VALUES ('493999', '', 'Wachtrekeningen passief', '493', '0');
INSERT INTO `0_chart_master` VALUES ('500000', '', 'Eigen aandelen', '50', '0');
INSERT INTO `0_chart_master` VALUES ('510000', '', 'Aanschaffingswaarde aandelen', '510', '0');
INSERT INTO `0_chart_master` VALUES ('510100', '', 'Geldbelggingen en andere dan vastrentende beleggin', '510', '0');
INSERT INTO `0_chart_master` VALUES ('511000', '', 'Niet opgevraagde bedragen (-)', '511', '0');
INSERT INTO `0_chart_master` VALUES ('519000', '', 'Geboekte waardeverminderingen (-)', '519', '0');
INSERT INTO `0_chart_master` VALUES ('520000', '', 'Aanschaffingswaarde', '520', '0');
INSERT INTO `0_chart_master` VALUES ('529000', '', 'Geboekte waardeverminderingen (-)', '529', '0');
INSERT INTO `0_chart_master` VALUES ('539000', '', 'Geboekte waardeverminderingen (-)', '539', '0');
INSERT INTO `0_chart_master` VALUES ('540000', '', 'Te incasseren vervallen waarde', '54', '0');
INSERT INTO `0_chart_master` VALUES ('550001', '', 'XYZ Bank zichtrekening', '550', '0');
INSERT INTO `0_chart_master` VALUES ('550002', '', 'XYZ Bank spaarrekening', '550', '0');
INSERT INTO `0_chart_master` VALUES ('580000', '', 'Interne overboekingen', '58', '0');
INSERT INTO `0_chart_master` VALUES ('588000', '', 'Openingsrekening financieel', '58', '0');
INSERT INTO `0_chart_master` VALUES ('600000', '', 'Aankopen van grondstoffen', '60', '0');
INSERT INTO `0_chart_master` VALUES ('601000', '', 'Aankopen van hulpstoffen', '601', '0');
INSERT INTO `0_chart_master` VALUES ('603000', '', 'Algemene onderaannemingen', '603', '0');
INSERT INTO `0_chart_master` VALUES ('604000', '', 'Aankopen van handelsgoederen', '604', '0');
INSERT INTO `0_chart_master` VALUES ('605000', '', 'Aankopen van onroerende goederen voor verkoop', '605', '0');
INSERT INTO `0_chart_master` VALUES ('608000', '', 'Ontvangen korting, ristornos en rabatten', '608', '0');
INSERT INTO `0_chart_master` VALUES ('609000', '', 'Voorraadwijziging grondstoffen', '6090', '0');
INSERT INTO `0_chart_master` VALUES ('609100', '', 'Voorraadwijziging hulpstoffen', '6091', '0');
INSERT INTO `0_chart_master` VALUES ('609400', '', 'Voorraadwijziging handelsgoederen', '6094', '0');
INSERT INTO `0_chart_master` VALUES ('609500', '', 'Voorraadwijziging gekochte onroer. goed. verkoop', '6095', '0');
INSERT INTO `0_chart_master` VALUES ('610000', '', 'Huurlasten terreinen', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610100', '', 'Huurlasten gebouwen', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610200', '', 'Huurlasten machines en materieel', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610300', '', 'Huurlasten personenwagens 90%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610301', '', 'Huurlasten personenwagens 80%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610302', '', 'Huurlasten personenwagens 75%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610303', '', 'Huurlasten personenwagens 70%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610304', '', 'Huurlasten personenwagens 60%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610305', '', 'Huurlasten personenwagens 50%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610400', '', 'Huurlasten bedrijfswagens', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610500', '', 'Onderhoud en herstelling terreinen', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610600', '', 'Onderhoud en herstelling gebouwen', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610700', '', 'Onderhoud en herstelling machines', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610800', '', 'Onderhoud en herstelling wagens 90%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610801', '', 'Onderhoud en herstelling wagens 80%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610802', '', 'Onderhoud en herstelling wagens 75%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610803', '', 'Onderhoud en herstelling wagens 70%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610804', '', 'Onderhoud en herstelling wagens 60%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610805', '', 'Onderhoud en herstelling wagens 50%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('610900', '', 'Onderhoud en herstelling bedrijfswagens', '61', '0');
INSERT INTO `0_chart_master` VALUES ('611000', '', 'Bureaubenodigdheden en drukwerk', '61', '0');
INSERT INTO `0_chart_master` VALUES ('611100', '', 'Boeken, prospectus, documentatie', '61', '0');
INSERT INTO `0_chart_master` VALUES ('611200', '', 'Klein materiaal', '61', '0');
INSERT INTO `0_chart_master` VALUES ('611300', '', 'Onderhoudsproducten', '61', '0');
INSERT INTO `0_chart_master` VALUES ('611400', '', 'Verbruiksgoederen niet in 60', '61', '0');
INSERT INTO `0_chart_master` VALUES ('611500', '', 'Verbruik water', '61', '0');
INSERT INTO `0_chart_master` VALUES ('611600', '', 'Verbruik gas', '61', '0');
INSERT INTO `0_chart_master` VALUES ('611700', '', 'Verbruik elektriciteit', '61', '0');
INSERT INTO `0_chart_master` VALUES ('611800', '', 'Verbruik stookolie', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612000', '', 'Sociaal secretariaat', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612100', '', 'Informaticaprestaties', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612200', '', 'Factoringsdiensten', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612300', '', 'Studiebureau', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612400', '', 'Financiële instellingen', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612500', '', 'Technische controle wagens 90%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612501', '', 'Technische controle wagens 80%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612502', '', 'Technische controle wagens 75%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612503', '', 'Technische controle wagens 70%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612504', '', 'Technische controle wagens 60%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612505', '', 'Technische controle wagens 50%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612600', '', 'Technische controle bedrijfswagens', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612700', '', 'Heffing en royalties brevetten', '61', '0');
INSERT INTO `0_chart_master` VALUES ('612800', '', 'Heffing en royalties licenties', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613000', '', 'Verzekering brand', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613100', '', 'Verzekering diefstal', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613200', '', 'Verzekering bedrijfsrisico', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613300', '', 'Verzekering storm, hagel, wind', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613400', '', 'Verzekering wagens 90%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613401', '', 'Verzekering wagens 80%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613402', '', 'Verzekering wagens 75%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613403', '', 'Verzekering wagens 70%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613404', '', 'Verzekering wagens 60%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613405', '', 'Verzekering wagens 50%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613500', '', 'Verzekering bedrijfswagens', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613600', '', 'Verzekering burgerlijke aansprakelijkheid', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613700', '', 'Verzekering beroepsrisicos', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613800', '', 'Verzekering vervoer handelwaar', '61', '0');
INSERT INTO `0_chart_master` VALUES ('613900', '', 'Verzekering krediet', '61', '0');
INSERT INTO `0_chart_master` VALUES ('614000', '', 'Vervoerskosten op verkoop', '61', '0');
INSERT INTO `0_chart_master` VALUES ('614100', '', 'Maritiem vervoer', '61', '0');
INSERT INTO `0_chart_master` VALUES ('614200', '', 'Vervoer binnenwateren', '61', '0');
INSERT INTO `0_chart_master` VALUES ('614300', '', 'Treinvervoer', '61', '0');
INSERT INTO `0_chart_master` VALUES ('614400', '', 'Wegvervoer', '61', '0');
INSERT INTO `0_chart_master` VALUES ('614500', '', 'Luchtvervoer', '61', '0');
INSERT INTO `0_chart_master` VALUES ('614600', '', 'Andere vervoerskosten', '61', '0');
INSERT INTO `0_chart_master` VALUES ('615000', '', 'Commissies op verkopen', '61', '0');
INSERT INTO `0_chart_master` VALUES ('615100', '', 'Commissies op aankopen', '61', '0');
INSERT INTO `0_chart_master` VALUES ('615200', '', 'Erelonen accountants', '61', '0');
INSERT INTO `0_chart_master` VALUES ('615300', '', 'Erelonen architecten', '61', '0');
INSERT INTO `0_chart_master` VALUES ('615400', '', 'Erelonen geneesheren', '61', '0');
INSERT INTO `0_chart_master` VALUES ('615500', '', 'Erelonen dierenartsen', '61', '0');
INSERT INTO `0_chart_master` VALUES ('615600', '', 'Erelonen deskundigen', '61', '0');
INSERT INTO `0_chart_master` VALUES ('615700', '', 'Erelonen advocaten', '61', '0');
INSERT INTO `0_chart_master` VALUES ('615800', '', 'Erelonen notaris', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616000', '', 'Kosten post', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616100', '', 'Portkosten', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616200', '', 'Telefoon, GSM', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616300', '', 'Internet', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616500', '', 'Benzinekosten 75%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616501', '', 'Benzinekosten 100%', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616600', '', 'Verplaatsingskosten (binnenland)', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616700', '', 'Verplaatsingskosten (buitenland)', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616800', '', 'Beperkte Onthaalkosten', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616800', '', 'Restaurantkosten (binnenland)', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616900', '', 'Restaurantkosten (buitenland)', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616910', '', 'Hotelkosten (binnenland)', '61', '0');
INSERT INTO `0_chart_master` VALUES ('616920', '', 'Hotelkosten (buitenland)', '61', '0');
INSERT INTO `0_chart_master` VALUES ('617000', '', 'Uitzendkrachten', '61', '0');
INSERT INTO `0_chart_master` VALUES ('617100', '', 'Personen ter beschikking gesteld', '61', '0');
INSERT INTO `0_chart_master` VALUES ('618000', '', 'Bezoldiging bestuurders', '618', '0');
INSERT INTO `0_chart_master` VALUES ('618010', '', 'Belaste voordelen alle aard auto 90%', '618', '0');
INSERT INTO `0_chart_master` VALUES ('618011', '', 'Belaste voordelen alle aard auto 80%', '618', '0');
INSERT INTO `0_chart_master` VALUES ('618012', '', 'Belaste voordelen alle aard auto 75%', '618', '0');
INSERT INTO `0_chart_master` VALUES ('618013', '', 'Belaste voordelen alle aard auto 70%', '618', '0');
INSERT INTO `0_chart_master` VALUES ('618014', '', 'Belaste voordelen alle aard auto 60%', '618', '0');
INSERT INTO `0_chart_master` VALUES ('618015', '', 'Belaste voordelen alle aard auto 50%', '618', '0');
INSERT INTO `0_chart_master` VALUES ('618020', '', 'Belaste voordelen alle aard andere', '618', '0');
INSERT INTO `0_chart_master` VALUES ('619000', '', 'Publiciteit en aankondigingen', '619', '0');
INSERT INTO `0_chart_master` VALUES ('619100', '', 'Affiches, drukwerk, catalogus', '619', '0');
INSERT INTO `0_chart_master` VALUES ('619200', '', 'Beurzen en tentoonstellingen', '619', '0');
INSERT INTO `0_chart_master` VALUES ('619300', '', 'Etalage- en demonstratiekosten', '619', '0');
INSERT INTO `0_chart_master` VALUES ('619400', '', 'cadeaus en bloemen (beperkt)', '619', '0');
INSERT INTO `0_chart_master` VALUES ('619500', '', 'cadeaus en bloemen (onbeperkt)', '619', '0');
INSERT INTO `0_chart_master` VALUES ('619600', '', 'Bijdragen', '619', '0');
INSERT INTO `0_chart_master` VALUES ('619700', '', 'Giften en liberaliteiten', '619', '0');
INSERT INTO `0_chart_master` VALUES ('620100', '', 'Directiepersoneel', '6201', '0');
INSERT INTO `0_chart_master` VALUES ('620150', '', 'Belaste voordelen in natura', '6201', '0');
INSERT INTO `0_chart_master` VALUES ('620200', '', 'Bedienden', '6202', '0');
INSERT INTO `0_chart_master` VALUES ('620250', '', 'Belaste voordelen in natura', '6202', '0');
INSERT INTO `0_chart_master` VALUES ('620300', '', 'Arbeiders', '6203', '0');
INSERT INTO `0_chart_master` VALUES ('620350', '', 'Belaste voordelen in natura', '6203', '0');
INSERT INTO `0_chart_master` VALUES ('620510', '', 'Bezoldiging VAA bedrijfswagens bedienden', '6205', '0');
INSERT INTO `0_chart_master` VALUES ('620560', '', 'Bezoldiging voordelen van alle aard', '6205', '0');
INSERT INTO `0_chart_master` VALUES ('620600', '', 'Bezoldigign aangegeven voordelen van alle aard', '6206', '0');
INSERT INTO `0_chart_master` VALUES ('620700', '', 'Andere personeelskosten', '6207', '0');
INSERT INTO `0_chart_master` VALUES ('621000', '', 'Werkgeversbijdrage RSZ', '621', '0');
INSERT INTO `0_chart_master` VALUES ('621710', '', 'Arbeidsongevallenverzekering', '621', '0');
INSERT INTO `0_chart_master` VALUES ('622000', '', 'Werkgeversbijdrage bovenwettelijke verzekering', '622', '0');
INSERT INTO `0_chart_master` VALUES ('622010', '', 'Groepsverzekeringen', '622', '0');
INSERT INTO `0_chart_master` VALUES ('622120', '', 'Buitenwettelijk pensioen', '622', '0');
INSERT INTO `0_chart_master` VALUES ('623000', '', 'Andere personeelskosten', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623100', '', 'Externe medische diensten', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623200', '', 'Kantinekosten', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623300', '', 'Sociale abonnementen', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623400', '', 'Arbeidskledij', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623500', '', 'Bijscholings- en vervolledigingscursussen', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623700', '', 'Sociale verkiezingen', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623800', '', 'Vrijgestelde sociale voordelen', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623819', '', 'Maaltijdcheques', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623821', '', 'Collectieve reizen personeel', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623822', '', 'Huwelijks- en geboortegeschenken', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623900', '', 'Andere personeelskosten maaltijdcheques', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623910', '', 'Voorziening vakantiegeld', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623913', '', 'Terugname voorziening vakantiegeld', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623920', '', 'Voorziening eindejaarspremie', '623', '0');
INSERT INTO `0_chart_master` VALUES ('623922', '', 'Terugname voorziening eindejaarspremie', '623', '0');
INSERT INTO `0_chart_master` VALUES ('624000', '', 'Rust- en overlevingspensioenen', '6240', '0');
INSERT INTO `0_chart_master` VALUES ('624100', '', 'Rust- en overlevingspensioenen', '6241', '0');
INSERT INTO `0_chart_master` VALUES ('630000', '', 'Afschrijving oprichtingskosten en kap.verhoging', '6300', '0');
INSERT INTO `0_chart_master` VALUES ('630010', '', 'Afschrijving uitgifte van leningen', '6300', '0');
INSERT INTO `0_chart_master` VALUES ('630020', '', 'Afschrijving overige oprichtingskosten', '6300', '0');
INSERT INTO `0_chart_master` VALUES ('630030', '', 'Afschrijving intercalaire intresten', '6300', '0');
INSERT INTO `0_chart_master` VALUES ('630040', '', 'Afschrijving herstructureringskosten', '6300', '0');
INSERT INTO `0_chart_master` VALUES ('630100', '', 'Afschrijving kosten van onderzoek en ontwikkeling', '6301', '0');
INSERT INTO `0_chart_master` VALUES ('630110', '', 'Afschrijving conc., octr., lic., know-how, merken', '6301', '0');
INSERT INTO `0_chart_master` VALUES ('630120', '', 'Afschrijving goodwill', '6301', '0');
INSERT INTO `0_chart_master` VALUES ('630130', '', 'Afschrijving vooruitbetalingen', '6301', '0');
INSERT INTO `0_chart_master` VALUES ('630200', '', 'Afschrijving materiële vaste activa', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630220', '', 'Afschrijving terreinen', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630221', '', 'Afschrijving gebouwen', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630222', '', 'Afschrijving bebouwde terreinen', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630223', '', 'Afschrijving overige zakelijke rechten op OG', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630230', '', 'Afschrijving technische installaties en machines', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630231', '', 'Afschrijving andere installaties', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630232', '', 'Afschrijving uitrusting', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630240', '', 'Afschrijving meubilair', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630241', '', 'Afschrijving wagens 100%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630242', '', 'Afschrijving wagens 90%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630243', '', 'Afschrijving wagens 80%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630244', '', 'Afschrijving wagens 75%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630245', '', 'Afschrijving wagens 70%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630246', '', 'Afschrijving wagens 60%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630247', '', 'Afschrijving wagens 50%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630250', '', 'Afschrijving terreinen en gebouwen in leasing', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630251', '', 'Afschrijving inst., mach. en mat. in leasing', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630252', '', 'Afschrijving meubilair in leasing', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630253', '', 'Afschrijving rol. mat. in leasing - wagens 100%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630254', '', 'Afschrijving rol. mat. in leasing - wagens 90%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630255', '', 'Afschrijving rol. mat. in leasing - wagens 80%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630256', '', 'Afschrijving rol. mat. in leasing - wagens 75%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630257', '', 'Afschrijving rol. mat. in leasing - wagens 70%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630258', '', 'Afschrijving rol. mat. in leasing - wagens 60%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630259', '', 'Afschrijving rol. mat. in leasing - wagens 50%', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630260', '', 'Afschrijving overige materiële vaste activa', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630270', '', 'Afschrijving vaste activa in aanbouw', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630271', '', 'Afschrijving vooruitbet. vaste activa in aanbouw', '6302', '0');
INSERT INTO `0_chart_master` VALUES ('630800', '', 'Waardevermind. kosten onderzoek en ontwikkeling', '6308', '0');
INSERT INTO `0_chart_master` VALUES ('630810', '', 'Waardevermin. conc., octr., lic., know-how, merken', '6308', '0');
INSERT INTO `0_chart_master` VALUES ('630820', '', 'Waardevermin. goodwill', '6308', '0');
INSERT INTO `0_chart_master` VALUES ('630830', '', 'Waardevermin. vooruitbetalingen', '6308', '0');
INSERT INTO `0_chart_master` VALUES ('630900', '', 'Waardevermindering materiële vaste activa', '6309', '0');
INSERT INTO `0_chart_master` VALUES ('630920', '', 'Waardevermindering terreinen', '6309', '0');
INSERT INTO `0_chart_master` VALUES ('631030', '', 'Toevoeg Waardeverm grondstoffen', '6310', '0');
INSERT INTO `0_chart_master` VALUES ('631031', '', 'Toevoeg Waardeverm hulpstoffen', '6310', '0');
INSERT INTO `0_chart_master` VALUES ('631032', '', 'Toevoeg Waardeverm goederen in bewerking', '6310', '0');
INSERT INTO `0_chart_master` VALUES ('631033', '', 'Toevoeg Waardeverm gereed produkt', '6310', '0');
INSERT INTO `0_chart_master` VALUES ('631034', '', 'Toevoeg Waardeverm handelsgoederen', '6310', '0');
INSERT INTO `0_chart_master` VALUES ('631035', '', 'Toevoeg Waardeverm onr. goed. verkoop', '6310', '0');
INSERT INTO `0_chart_master` VALUES ('631036', '', 'Toevoeg Waardeverm voorraadinkopen', '6310', '0');
INSERT INTO `0_chart_master` VALUES ('631130', '', 'Terugneming Waardeverm grondstoffen', '6311', '0');
INSERT INTO `0_chart_master` VALUES ('631131', '', 'Terugneming Waardeverm hulpstoffen', '6311', '0');
INSERT INTO `0_chart_master` VALUES ('631132', '', 'Terugneming Waardeverm goederen in bewerking', '6311', '0');
INSERT INTO `0_chart_master` VALUES ('631133', '', 'Terugneming Waardeverm gereed produkt', '6311', '0');
INSERT INTO `0_chart_master` VALUES ('631134', '', 'Terugneming Waardeverm handelsgoederen', '6311', '0');
INSERT INTO `0_chart_master` VALUES ('631135', '', 'Terugneming Waardeverm onr. goed. verkoop', '6311', '0');
INSERT INTO `0_chart_master` VALUES ('631136', '', 'Terugneming Waardeverm voorraadinkopen', '6311', '0');
INSERT INTO `0_chart_master` VALUES ('632037', '', 'Toevoeg Waardeverm bestel. in uitvoering', '6320', '0');
INSERT INTO `0_chart_master` VALUES ('632137', '', 'Terugneming Waardeverm bestel. in uitvoering', '6321', '0');
INSERT INTO `0_chart_master` VALUES ('633000', '', 'Toevoeg. waardevermind. op handelsvordering >1jaar', '6330', '0');
INSERT INTO `0_chart_master` VALUES ('633100', '', 'Terugn. waardevermind. op handelsvordering >1jaar', '6331', '0');
INSERT INTO `0_chart_master` VALUES ('634000', '', 'Toevoeg. waardevermind. op handelsvordering <1jaar', '6340', '0');
INSERT INTO `0_chart_master` VALUES ('634100', '', 'Terugn. waardevermind. op handelsvordering <1jaar', '6341', '0');
INSERT INTO `0_chart_master` VALUES ('635000', '', 'Toevoeging voorziening pensioenen en soortgelijke', '6350', '0');
INSERT INTO `0_chart_master` VALUES ('635100', '', 'Terugname voorziening pensioenen en soortgelijke', '6351', '0');
INSERT INTO `0_chart_master` VALUES ('636000', '', 'Toevoeging voorziening grote herstel. en onderhoud', '6360', '0');
INSERT INTO `0_chart_master` VALUES ('636100', '', 'Terugname voorziening grote herstel. en onderhoud', '6361', '0');
INSERT INTO `0_chart_master` VALUES ('637000', '', 'Toevoeging voorziening milieuverplichtingen', '6370', '0');
INSERT INTO `0_chart_master` VALUES ('637100', '', 'Terugname voorziening andere risicos en kosten', '6371', '0');
INSERT INTO `0_chart_master` VALUES ('638000', '', 'Toevoeging voorziening andere risicos en kosten', '6380', '0');
INSERT INTO `0_chart_master` VALUES ('638100', '', 'Terugname voorziening andere risicos en kosten', '6381', '0');
INSERT INTO `0_chart_master` VALUES ('640000', '', 'Milieubelastingen', '640', '0');
INSERT INTO `0_chart_master` VALUES ('640100', '', 'Ecotaksen', '640', '0');
INSERT INTO `0_chart_master` VALUES ('640120', '', 'Provincie en gemeentebelasting', '640', '0');
INSERT INTO `0_chart_master` VALUES ('640200', '', 'Verkeersbelasting personenwagens', '640', '0');
INSERT INTO `0_chart_master` VALUES ('640300', '', 'Verkeersbelasting bedrijfswagens', '640', '0');
INSERT INTO `0_chart_master` VALUES ('640400', '', 'Onroerende voorheffing', '640', '0');
INSERT INTO `0_chart_master` VALUES ('640500', '', 'Registratie en wettelijke publicaties', '640', '0');
INSERT INTO `0_chart_master` VALUES ('640600', '', 'Provinciale en gemeentelijke publicaties', '640', '0');
INSERT INTO `0_chart_master` VALUES ('640700', '', 'Vennootschapsbijdrage', '640', '0');
INSERT INTO `0_chart_master` VALUES ('640800', '', 'Douane en accijnzen', '640', '0');
INSERT INTO `0_chart_master` VALUES ('641000', '', 'Minwaarde op de courante realisatie vaste activa', '641', '0');
INSERT INTO `0_chart_master` VALUES ('642000', '', 'Minwaarde op de realisatie van handelsvordering', '642', '0');
INSERT INTO `0_chart_master` VALUES ('643000', '', 'Niet aftrekbare BTW', '643', '0');
INSERT INTO `0_chart_master` VALUES ('644000', '', 'Aftrekbare boeten', '644', '0');
INSERT INTO `0_chart_master` VALUES ('645000', '', 'Niet aftrekbare boeten', '645', '0');
INSERT INTO `0_chart_master` VALUES ('648000', '', 'Diverse bedrijfskosten', '648', '0');
INSERT INTO `0_chart_master` VALUES ('649000', '', 'Als herstructureringskosten geactiveerde kosten(-)', '649', '0');
INSERT INTO `0_chart_master` VALUES ('650000', '', 'Rente, commissies en kosten verbonden aan schulden', '6500', '0');
INSERT INTO `0_chart_master` VALUES ('650100', '', 'Afschrijving van kosten bij uitgifte van leningen', '6501', '0');
INSERT INTO `0_chart_master` VALUES ('650200', '', 'Andere kosten van schulden', '6502', '0');
INSERT INTO `0_chart_master` VALUES ('650300', '', 'Geactiveerde intercalaire intresten (-)', '6503', '0');
INSERT INTO `0_chart_master` VALUES ('651000', '', 'Toevoeging waardevermind. op vlottende activa', '6510', '0');
INSERT INTO `0_chart_master` VALUES ('651100', '', 'Terugname waardevermind. op vlottende activa', '6511', '0');
INSERT INTO `0_chart_master` VALUES ('652000', '', 'Minderwaarden op realisatie van vlottende activa', '652', '0');
INSERT INTO `0_chart_master` VALUES ('653000', '', 'Discontokosten op vorderingen', '653', '0');
INSERT INTO `0_chart_master` VALUES ('654000', '', 'Wisselresultaten', '654', '0');
INSERT INTO `0_chart_master` VALUES ('655000', '', 'Nadelige koersverschillen', '655', '0');
INSERT INTO `0_chart_master` VALUES ('656000', '', 'Toevoeging voorziening met financieel karakter', '6560', '0');
INSERT INTO `0_chart_master` VALUES ('656100', '', 'Terugname voorziening met financieel karakter', '6561', '0');
INSERT INTO `0_chart_master` VALUES ('657000', '', 'Toegestane betalingskortingen', '657', '0');
INSERT INTO `0_chart_master` VALUES ('657100', '', 'Nadelige afrondingsverschillen', '657', '0');
INSERT INTO `0_chart_master` VALUES ('658000', '', 'Bankonkosten', '658', '0');
INSERT INTO `0_chart_master` VALUES ('658100', '', 'Herinneringskosten', '658', '0');
INSERT INTO `0_chart_master` VALUES ('659000', '', 'Als herstructueringskosten geact. fin kosten (-)', '659', '0');
INSERT INTO `0_chart_master` VALUES ('660000', '', 'Uitz Afs Wrdever. oprichtingskosten & kap. verh.', '6600', '0');
INSERT INTO `0_chart_master` VALUES ('660010', '', 'Uitz Afs Wrdever. uitgifte van leningen', '6600', '0');
INSERT INTO `0_chart_master` VALUES ('660020', '', 'Uitz Afs Wrdever. overige oprichtingskosten', '6600', '0');
INSERT INTO `0_chart_master` VALUES ('660030', '', 'Uitz Afs Wrdever. intercalaire intresten', '6600', '0');
INSERT INTO `0_chart_master` VALUES ('660040', '', 'Uitz Afs Wrdever. herstructueringskosten', '6600', '0');
INSERT INTO `0_chart_master` VALUES ('660100', '', 'Uitz Afs Wrdever. kosten onderzoek en ontwikkeling', '6601', '0');
INSERT INTO `0_chart_master` VALUES ('660110', '', 'Uitz Afs Wrdevconc., octr., lic., know-how, merken', '6601', '0');
INSERT INTO `0_chart_master` VALUES ('660120', '', 'Uitz Afs Wrdever. goodwill', '6601', '0');
INSERT INTO `0_chart_master` VALUES ('660130', '', 'Uitz Afs Wrdever. vooruitbetalingen', '6601', '0');
INSERT INTO `0_chart_master` VALUES ('660220', '', 'Uitz Afs Wrdever. terreinen', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660221', '', 'Uitz Afs Wrdever. gebouwen', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660222', '', 'Uitz Afs Wrdever. bebouwde terreinen', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660223', '', 'Uitz Afs Wrdever. overige zak. rechten op OG', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660230', '', 'Uitz Afs Wrdever. technische installaties en mach.', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660231', '', 'Uitz Afs Wrdever. andere installaties', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660232', '', 'Uitz Afs Wrdever. uitrusting', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660240', '', 'Uitz Afs Wrdever. meubilair', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660241', '', 'Uitz Afs Wrdever. personenwagens', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660242', '', 'Uitz Afs Wrdever. bedrijfswagens', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660250', '', 'Uitz Afs Wrdever. terreinen en geb. in leasing', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660251', '', 'Uitz Afs Wrdever. inst., mach. en mat. in leasing', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660252', '', 'Uitz Afs Wrdever. meubilair in leasing', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660253', '', 'Uitz Afs Wrdev. rol. mat. in leas. - personenwagen', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660254', '', 'Uitz Afs Wrdev. rol. mat. in leas. - bedrijfswagen', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660260', '', 'Uitz Afs Wrdever. overige mat. vaste activa', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660270', '', 'Uitz Afs Wrdever. vaste activa in aanbouw', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('660271', '', 'Uitz Afs Wrdever.vooruitbet. vaste activa in aanb.', '6602', '0');
INSERT INTO `0_chart_master` VALUES ('661000', '', 'Waardeverminderingen op financiële vaste activa', '661', '0');
INSERT INTO `0_chart_master` VALUES ('662000', '', 'Provisie niet-recurrente bedrijfskosten', '6620', '0');
INSERT INTO `0_chart_master` VALUES ('662100', '', 'Provisie niet-recurrente financiële kosten', '6621', '0');
INSERT INTO `0_chart_master` VALUES ('663000', '', 'Minderwaarde op de realisatie van IVA en MVA', '663', '0');
INSERT INTO `0_chart_master` VALUES ('663100', '', 'Minderwaarde op de realisatie van FVA', '663', '0');
INSERT INTO `0_chart_master` VALUES ('664000', '', 'Andere niet-recurrente bedrijfskosten', '664', '0');
INSERT INTO `0_chart_master` VALUES ('668000', '', 'Andere niet-recurrente financiële kosten', '668', '0');
INSERT INTO `0_chart_master` VALUES ('669000', '', 'Geact. niet-recurrente bedrijfskosten (-)', '669', '0');
INSERT INTO `0_chart_master` VALUES ('669100', '', 'Geact. niet-recurrente financiële kosten (-)', '669', '0');
INSERT INTO `0_chart_master` VALUES ('670000', '', 'Voorafbetaling belastingen', '6700', '0');
INSERT INTO `0_chart_master` VALUES ('670010', '', 'Roerende voorheffing', '6700', '0');
INSERT INTO `0_chart_master` VALUES ('670100', '', 'Geactiveerde overschotten (-)', '6701', '0');
INSERT INTO `0_chart_master` VALUES ('670200', '', 'Geraamde belastingen', '6702', '0');
INSERT INTO `0_chart_master` VALUES ('671000', '', 'Belgische belasting op resultaat vorige boekjaren', '6710', '0');
INSERT INTO `0_chart_master` VALUES ('671100', '', 'Geraamde belastingsupplementen', '6711', '0');
INSERT INTO `0_chart_master` VALUES ('671200', '', 'Gevormde fiscale voorzieningen', '6712', '0');
INSERT INTO `0_chart_master` VALUES ('672000', '', 'Buitenlandse belastingen boekjaar', '672', '0');
INSERT INTO `0_chart_master` VALUES ('673000', '', 'Buitenlandse belastingen vorige boekjaren', '673', '0');
INSERT INTO `0_chart_master` VALUES ('680000', '', 'Overboeking naar uitgestelde belasting', '68', '0');
INSERT INTO `0_chart_master` VALUES ('689000', '', 'Overboeking naar belastingvrije reserves', '689', '0');
INSERT INTO `0_chart_master` VALUES ('690000', '', 'Overgedragen verlies vorig boekjaar', '690', '0');
INSERT INTO `0_chart_master` VALUES ('691000', '', 'Toevoeging aan het kapitaal en de uitgiftepremies', '691', '0');
INSERT INTO `0_chart_master` VALUES ('692000', '', 'Toevoeging aan de wettelijke reserve', '6920', '0');
INSERT INTO `0_chart_master` VALUES ('692100', '', 'Toevoeging aan de overige reserves', '6921', '0');
INSERT INTO `0_chart_master` VALUES ('693000', '', 'Over te dragen winst', '693', '0');
INSERT INTO `0_chart_master` VALUES ('694000', '', 'Vergoeding van het kapitaal', '694', '0');
INSERT INTO `0_chart_master` VALUES ('695000', '', 'Bestuurders of zaakvoerders', '695', '0');
INSERT INTO `0_chart_master` VALUES ('696000', '', 'Werknemers', '696', '0');
INSERT INTO `0_chart_master` VALUES ('697000', '', 'Andere rechthebbenden', '697', '0');
INSERT INTO `0_chart_master` VALUES ('700000', '', 'Verkopen en dienstprestaties', '700', '0');
INSERT INTO `0_chart_master` VALUES ('700100', '', 'Verkopen diensten 100', '700', '0');
INSERT INTO `0_chart_master` VALUES ('700200', '', 'Verkopen diensten 200', '700', '0');
INSERT INTO `0_chart_master` VALUES ('708000', '', 'Toegekende korting, ristornos en rabatten (-)', '708', '0');
INSERT INTO `0_chart_master` VALUES ('709000', '', 'Tegenboeking BTW op marge (-)', '709', '0');
INSERT INTO `0_chart_master` VALUES ('712000', '', 'Wijziging in voorraad goederen in bewerking', '712', '0');
INSERT INTO `0_chart_master` VALUES ('713000', '', 'Wijziging in voorraad gereed product', '713', '0');
INSERT INTO `0_chart_master` VALUES ('714000', '', 'Wijziging in voorraad onroerende goederen', '714', '0');
INSERT INTO `0_chart_master` VALUES ('717000', '', 'Wijziging in best. in uitvoering - aansch.waarde', '7170', '0');
INSERT INTO `0_chart_master` VALUES ('717100', '', 'Wijziging in best. in uitvoering - toegerek. winst', '7171', '0');
INSERT INTO `0_chart_master` VALUES ('720000', '', 'Geproduceerde vaste activa', '72', '0');
INSERT INTO `0_chart_master` VALUES ('740000', '', 'Bedrijfssubsidies en compenserende bedragen', '74', '0');
INSERT INTO `0_chart_master` VALUES ('741000', '', 'Meerwaarde op courante realisatie mat.vaste activa', '741', '0');
INSERT INTO `0_chart_master` VALUES ('742000', '', 'Meerwaarde op de realisatie van handelsvordering', '742', '0');
INSERT INTO `0_chart_master` VALUES ('743000', '', 'Bijdrage WN maaltijdcheque', '743', '0');
INSERT INTO `0_chart_master` VALUES ('743900', '', 'Structurele interprof.looncorrectie', '743', '0');
INSERT INTO `0_chart_master` VALUES ('746400', '', 'Recuperatie voordelen alle aard auto 90%', '746', '0');
INSERT INTO `0_chart_master` VALUES ('746401', '', 'Recuperatie voordelen alle aard auto 80%', '746', '0');
INSERT INTO `0_chart_master` VALUES ('746402', '', 'Recuperatie voordelen alle aard auto 75%', '746', '0');
INSERT INTO `0_chart_master` VALUES ('746403', '', 'Recuperatie voordelen alle aard auto 70%', '746', '0');
INSERT INTO `0_chart_master` VALUES ('746404', '', 'Recuperatie voordelen alle aard auto 60%', '746', '0');
INSERT INTO `0_chart_master` VALUES ('746405', '', 'Recuperatie voordelen alle aard auto 50%', '746', '0');
INSERT INTO `0_chart_master` VALUES ('746410', '', 'Recuperatie voordelen alle aard andere', '746', '0');
INSERT INTO `0_chart_master` VALUES ('750000', '', 'Opbrengsten uit financiële vaste activa', '750', '0');
INSERT INTO `0_chart_master` VALUES ('751000', '', 'Opbrengsten uit vlottende activa', '751', '0');
INSERT INTO `0_chart_master` VALUES ('752000', '', 'Meerwaarde op de realisatie van vlottende activa', '752', '0');
INSERT INTO `0_chart_master` VALUES ('753000', '', 'Kapitaalsubsidies', '753', '0');
INSERT INTO `0_chart_master` VALUES ('754000', '', 'Wisselresultaten', '754', '0');
INSERT INTO `0_chart_master` VALUES ('755000', '', 'Voordelige koersverschillen', '755', '0');
INSERT INTO `0_chart_master` VALUES ('757000', '', 'Bekomen betalingskortingen', '757', '0');
INSERT INTO `0_chart_master` VALUES ('757100', '', 'Voordelige afrondingsverschill', '757', '0');
INSERT INTO `0_chart_master` VALUES ('758000', '', 'Voordelige afrondingsverschill', '758', '0');
INSERT INTO `0_chart_master` VALUES ('759000', '', 'Diverse financiële opbrengsten', '759', '0');
INSERT INTO `0_chart_master` VALUES ('760000', '', 'Terugname afschr. en waardvermind. immateriële VA', '7600', '0');
INSERT INTO `0_chart_master` VALUES ('760100', '', 'Terugname afschr. en waardvermind. materiële VA', '7601', '0');
INSERT INTO `0_chart_master` VALUES ('760200', '', 'Op oprichtingskosten', '7602', '0');
INSERT INTO `0_chart_master` VALUES ('761000', '', 'Terugname waardevermind. financiele vaste activa', '761', '0');
INSERT INTO `0_chart_master` VALUES ('762000', '', 'Terugn. voorz. niet-recurrente bedrijfskosten', '762', '0');
INSERT INTO `0_chart_master` VALUES ('762100', '', 'Terugn. voorz. niet-recurrente financiele kosten', '762', '0');
INSERT INTO `0_chart_master` VALUES ('763000', '', 'Meerwaarde op de realisatie van IVA en  MVA', '763', '0');
INSERT INTO `0_chart_master` VALUES ('763100', '', 'Meerwaarde op de realisatie van FVA', '763', '0');
INSERT INTO `0_chart_master` VALUES ('764000', '', 'Compensatie afschrijving meerwaarde', '764', '0');
INSERT INTO `0_chart_master` VALUES ('768000', '', 'Andere niet-recurrente bedrijfsopbrengsten', '768', '0');
INSERT INTO `0_chart_master` VALUES ('769000', '', 'Andere niet recurrente financiele opbrengsten', '769', '0');
INSERT INTO `0_chart_master` VALUES ('771000', '', 'Regularisering van versch. of betaalde belastingen', '7710', '0');
INSERT INTO `0_chart_master` VALUES ('771100', '', 'Regularisering van geraamde belastingen', '7711', '0');
INSERT INTO `0_chart_master` VALUES ('771200', '', 'Terugneming fiscale voorzieningen', '7712', '0');
INSERT INTO `0_chart_master` VALUES ('773000', '', 'Buitenlandse belastingen', '773', '0');
INSERT INTO `0_chart_master` VALUES ('780000', '', 'Onttrekking aan de uitgestelde belastingen', '780', '0');
INSERT INTO `0_chart_master` VALUES ('789000', '', 'Onttrekking aan de belastingvrije reserves', '789', '0');
INSERT INTO `0_chart_master` VALUES ('790000', '', 'Overgedragen winst vorig boekjaar', '790', '0');
INSERT INTO `0_chart_master` VALUES ('791000', '', 'Onttrekking aan het kapitaal en de uitgiftepremies', '791', '0');
INSERT INTO `0_chart_master` VALUES ('792000', '', 'Onttrekking aan de reserves', '792', '0');
INSERT INTO `0_chart_master` VALUES ('793000', '', 'Over te dragen verlies', '793', '0');
INSERT INTO `0_chart_master` VALUES ('794000', '', 'Tussenkomst vennoten in het verlies', '794', '0');


### Structure of table `0_chart_types` ###

DROP TABLE IF EXISTS `0_chart_types`;

CREATE TABLE `0_chart_types` (
  `id` varchar(10) NOT NULL,
  `name` varchar(60) NOT NULL default '',
  `class_id` varchar(3) NOT NULL default '',
  `parent` varchar(10) NOT NULL default '-1',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `name` (`name`),
  KEY `class_id` (`class_id`)
) ENGINE=MyISAM;

### Data of table `0_chart_types` ###

INSERT INTO `0_chart_types` VALUES ('10', 'Geplaatst kapitaal', '1', '10', '0');
INSERT INTO `0_chart_types` VALUES ('101', 'Niet opgevraagd kapitaal (-)', '1', '101', '0');

INSERT INTO `0_chart_types` VALUES ('11', 'Uitgiftepremies', '1', '11', '0');
INSERT INTO `0_chart_types` VALUES ('120', 'Herwaarderingsmeerwaarde immateriële vaste activa', '1', '120', '0');
INSERT INTO `0_chart_types` VALUES ('121', 'Herwaarderingsmeerwaarde materiële vaste activa', '1', '121', '0');
INSERT INTO `0_chart_types` VALUES ('122', 'Herwaarderingsmeerwaarde financiële vaste activa', '1', '122', '0');
INSERT INTO `0_chart_types` VALUES ('123', 'Herwaarderingsmeerwaarde voorraden', '1', '123', '0');
INSERT INTO `0_chart_types` VALUES ('124', 'Terugneming waardeverminderingen op geldbelegging', '1', '124', '0');
INSERT INTO `0_chart_types` VALUES ('130', 'Wettelijke reserve', '1', '130', '0');
INSERT INTO `0_chart_types` VALUES ('131', 'Onbeschikbare reserves voor eigen aandelen', '1', '131', '0');
INSERT INTO `0_chart_types` VALUES ('1311', 'Andere onbeschikbare reserves', '1', '1311', '0');
INSERT INTO `0_chart_types` VALUES ('132', 'Belastingvrije reserves', '1', '132', '0');
INSERT INTO `0_chart_types` VALUES ('133', 'Beschikbare reserves', '1', '133', '0');
INSERT INTO `0_chart_types` VALUES ('14', 'Overgedragen winst', '1', '14', '0');

INSERT INTO `0_chart_types` VALUES ('148', 'Openingsrekening algemeen', '1', '148', '0');

INSERT INTO `0_chart_types` VALUES ('15', 'Kapitaalsubsidies', '1', '15', '0');

INSERT INTO `0_chart_types` VALUES ('16', 'Voorziening voor pensioenen en soortgelijke verpl.', '1', '16', '0');
INSERT INTO `0_chart_types` VALUES ('161', 'Voorzieningen voor belastingen', '1', '161', '0');
INSERT INTO `0_chart_types` VALUES ('162', 'Voorziening voor grote herstelling en onderhoud', '1', '162', '0');
INSERT INTO `0_chart_types` VALUES ('163', 'Voorziening voor milieuverplichtingen', '1', '163', '0');
INSERT INTO `0_chart_types` VALUES ('164', 'Voorziening voor overige risicos en kosten', '1', '164', '0');
INSERT INTO `0_chart_types` VALUES ('1680', 'Uitgestelde belastingen op kapitaalsubsidies', '1', '1680', '0');
INSERT INTO `0_chart_types` VALUES ('1680', 'Uitgestelde belastingen op kapitaalsubsidies', '1', '1680', '0');
INSERT INTO `0_chart_types` VALUES ('1681', 'Uitgest. belast. gereal. meerw. immat. vaste act.', '1', '1681', '0');

INSERT INTO `0_chart_types` VALUES ('1682', 'Uitgest. belast. gereal. meerw. mat. vaste act.', '1', '1682', '0');

INSERT INTO `0_chart_types` VALUES ('1687', 'Uitgestelde belastingen op gereal. meerwaarde eff.', '1', '1687', '0');
INSERT INTO `0_chart_types` VALUES ('1688', 'Buitenlandse uitgestelde belastingen', '1', '1688', '0');
INSERT INTO `0_chart_types` VALUES ('1700', 'Converteerbare achtergestelde leningen', '1', '1700', '0');
INSERT INTO `0_chart_types` VALUES ('1701', 'Niet-converteerbare achtergestelde leningen', '1', '1701', '0');
INSERT INTO `0_chart_types` VALUES ('1710', 'Converteerbare niet-achtergestelde oblig.leningen', '1', '1710', '0');
INSERT INTO `0_chart_types` VALUES ('1711', 'Niet-converteerb. niet-achtergestelde oblig.lening', '1', '1711', '0');
INSERT INTO `0_chart_types` VALUES ('172', 'Leasingschulden en soortgelijke schulden', '1', '172', '0');
INSERT INTO `0_chart_types` VALUES ('173', 'Schulden op rekening', '1', '173', '0');
INSERT INTO `0_chart_types` VALUES ('1731', 'Promessen', '1', '1731', '0');
INSERT INTO `0_chart_types` VALUES ('1732', 'Acceptkredieten', '1', '1732', '0');
INSERT INTO `0_chart_types` VALUES ('174', 'Overige leningen', '1', '174', '0');
INSERT INTO `0_chart_types` VALUES ('175', 'Handelsschulden: leveranciers', '1', '175', '0');
INSERT INTO `0_chart_types` VALUES ('1751', 'Handelsschulden: te betalen wissels', '1', '1751', '0');
INSERT INTO `0_chart_types` VALUES ('176', 'Ontvangen vooruitbetalingen op bestellingen', '1', '176', '0');
INSERT INTO `0_chart_types` VALUES ('178', 'Borgtochten ontvangen in contanten', '1', '178', '0');
INSERT INTO `0_chart_types` VALUES ('179', 'Permanente voorschotten bestuurders', '1', '179', '0');


INSERT INTO `0_chart_types` VALUES ('19', 'Voorschot op de verdeling van het netto-actief', '1', '19', '0');
INSERT INTO `0_chart_types` VALUES ('20', 'Kosten van oprichting en kapitaalsverhoging', '2', '20', '0');
INSERT INTO `0_chart_types` VALUES ('200', 'Geboekte afschr. oprichtingskosten en kapitaalverh', '2', '200', '0');
INSERT INTO `0_chart_types` VALUES ('201', 'Kosten bij uitgifte van leningen en disagio', '2', '201', '0');

INSERT INTO `0_chart_types` VALUES ('202', 'Overige oprichtingskosten', '2', '202', '0');

INSERT INTO `0_chart_types` VALUES ('204', 'Herstructureringskosten', '2', '204', '0');

INSERT INTO `0_chart_types` VALUES ('21', 'Kosten van onderzoek en ontwikkeling', '2', '21', '0');
INSERT INTO `0_chart_types` VALUES ('210', 'Geboekte afschr. kosten onderzoek en ontwikkeling', '2', '210', '0');
INSERT INTO `0_chart_types` VALUES ('211', 'Concessie, octrooien, licenties, know-how, merken', '2', '211', '0');

INSERT INTO `0_chart_types` VALUES ('212', 'Goodwill', '2', '212', '0');

INSERT INTO `0_chart_types` VALUES ('213', 'Vooruitbetalingen', '2', '213', '0');

INSERT INTO `0_chart_types` VALUES ('22', 'Terreinen', '2', '22', '0');
INSERT INTO `0_chart_types` VALUES ('220', 'Geboekte MW terreinen', '2', '220', '0');

INSERT INTO `0_chart_types` VALUES ('221', 'Gebouwen', '2', '221', '0');


INSERT INTO `0_chart_types` VALUES ('222', 'Bebouwde terreinen', '2', '222', '0');


INSERT INTO `0_chart_types` VALUES ('223', 'Overige zakelijke rechten op onroerende goederen', '2', '223', '0');


INSERT INTO `0_chart_types` VALUES ('23', 'Technische installaties', '2', '23', '0');











INSERT INTO `0_chart_types` VALUES ('24', 'Meubilair en materieel', '2', '24', '0');








INSERT INTO `0_chart_types` VALUES ('250', 'Terreinen en gebouwen in leasing', '2', '250', '0');


INSERT INTO `0_chart_types` VALUES ('251', 'Installaties, machines en uitrusting in leasing', '2', '251', '0');


INSERT INTO `0_chart_types` VALUES ('252', 'Meubilair in leasing', '2', '252', '0');








INSERT INTO `0_chart_types` VALUES ('26', 'Overige materiele vaste activa', '2', '26', '0');


INSERT INTO `0_chart_types` VALUES ('27', 'Vaste activa in aanbouw', '2', '27', '0');





INSERT INTO `0_chart_types` VALUES ('2800', 'Deelnemingen in verbonden ondernemingen', '2', '2800', '0');
INSERT INTO `0_chart_types` VALUES ('2801', 'Nog te storten bedragen (-)', '2', '2801', '0');
INSERT INTO `0_chart_types` VALUES ('2810', 'Vorderingen op verbonden ondernemingen', '2', '2810', '0');
INSERT INTO `0_chart_types` VALUES ('2811', 'Te innen wissels', '2', '2811', '0');
INSERT INTO `0_chart_types` VALUES ('2812', 'Vastrentende effecten', '2', '2812', '0');
INSERT INTO `0_chart_types` VALUES ('2817', 'Dubieuze debiteuren', '2', '2817', '0');
INSERT INTO `0_chart_types` VALUES ('2820', 'Deelneming in onderneming met deelnemingsverhoud.', '2', '2820', '0');
INSERT INTO `0_chart_types` VALUES ('2821', 'Nog te storten bedragen (-)', '2', '2821', '0');
INSERT INTO `0_chart_types` VALUES ('2830', 'Vorderingen op rekening', '2', '2830', '0');
INSERT INTO `0_chart_types` VALUES ('2831', 'Te innen wissels', '2', '2831', '0');
INSERT INTO `0_chart_types` VALUES ('2832', 'Vastrentende effecten', '2', '2832', '0');
INSERT INTO `0_chart_types` VALUES ('2837', 'Dubieuze debiteuren', '2', '2837', '0');
INSERT INTO `0_chart_types` VALUES ('2840', 'Andere aandelen', '2', '2840', '0');
INSERT INTO `0_chart_types` VALUES ('2841', 'Nog te storten bedragen (-)', '2', '2841', '0');
INSERT INTO `0_chart_types` VALUES ('2850', 'Vorderingen op rekening', '2', '2850', '0');
INSERT INTO `0_chart_types` VALUES ('2851', 'Te innen wissels', '2', '2851', '0');
INSERT INTO `0_chart_types` VALUES ('2852', 'Vastrentende effecten', '2', '2852', '0');
INSERT INTO `0_chart_types` VALUES ('2857', 'Dubieuze debiteuren', '2', '2857', '0');
INSERT INTO `0_chart_types` VALUES ('288', 'Borgtochten betaald in contanten', '2', '288', '0');
INSERT INTO `0_chart_types` VALUES ('2900', 'Handelsdebiteuren', '2', '2900', '0');
INSERT INTO `0_chart_types` VALUES ('2901', 'Te innen wissels', '2', '2901', '0');
INSERT INTO `0_chart_types` VALUES ('2906', 'Vooruitbetalingen', '2', '2906', '0');
INSERT INTO `0_chart_types` VALUES ('2907', 'Dubieuze debiteuren', '2', '2907', '0');
INSERT INTO `0_chart_types` VALUES ('2910', 'Vorderingen op rekening', '2', '2910', '0');
INSERT INTO `0_chart_types` VALUES ('2911', 'Te innen wissels', '2', '2911', '0');
INSERT INTO `0_chart_types` VALUES ('2917', 'Dubieuze debiteuren', '2', '2917', '0');
INSERT INTO `0_chart_types` VALUES ('300', 'Grondstoffen', '3', '300', '0');
INSERT INTO `0_chart_types` VALUES ('310', 'Hulpstoffen', '3', '310', '0');
INSERT INTO `0_chart_types` VALUES ('320', 'Goederen in bewerking', '3', '320', '0');
INSERT INTO `0_chart_types` VALUES ('330', 'Gereed product', '3', '330', '0');
INSERT INTO `0_chart_types` VALUES ('340', 'Handelsgoederen', '3', '340', '0');
INSERT INTO `0_chart_types` VALUES ('350', 'Onroerende goederen bestemd voor verkoop', '3', '350', '0');
INSERT INTO `0_chart_types` VALUES ('360', 'Vooruitbetalingen op voorraadinkopen', '3', '360', '0');
INSERT INTO `0_chart_types` VALUES ('370', 'Bestellingen in uitvoering', '3', '370', '0');
INSERT INTO `0_chart_types` VALUES ('371', 'Toegerekende winst', '3', '371', '0');
INSERT INTO `0_chart_types` VALUES ('400', 'Klanten', '40', '400', '0');
INSERT INTO `0_chart_types` VALUES ('401', 'Te innen wissels', '40', '401', '0');
INSERT INTO `0_chart_types` VALUES ('404', 'Te innen opbrengsten', '40', '404', '0');
INSERT INTO `0_chart_types` VALUES ('40', 'Hangende domiciliëringsopdrachten', '40', '40', '0');
INSERT INTO `0_chart_types` VALUES ('406', 'Vooruitbetalingen', '40', '406', '0');
INSERT INTO `0_chart_types` VALUES ('407', 'Dubieuze debiteuren', '40', '407', '0');
INSERT INTO `0_chart_types` VALUES ('408', 'Openingsrekening klanten', '40', '408', '0');
INSERT INTO `0_chart_types` VALUES ('409', 'Geboekte waardeverminderingen (-)', '40', '409', '0');
INSERT INTO `0_chart_types` VALUES ('410', 'Opgevraagd, niet gestort kapitaal', '41', '410', '0');
INSERT INTO `0_chart_types` VALUES ('411', 'R/C BTW', '41', '411', '0');










INSERT INTO `0_chart_types` VALUES ('412', 'Terug te vorderen belastingen en voorheffingen', '41', '412', '0');


INSERT INTO `0_chart_types` VALUES ('4128', 'Terug te vorderen buitenlandse belastingen', '41', '4128', '0');
INSERT INTO `0_chart_types` VALUES ('414', 'Te innen opbrengsten', '41', '414', '0');
INSERT INTO `0_chart_types` VALUES ('416', 'Diverse vorderingen', '41', '416', '0');
INSERT INTO `0_chart_types` VALUES ('417', 'Dubieuze debiteuren', '41', '417', '0');
INSERT INTO `0_chart_types` VALUES ('418', 'Borgtochten betaald in contanten', '41', '418', '0');
INSERT INTO `0_chart_types` VALUES ('419', 'Geboekte waardeverminderingen (-)', '41', '419', '0');
INSERT INTO `0_chart_types` VALUES ('4200', 'Converteerbare achtergestelde leningen', '42', '4200', '0');
INSERT INTO `0_chart_types` VALUES ('430', 'Kredietinstel.: leningen op rekening vaste termijn', '43', '430', '0');
INSERT INTO `0_chart_types` VALUES ('431', 'Kredietinstel.: promessen', '43', '431', '0');
INSERT INTO `0_chart_types` VALUES ('432', 'Kredietinstel.: acceptkredieten', '43', '432', '0');
INSERT INTO `0_chart_types` VALUES ('433', 'Kredietinstel.: schulden in rekening courant', '43', '433', '0');
INSERT INTO `0_chart_types` VALUES ('439', 'Overige leningen', '43', '439', '0');
INSERT INTO `0_chart_types` VALUES ('440', 'Leveranciers', '44', '440', '0');
INSERT INTO `0_chart_types` VALUES ('441', 'Te betalen wissels', '44', '441', '0');
INSERT INTO `0_chart_types` VALUES ('444', 'Te ontvangen facturen', '44', '444', '0');
INSERT INTO `0_chart_types` VALUES ('448', 'Openingsrekening leveranciers', '44', '448', '0');
INSERT INTO `0_chart_types` VALUES ('4500', 'Geraamd bedrag belastingsschulden', '45', '4500', '0');
INSERT INTO `0_chart_types` VALUES ('4505', 'Geraamd bedrag Belgische winstbelasting en taks', '45', '4505', '0');
INSERT INTO `0_chart_types` VALUES ('4508', 'Geraamd bedrag buitenlandse winstbelasting en taks', '45', '4508', '0');
INSERT INTO `0_chart_types` VALUES ('451', 'R/C BTW', '45', '451', '0');










INSERT INTO `0_chart_types` VALUES ('4520', 'Te betalen belastingen en taksen', '45', '4520', '0');
INSERT INTO `0_chart_types` VALUES ('4521', 'Belgische winstbelastingen', '45', '4521', '0');
INSERT INTO `0_chart_types` VALUES ('4525', 'Andere Belgische belastingen en taksen', '45', '4525', '0');
INSERT INTO `0_chart_types` VALUES ('4528', 'Buitenlandse belastingen en taksen', '45', '4528', '0');
INSERT INTO `0_chart_types` VALUES ('453', 'Ingehouden bedrijfsvoorheffingen', '45', '453', '0');
INSERT INTO `0_chart_types` VALUES ('454', 'Rijksdienst voor Sociale Zekerheid (RSZ)', '45', '454', '0');
INSERT INTO `0_chart_types` VALUES ('455', 'Bezoldigingen', '45', '455', '0');

INSERT INTO `0_chart_types` VALUES ('456', 'Provisie vakantiegeld', '45', '456', '0');
INSERT INTO `0_chart_types` VALUES ('459', 'Andere sociale schulden', '45', '459', '0');
INSERT INTO `0_chart_types` VALUES ('46', 'Ontvangen vooruitbetalingen op bestellingen', '46', '46', '0');
INSERT INTO `0_chart_types` VALUES ('470', 'Dividenden en tantièmes over vorige boekjaren', '47', '470', '0');
INSERT INTO `0_chart_types` VALUES ('471', 'Dividenden over het boekjaar', '47', '471', '0');
INSERT INTO `0_chart_types` VALUES ('472', 'Tantièmes over het boekjaar', '47', '472', '0');
INSERT INTO `0_chart_types` VALUES ('473', 'Andere rechthebbenden', '47', '473', '0');
INSERT INTO `0_chart_types` VALUES ('480', 'Vervallen obligaties en coupons', '48', '480', '0');
INSERT INTO `0_chart_types` VALUES ('483', 'R/C bestuurder-zaakvoerder', '48', '483', '0');


INSERT INTO `0_chart_types` VALUES ('485', 'Hangende betaalopdrachten', '48', '485', '0');
INSERT INTO `0_chart_types` VALUES ('488', 'Borgtochten ontvangen in contanten', '48', '488', '0');
INSERT INTO `0_chart_types` VALUES ('489', 'Andere diverse schulden', '48', '489', '0');



INSERT INTO `0_chart_types` VALUES ('490', 'Af te grenzen kosten', '490', '490', '0');

INSERT INTO `0_chart_types` VALUES ('491', 'Verkregen opbrengsten', '491', '491', '0');

INSERT INTO `0_chart_types` VALUES ('492', 'Toe te rekenen kosten', '492', '492', '0');
INSERT INTO `0_chart_types` VALUES ('493', 'Af te grenzen opbrengsten', '493', '493', '0');


INSERT INTO `0_chart_types` VALUES ('50', 'Eigen aandelen', '5', '50', '0');
INSERT INTO `0_chart_types` VALUES ('510', 'Aanschaffingswaarde aandelen', '5', '510', '0');

INSERT INTO `0_chart_types` VALUES ('511', 'Niet opgevraagde bedragen (-)', '5', '511', '0');
INSERT INTO `0_chart_types` VALUES ('519', 'Geboekte waardeverminderingen (-)', '5', '519', '0');
INSERT INTO `0_chart_types` VALUES ('520', 'Aanschaffingswaarde', '5', '520', '0');
INSERT INTO `0_chart_types` VALUES ('529', 'Geboekte waardeverminderingen (-)', '5', '529', '0');
INSERT INTO `0_chart_types` VALUES ('539', 'Geboekte waardeverminderingen (-)', '5', '539', '0');
INSERT INTO `0_chart_types` VALUES ('54', 'Te incasseren vervallen waarde', '5', '54', '0');
INSERT INTO `0_chart_types` VALUES ('550', 'XCXVXCV zichtrekening', '5', '550', '0');

INSERT INTO `0_chart_types` VALUES ('58', 'Interne overboekingen', '5', '58', '0');

INSERT INTO `0_chart_types` VALUES ('60', 'Aankopen van grondstoffen', '6', '60', '0');
INSERT INTO `0_chart_types` VALUES ('601', 'Aankopen van hulpstoffen', '6', '601', '0');
INSERT INTO `0_chart_types` VALUES ('603', 'Algemene onderaannemingen', '6', '603', '0');
INSERT INTO `0_chart_types` VALUES ('604', 'Aankopen van handelsgoederen', '6', '604', '0');
INSERT INTO `0_chart_types` VALUES ('605', 'Aankopen van onroerende goederen voor verkoop', '6', '605', '0');
INSERT INTO `0_chart_types` VALUES ('608', 'Ontvangen korting, ristornos en rabatten', '6', '608', '0');
INSERT INTO `0_chart_types` VALUES ('6090', 'Voorraadwijziging grondstoffen', '6', '6090', '0');
INSERT INTO `0_chart_types` VALUES ('6091', 'Voorraadwijziging hulpstoffen', '6', '6091', '0');
INSERT INTO `0_chart_types` VALUES ('6094', 'Voorraadwijziging handelsgoederen', '6', '6094', '0');
INSERT INTO `0_chart_types` VALUES ('6095', 'Voorraadwijziging gekochte onroer. goed. verkoop', '6', '6095', '0');
INSERT INTO `0_chart_types` VALUES ('61', 'Huurlasten terreinen', '6', '61', '0');








































































































INSERT INTO `0_chart_types` VALUES ('6201', 'Directiepersoneel', '6', '6201', '0');

INSERT INTO `0_chart_types` VALUES ('6202', 'Bedienden', '6', '6202', '0');

INSERT INTO `0_chart_types` VALUES ('6203', 'Arbeiders', '6', '6203', '0');

INSERT INTO `0_chart_types` VALUES ('6205', 'Bezoldiging VAA bedrijfswagens bedienden', '6', '6205', '0');

INSERT INTO `0_chart_types` VALUES ('6206', 'Bezoldigign aangegeven voordelen van alle aard', '6', '6206', '0');
INSERT INTO `0_chart_types` VALUES ('6207', 'Andere personeelskosten', '6', '6207', '0');
INSERT INTO `0_chart_types` VALUES ('621', 'Werkgeversbijdrage RSZ', '6', '621', '0');

INSERT INTO `0_chart_types` VALUES ('622', 'Werkgeversbijdrage bovenwettelijke verzekering', '6', '622', '0');


INSERT INTO `0_chart_types` VALUES ('623', 'Andere personeelskosten', '6', '623', '0');















INSERT INTO `0_chart_types` VALUES ('6240', 'Rust- en overlevingspensioenen', '6', '6240', '0');
INSERT INTO `0_chart_types` VALUES ('6241', 'Rust- en overlevingspensioenen', '6', '6241', '0');
INSERT INTO `0_chart_types` VALUES ('6300', 'Afschrijving oprichtingskosten en kap.verhoging', '6', '6300', '0');




INSERT INTO `0_chart_types` VALUES ('6301', 'Afschrijving kosten van onderzoek en ontwikkeling', '6', '6301', '0');



INSERT INTO `0_chart_types` VALUES ('6302', 'Afschrijving materiële vaste activa', '6', '6302', '0');


























INSERT INTO `0_chart_types` VALUES ('6308', 'Waardevermind. kosten onderzoek en ontwikkeling', '6', '6308', '0');



INSERT INTO `0_chart_types` VALUES ('6309', 'Waardevermindering materiële vaste activa', '6', '6309', '0');

INSERT INTO `0_chart_types` VALUES ('6310', 'Toevoeg Waardeverm grondstoffen', '6', '6310', '0');






INSERT INTO `0_chart_types` VALUES ('6311', 'Terugneming Waardeverm grondstoffen', '6', '6311', '0');






INSERT INTO `0_chart_types` VALUES ('6320', 'Toevoeg Waardeverm bestel. in uitvoering', '6', '6320', '0');
INSERT INTO `0_chart_types` VALUES ('6321', 'Terugneming Waardeverm bestel. in uitvoering', '6', '6321', '0');
INSERT INTO `0_chart_types` VALUES ('6330', 'Toevoeg. waardevermind. op handelsvordering >1jaar', '6', '6330', '0');
INSERT INTO `0_chart_types` VALUES ('6331', 'Terugn. waardevermind. op handelsvordering >1jaar', '6', '6331', '0');
INSERT INTO `0_chart_types` VALUES ('6340', 'Toevoeg. waardevermind. op handelsvordering <1jaar', '6', '6340', '0');
INSERT INTO `0_chart_types` VALUES ('6341', 'Terugn. waardevermind. op handelsvordering <1jaar', '6', '6341', '0');
INSERT INTO `0_chart_types` VALUES ('6350', 'Toevoeging voorziening pensioenen en soortgelijke', '6', '6350', '0');
INSERT INTO `0_chart_types` VALUES ('6351', 'Terugname voorziening pensioenen en soortgelijke', '6', '6351', '0');
INSERT INTO `0_chart_types` VALUES ('6360', 'Toevoeging voorziening grote herstel. en onderhoud', '6', '6360', '0');
INSERT INTO `0_chart_types` VALUES ('6361', 'Terugname voorziening grote herstel. en onderhoud', '6', '6361', '0');
INSERT INTO `0_chart_types` VALUES ('6370', 'Toevoeging voorziening milieuverplichtingen', '6', '6370', '0');
INSERT INTO `0_chart_types` VALUES ('6371', 'Terugname voorziening andere risicos en kosten', '6', '6371', '0');
INSERT INTO `0_chart_types` VALUES ('6380', 'Toevoeging voorziening andere risicos en kosten', '6', '6380', '0');
INSERT INTO `0_chart_types` VALUES ('6381', 'Terugname voorziening andere risicos en kosten', '6', '6381', '0');
INSERT INTO `0_chart_types` VALUES ('640', 'Milieubelastingen', '6', '640', '0');









INSERT INTO `0_chart_types` VALUES ('641', 'Minwaarde op de courante realisatie vaste activa', '6', '641', '0');
INSERT INTO `0_chart_types` VALUES ('642', 'Minwaarde op de realisatie van handelsvordering', '6', '642', '0');
INSERT INTO `0_chart_types` VALUES ('643', 'Niet aftrekbare BTW', '6', '643', '0');
INSERT INTO `0_chart_types` VALUES ('644', 'Aftrekbare boeten', '6', '644', '0');
INSERT INTO `0_chart_types` VALUES ('645', 'Niet aftrekbare boeten', '6', '645', '0');
INSERT INTO `0_chart_types` VALUES ('648', 'Diverse bedrijfskosten', '6', '648', '0');
INSERT INTO `0_chart_types` VALUES ('649', 'Als herstructureringskosten geactiveerde kosten(-)', '6', '649', '0');
INSERT INTO `0_chart_types` VALUES ('6500', 'Rente, commissies en kosten verbonden aan schulden', '6', '6500', '0');
INSERT INTO `0_chart_types` VALUES ('6501', 'Afschrijving van kosten bij uitgifte van leningen', '6', '6501', '0');
INSERT INTO `0_chart_types` VALUES ('6502', 'Andere kosten van schulden', '6', '6502', '0');
INSERT INTO `0_chart_types` VALUES ('6503', 'Geactiveerde intercalaire intresten (-)', '6', '6503', '0');
INSERT INTO `0_chart_types` VALUES ('6510', 'Toevoeging waardevermind. op vlottende activa', '6', '6510', '0');
INSERT INTO `0_chart_types` VALUES ('6511', 'Terugname waardevermind. op vlottende activa', '6', '6511', '0');
INSERT INTO `0_chart_types` VALUES ('652', 'Minderwaarden op realisatie van vlottende activa', '6', '652', '0');
INSERT INTO `0_chart_types` VALUES ('653', 'Discontokosten op vorderingen', '6', '653', '0');
INSERT INTO `0_chart_types` VALUES ('654', 'Wisselresultaten', '6', '654', '0');
INSERT INTO `0_chart_types` VALUES ('655', 'Nadelige koersverschillen', '6', '655', '0');
INSERT INTO `0_chart_types` VALUES ('6560', 'Toevoeging voorziening met financieel karakter', '6', '6560', '0');
INSERT INTO `0_chart_types` VALUES ('6561', 'Terugname voorziening met financieel karakter', '6', '6561', '0');
INSERT INTO `0_chart_types` VALUES ('657', 'Toegestane betalingskortingen', '6', '657', '0');

INSERT INTO `0_chart_types` VALUES ('658', 'Bankonkosten', '6', '658', '0');

INSERT INTO `0_chart_types` VALUES ('659', 'Als herstructueringskosten geact. fin kosten (-)', '6', '659', '0');
INSERT INTO `0_chart_types` VALUES ('6600', 'Uitz Afs Wrdever. oprichtingskosten & kap. verh.', '6', '6600', '0');




INSERT INTO `0_chart_types` VALUES ('6601', 'Uitz Afs Wrdever. kosten onderzoek en ontwikkeling', '6', '6601', '0');



INSERT INTO `0_chart_types` VALUES ('6602', 'Uitz Afs Wrdever. terreinen', '6', '6602', '0');

















INSERT INTO `0_chart_types` VALUES ('661', 'Waardeverminderingen op financiele vaste activa', '6', '661', '0');
INSERT INTO `0_chart_types` VALUES ('6620', 'Provisie niet-recurrente bedrijfskosten', '6', '6620', '0');
INSERT INTO `0_chart_types` VALUES ('6621', 'Provisie niet-recurrente financiele kosten', '6', '6621', '0');
INSERT INTO `0_chart_types` VALUES ('663', 'Minderwaarde op de realisatie van IVA en MVA', '6', '663', '0');

INSERT INTO `0_chart_types` VALUES ('664', 'Andere niet-recurrente bedrijfskosten', '6', '664', '0');
INSERT INTO `0_chart_types` VALUES ('668', 'Andere niet-recurrente financiele kosten', '6', '668', '0');
INSERT INTO `0_chart_types` VALUES ('669', 'Geact. niet-recurrente bedrijfskosten (-)', '6', '669', '0');
INSERT INTO `0_chart_types` VALUES ('669', 'Geact. niet-recurrente financiele kosten (-)', '6', '669', '0');
INSERT INTO `0_chart_types` VALUES ('6700', 'Voorafbetaling belastingen', '6', '6700', '0');
INSERT INTO `0_chart_types` VALUES ('6700', 'Roerende voorheffing', '6', '6700', '0');
INSERT INTO `0_chart_types` VALUES ('6701', 'Geactiveerde overschotten (-)', '6', '6701', '0');
INSERT INTO `0_chart_types` VALUES ('6702', 'Geraamde belastingen', '6', '6702', '0');
INSERT INTO `0_chart_types` VALUES ('6710', 'Belgische belasting op resultaat vorige boekjaren', '6', '6710', '0');
INSERT INTO `0_chart_types` VALUES ('6711', 'Geraamde belastingsupplementen', '6', '6711', '0');
INSERT INTO `0_chart_types` VALUES ('6712', 'Gevormde fiscale voorzieningen', '6', '6712', '0');
INSERT INTO `0_chart_types` VALUES ('672', 'Buitenlandse belastingen boekjaar', '6', '672', '0');
INSERT INTO `0_chart_types` VALUES ('673', 'Buitenlandse belastingen vorige boekjaren', '6', '673', '0');
INSERT INTO `0_chart_types` VALUES ('68', 'Overboeking naar uitgestelde belasting', '6', '68', '0');
INSERT INTO `0_chart_types` VALUES ('689', 'Overboeking naar belastingvrije reserves', '6', '689', '0');
INSERT INTO `0_chart_types` VALUES ('690', 'Overgedragen verlies vorig boekjaar', '6', '690', '0');
INSERT INTO `0_chart_types` VALUES ('691', 'Toevoeging aan het kapitaal en de uitgiftepremies', '6', '691', '0');
INSERT INTO `0_chart_types` VALUES ('6920', 'Toevoeging aan de wettelijke reserve', '6', '6920', '0');
INSERT INTO `0_chart_types` VALUES ('6921', 'Toevoeging aan de overige reserves', '6', '6921', '0');
INSERT INTO `0_chart_types` VALUES ('693', 'Over te dragen winst', '6', '693', '0');
INSERT INTO `0_chart_types` VALUES ('694', 'Vergoeding van het kapitaal', '6', '694', '0');
INSERT INTO `0_chart_types` VALUES ('695', 'Bestuurders of zaakvoerders', '6', '695', '0');
INSERT INTO `0_chart_types` VALUES ('696', 'Werknemers', '6', '696', '0');
INSERT INTO `0_chart_types` VALUES ('697', 'Andere rechthebbenden', '6', '697', '0');
INSERT INTO `0_chart_types` VALUES ('700', 'Verkopen en dienstprestaties', '7', '700', '0');


INSERT INTO `0_chart_types` VALUES ('708', 'Toegekende korting, ristornos en rabatten (-)', '7', '708', '0');
INSERT INTO `0_chart_types` VALUES ('709', 'Tegenboeking BTW op marge (-)', '7', '709', '0');
INSERT INTO `0_chart_types` VALUES ('712', 'Wijziging in voorraad goederen in bewerking', '7', '712', '0');
INSERT INTO `0_chart_types` VALUES ('713', 'Wijziging in voorraad gereed product', '7', '713', '0');
INSERT INTO `0_chart_types` VALUES ('714', 'Wijziging in voorraad onroerende goederen', '7', '714', '0');
INSERT INTO `0_chart_types` VALUES ('7170', 'Wijziging in best. in uitvoering - aansch.waarde', '7', '7170', '0');
INSERT INTO `0_chart_types` VALUES ('7171', 'Wijziging in best. in uitvoering - toegerek. winst', '7', '7171', '0');
INSERT INTO `0_chart_types` VALUES ('72', 'Geproduceerde vaste activa', '7', '72', '0');
INSERT INTO `0_chart_types` VALUES ('74', 'Bedrijfssubsidies en compenserende bedragen', '7', '74', '0');
INSERT INTO `0_chart_types` VALUES ('741', 'Meerwaarde op courante realisatie mat.vaste activa', '7', '741', '0');
INSERT INTO `0_chart_types` VALUES ('742', 'Meerwaarde op de realisatie van handelsvordering', '7', '742', '0');
INSERT INTO `0_chart_types` VALUES ('743', 'Bijdrage WN maaltijdcheque', '7', '743', '0');

INSERT INTO `0_chart_types` VALUES ('746', 'Recuperatie voordelen alle aard auto 90%', '7', '746', '0');






INSERT INTO `0_chart_types` VALUES ('750', 'Opbrengsten uit financiële vaste activa', '7', '750', '0');
INSERT INTO `0_chart_types` VALUES ('751', 'Opbrengsten uit vlottende activa', '7', '751', '0');
INSERT INTO `0_chart_types` VALUES ('752', 'Meerwaarde op de realisatie van vlottende activa', '7', '752', '0');
INSERT INTO `0_chart_types` VALUES ('753', 'Kapitaalsubsidies', '7', '753', '0');
INSERT INTO `0_chart_types` VALUES ('754', 'Wisselresultaten', '7', '754', '0');
INSERT INTO `0_chart_types` VALUES ('755', 'Voordelige koersverschillen', '7', '755', '0');
INSERT INTO `0_chart_types` VALUES ('757', 'Bekomen betalingskortingen', '7', '757', '0');

INSERT INTO `0_chart_types` VALUES ('758', 'Voordelige afrondingsverschill', '7', '758', '0');
INSERT INTO `0_chart_types` VALUES ('759', 'Diverse financiële opbrengsten', '7', '759', '0');
INSERT INTO `0_chart_types` VALUES ('7600', 'Terugname afschr. en waardvermind. immateriële VA', '7', '7600', '0');
INSERT INTO `0_chart_types` VALUES ('7601', 'Terugname afschr. en waardvermind. materiële VA', '7', '7601', '0');
INSERT INTO `0_chart_types` VALUES ('7602', 'Op oprichtingskosten', '7', '7602', '0');
INSERT INTO `0_chart_types` VALUES ('761', 'Terugname waardevermind. financiële vaste activa', '7', '761', '0');
INSERT INTO `0_chart_types` VALUES ('762', 'Terugn. voorz. niet-recurrente bedrijfskosten', '7', '762', '0');

INSERT INTO `0_chart_types` VALUES ('763', 'Meerwaarde op de realisatie van IVA en  MVA', '7', '763', '0');

INSERT INTO `0_chart_types` VALUES ('764', 'Compensatie afschrijving meerwaarde', '7', '764', '0');
INSERT INTO `0_chart_types` VALUES ('768', 'Andere niet-recurrente bedrijfsopbrengsten', '7', '768', '0');
INSERT INTO `0_chart_types` VALUES ('769', 'Andere niet recurrente financiële opbrengsten', '7', '769', '0');
INSERT INTO `0_chart_types` VALUES ('7710', 'Regularisering van versch. of betaalde belastingen', '7', '7710', '0');
INSERT INTO `0_chart_types` VALUES ('7711', 'Regularisering van geraamde belastingen', '7', '7711', '0');
INSERT INTO `0_chart_types` VALUES ('7712', 'Terugneming fiscale voorzieningen', '7', '7712', '0');
INSERT INTO `0_chart_types` VALUES ('773', 'Buitenlandse belastingen', '7', '773', '0');
INSERT INTO `0_chart_types` VALUES ('780', 'Onttrekking aan de uitgestelde belastingen', '7', '780', '0');
INSERT INTO `0_chart_types` VALUES ('789', 'Onttrekking aan de belastingvrije reserves', '7', '789', '0');
INSERT INTO `0_chart_types` VALUES ('790', 'Overgedragen winst vorig boekjaar', '7', '790', '0');
INSERT INTO `0_chart_types` VALUES ('791', 'Onttrekking aan het kapitaal en de uitgiftepremies', '7', '791', '0');
INSERT INTO `0_chart_types` VALUES ('792', 'Onttrekking aan de reserves', '7', '792', '0');
INSERT INTO `0_chart_types` VALUES ('793', 'Over te dragen verlies', '7', '793', '0');
INSERT INTO `0_chart_types` VALUES ('794', 'Tussenkomst vennoten in het verlies', '7', '794', '0');


### Structure of table `0_comments` ###

DROP TABLE IF EXISTS `0_comments`;

CREATE TABLE `0_comments` (
  `type` int(11) NOT NULL default '0',
  `id` int(11) NOT NULL default '0',
  `date_` date default '0000-00-00',
  `memo_` tinytext,
  KEY `type_and_id` (`type`,`id`)
) ENGINE=InnoDB ;

### Data of table `0_comments` ###


### Structure of table `0_credit_status` ###

DROP TABLE IF EXISTS `0_credit_status`;

CREATE TABLE `0_credit_status` (
  `id` int(11) NOT NULL auto_increment,
  `reason_description` char(100) NOT NULL default '',
  `dissallow_invoices` tinyint(1) NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `reason_description` (`reason_description`)
) ENGINE=MyISAM;

### Data of table `0_credit_status` ###

INSERT INTO `0_credit_status` VALUES
('1', 'Geen bijzonderheden ten aanzien van betaalgedrag', '0', '0'),
('3', 'Geen nieuwe orders totdat oude orders zijn betaald', '1', '0'),
('4', 'Geen orders aannemen!', '1', '0');

### Structure of table `0_crm_categories` ###

DROP TABLE IF EXISTS `0_crm_categories`;

CREATE TABLE `0_crm_categories` (
  `id` int(11) NOT NULL auto_increment COMMENT 'pure technical key',
  `type` varchar(20) NOT NULL COMMENT 'contact type e.g. customer',
  `action` varchar(20) NOT NULL COMMENT 'detailed usage e.g. department',
  `name` varchar(30) NOT NULL COMMENT 'for category selector',
  `description` tinytext NOT NULL COMMENT 'usage description',
  `system` tinyint(1) NOT NULL default '0' COMMENT 'nonzero for core system usage',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `type` (`type`,`action`),
  UNIQUE KEY `type_2` (`type`,`name`)
) ENGINE=InnoDB;

### Data of table `0_crm_categories` ###

INSERT INTO `0_crm_categories` VALUES
('1', 'cust_branch', 'general', 'General', 'General contact data for customer branch (overrides company setting)', '1', '0'),
('2', 'cust_branch', 'invoice', 'Invoices', 'Invoice posting (overrides company setting)', '1', '0'),
('3', 'cust_branch', 'order', 'Orders', 'Order confirmation (overrides company setting)', '1', '0'),
('4', 'cust_branch', 'delivery', 'Deliveries', 'Delivery coordination (overrides company setting)', '1', '0'),
('5', 'customer', 'general', 'Algemeen', 'Algemene contactpersoon', '1', '0'),
('6', 'customer', 'order', 'Verkopen', 'Verkoop contactpersoon', '1', '0'),
('7', 'customer', 'delivery', 'Deliveries', 'Delivery coordination', '1', '0'),
('8', 'customer', 'invoice', 'Administratie', 'Administratieve contactpersoon', '1', '0'),
('9', 'supplier', 'general', 'General', 'General contact data for supplier', '1', '0'),
('10', 'supplier', 'order', 'Orders', 'Order confirmation', '1', '0'),
('11', 'supplier', 'delivery', 'Deliveries', 'Delivery coordination', '1', '0'),
('12', 'supplier', 'invoice', 'Invoices', 'Invoice posting', '1', '0');

### Structure of table `0_crm_contacts` ###

DROP TABLE IF EXISTS `0_crm_contacts`;

CREATE TABLE `0_crm_contacts` (
  `id` int(11) NOT NULL auto_increment,
  `person_id` int(11) NOT NULL default '0' COMMENT 'foreign key to crm_contacts',
  `type` varchar(20) NOT NULL COMMENT 'foreign key to crm_categories',
  `action` varchar(20) NOT NULL COMMENT 'foreign key to crm_categories',
  `entity_id` varchar(11) default NULL COMMENT 'entity id in related class table',
  PRIMARY KEY  (`id`),
  KEY `type` (`type`,`action`)
) ENGINE=InnoDB;

### Data of table `0_crm_contacts` ###

INSERT INTO `0_crm_contacts` VALUES
('1', '1', 'supplier', 'general', '1'),
('2', '2', 'supplier', 'general', '2'),
('3', '3', 'supplier', 'general', '3'),
('4', '4', 'cust_branch', 'general', '1'),
('5', '5', 'supplier', 'general', '4'),
('7', '6', 'customer', 'general', '3'),
('8', '7', 'cust_branch', 'general', '2'),
('9', '8', 'supplier', 'general', '5'),
('10', '1', 'cust_branch', 'general', '3'),
('11', '2', 'supplier', 'general', '6'),
('12', '3', 'supplier', 'general', '7'),
('13', '4', 'cust_branch', 'general', '4');

### Structure of table `0_crm_persons` ###

DROP TABLE IF EXISTS `0_crm_persons`;

CREATE TABLE `0_crm_persons` (
  `id` int(11) NOT NULL auto_increment,
  `ref` varchar(30) NOT NULL,
  `name` varchar(60) NOT NULL,
  `name2` varchar(60) default NULL,
  `address` tinytext,
  `phone` varchar(30) default NULL,
  `phone2` varchar(30) default NULL,
  `fax` varchar(30) default NULL,
  `email` varchar(100) default NULL,
  `lang` char(5) default NULL,
  `notes` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `ref` (`ref`)
) ENGINE=InnoDB;

### Data of table `0_crm_persons` ###

INSERT INTO `0_crm_persons` VALUES
('1', 'Algemene debiteur', 'Algemene debiteur', NULL, 'Algemene debiteur', NULL, NULL, NULL, NULL, NULL, '', '0'),
('2', 'Algemene crediteur', '', NULL, 'Algemene crediteur', NULL, NULL, NULL, NULL, NULL, '', '0'),
('3', 'Algemene leverancier', '', NULL, 'Algemene leverancier', NULL, NULL, NULL, NULL, NULL, '', '0'),
('4', 'Algemene debiteur', 'Algemene debiteur', NULL, 'Algemene debiteur', NULL, NULL, NULL, NULL, NULL, '', '0');

### Structure of table `0_currencies` ###

DROP TABLE IF EXISTS `0_currencies`;

CREATE TABLE `0_currencies` (
  `currency` varchar(60) NOT NULL default '',
  `curr_abrev` char(3) NOT NULL default '',
  `curr_symbol` varchar(10) NOT NULL default '',
  `country` varchar(100) NOT NULL default '',
  `hundreds_name` varchar(15) NOT NULL default '',
  `inactive` tinyint(1) NOT NULL default '0',
  `auto_update` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`curr_abrev`)
) ENGINE=MyISAM ;

### Data of table `0_currencies` ###

INSERT INTO `0_currencies` VALUES
('Euro', 'EUR', '?', 'Belgie', 'Eurocent', '0', '1'),
('USD', 'USD', '$', 'United States', 'Cents', '0', '1'),
('GBP', 'GBP', '£', 'England', 'Pence', '0', '1'),
('JPY', 'JPY', '¥', 'Japan', 'Yen', '0', '1');

### Structure of table `0_cust_allocations` ###

DROP TABLE IF EXISTS `0_cust_allocations`;

CREATE TABLE `0_cust_allocations` (
  `id` int(11) NOT NULL auto_increment,
  `amt` double unsigned default NULL,
  `date_alloc` date NOT NULL default '0000-00-00',
  `trans_no_from` int(11) default NULL,
  `trans_type_from` int(11) default NULL,
  `trans_no_to` int(11) default NULL,
  `trans_type_to` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `From` (`trans_type_from`,`trans_no_from`),
  KEY `To` (`trans_type_to`,`trans_no_to`)
) ENGINE=InnoDB ;

### Data of table `0_cust_allocations` ###


### Structure of table `0_cust_branch` ###

DROP TABLE IF EXISTS `0_cust_branch`;

CREATE TABLE `0_cust_branch` (
  `branch_code` int(11) NOT NULL auto_increment,
  `debtor_no` int(11) NOT NULL default '0',
  `br_name` varchar(60) NOT NULL default '',
  `br_address` tinytext NOT NULL,
  `area` int(11) default NULL,
  `salesman` int(11) NOT NULL default '0',
  `contact_name` varchar(60) NOT NULL default '',
  `default_location` varchar(5) NOT NULL default '',
  `tax_group_id` int(11) default NULL,
  `sales_account` varchar(15) NOT NULL default '',
  `sales_discount_account` varchar(15) NOT NULL default '',
  `receivables_account` varchar(15) NOT NULL default '',
  `payment_discount_account` varchar(15) NOT NULL default '',
  `default_ship_via` int(11) NOT NULL default '1',
  `disable_trans` tinyint(4) NOT NULL default '0',
  `br_post_address` tinytext NOT NULL,
  `group_no` int(11) NOT NULL default '0',
  `notes` tinytext,
  `inactive` tinyint(1) NOT NULL default '0',
  `branch_ref` varchar(30) NOT NULL,
  PRIMARY KEY  (`branch_code`,`debtor_no`),
  KEY `branch_code` (`branch_code`),
  KEY `branch_ref` (`branch_ref`),
  KEY `group_no` (`group_no`)
) ENGINE=MyISAM;

### Data of table `0_cust_branch` ###

INSERT INTO `0_cust_branch` VALUES
('4', '5', 'Algemene debiteur', 'Algemene debiteur', '2', '5', '', 'DEF', '5', '', '', '400000', '', '3', '0', 'Algemene debiteur', '0', 'Algemene debiteur', '0', 'Algemene debiteur');

### Structure of table `0_debtor_trans` ###

DROP TABLE IF EXISTS `0_debtor_trans`;

CREATE TABLE `0_debtor_trans` (
  `trans_no` int(11) unsigned NOT NULL default '0',
  `type` smallint(6) unsigned NOT NULL default '0',
  `version` tinyint(1) unsigned NOT NULL default '0',
  `debtor_no` int(11) unsigned default NULL,
  `branch_code` int(11) NOT NULL default '-1',
  `tran_date` date NOT NULL default '0000-00-00',
  `due_date` date NOT NULL default '0000-00-00',
  `reference` varchar(60) NOT NULL default '',
  `tpe` int(11) NOT NULL default '0',
  `order_` int(11) NOT NULL default '0',
  `ov_amount` double NOT NULL default '0',
  `ov_gst` double NOT NULL default '0',
  `ov_freight` double NOT NULL default '0',
  `ov_freight_tax` double NOT NULL default '0',
  `ov_discount` double NOT NULL default '0',
  `alloc` double NOT NULL default '0',
  `rate` double NOT NULL default '1',
  `ship_via` int(11) default NULL,
  `dimension_id` int(11) NOT NULL default '0',
  `dimension2_id` int(11) NOT NULL default '0',
  `payment_terms` int(11) default NULL,
  PRIMARY KEY  (`type`,`trans_no`),
  KEY `debtor_no` (`debtor_no`,`branch_code`),
  KEY `tran_date` (`tran_date`)
) ENGINE=InnoDB ;

### Data of table `0_debtor_trans` ###


### Structure of table `0_debtor_trans_details` ###

DROP TABLE IF EXISTS `0_debtor_trans_details`;

CREATE TABLE `0_debtor_trans_details` (
  `id` int(11) NOT NULL auto_increment,
  `debtor_trans_no` int(11) default NULL,
  `debtor_trans_type` int(11) default NULL,
  `stock_id` varchar(20) NOT NULL default '',
  `description` tinytext,
  `unit_price` double NOT NULL default '0',
  `unit_tax` double NOT NULL default '0',
  `quantity` double NOT NULL default '0',
  `discount_percent` double NOT NULL default '0',
  `standard_cost` double NOT NULL default '0',
  `qty_done` double NOT NULL default '0',
  `src_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `Transaction` (`debtor_trans_type`,`debtor_trans_no`),
  KEY `src_id` (`src_id`)
) ENGINE=InnoDB ;

### Data of table `0_debtor_trans_details` ###


### Structure of table `0_debtors_master` ###

DROP TABLE IF EXISTS `0_debtors_master`;

CREATE TABLE `0_debtors_master` (
  `debtor_no` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL default '',
  `address` tinytext,
  `tax_id` varchar(55) NOT NULL default '',
  `curr_code` char(3) NOT NULL default '',
  `sales_type` int(11) NOT NULL default '1',
  `dimension_id` int(11) NOT NULL default '0',
  `dimension2_id` int(11) NOT NULL default '0',
  `credit_status` int(11) NOT NULL default '0',
  `payment_terms` int(11) default NULL,
  `discount` double NOT NULL default '0',
  `pymt_discount` double NOT NULL default '0',
  `credit_limit` float NOT NULL default '1000',
  `notes` tinytext,
  `inactive` tinyint(1) NOT NULL default '0',
  `debtor_ref` varchar(30) NOT NULL,
  PRIMARY KEY  (`debtor_no`),
  UNIQUE KEY `debtor_ref` (`debtor_ref`),
  KEY `name` (`name`)
) ENGINE=MyISAM;

### Data of table `0_debtors_master` ###

INSERT INTO `0_debtors_master` VALUES
('5', 'Algemene debiteur', 'Algemene debiteur', '', 'EUR', '1', '0', '0', '1', '3', '0', '0', '1000', 'Algemene debiteur', '0', 'Algemene debiteur');

### Structure of table `0_dimensions` ###

DROP TABLE IF EXISTS `0_dimensions`;

CREATE TABLE `0_dimensions` (
  `id` int(11) NOT NULL auto_increment,
  `reference` varchar(60) NOT NULL default '',
  `name` varchar(60) NOT NULL default '',
  `type_` tinyint(1) NOT NULL default '1',
  `closed` tinyint(1) NOT NULL default '0',
  `date_` date NOT NULL default '0000-00-00',
  `due_date` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `reference` (`reference`),
  KEY `date_` (`date_`),
  KEY `due_date` (`due_date`),
  KEY `type_` (`type_`)
) ENGINE=InnoDB ;

### Data of table `0_dimensions` ###


### Structure of table `0_exchange_rates` ###

DROP TABLE IF EXISTS `0_exchange_rates`;

CREATE TABLE `0_exchange_rates` (
  `id` int(11) NOT NULL auto_increment,
  `curr_code` char(3) NOT NULL default '',
  `rate_buy` double NOT NULL default '0',
  `rate_sell` double NOT NULL default '0',
  `date_` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `curr_code` (`curr_code`,`date_`)
) ENGINE=MyISAM;

### Data of table `0_exchange_rates` ###

### Structure of table `0_fiscal_year` ###

DROP TABLE IF EXISTS `0_fiscal_year`;

CREATE TABLE `0_fiscal_year` (
  `id` int(11) NOT NULL auto_increment,
  `begin` date default '0000-00-00',
  `end` date default '0000-00-00',
  `closed` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `begin` (`begin`),
  UNIQUE KEY `end` (`end`)
) ENGINE=InnoDB;

### Data of table `0_fiscal_year` ###

INSERT INTO `0_fiscal_year` VALUES
('3', '2011-01-01', '2011-12-31', '1'),
('4', '2012-01-01', '2012-12-31', '1'),
('5', '2013-01-01', '2013-12-31', '0');

### Structure of table `0_gl_trans` ###

DROP TABLE IF EXISTS `0_gl_trans`;

CREATE TABLE `0_gl_trans` (
  `counter` int(11) NOT NULL auto_increment,
  `type` smallint(6) NOT NULL default '0',
  `type_no` bigint(16) NOT NULL default '1',
  `tran_date` date NOT NULL default '0000-00-00',
  `account` varchar(15) NOT NULL default '',
  `memo_` tinytext NOT NULL,
  `amount` double NOT NULL default '0',
  `dimension_id` int(11) NOT NULL default '0',
  `dimension2_id` int(11) NOT NULL default '0',
  `person_type_id` int(11) default NULL,
  `person_id` tinyblob,
  PRIMARY KEY  (`counter`),
  KEY `Type_and_Number` (`type`,`type_no`),
  KEY `dimension_id` (`dimension_id`),
  KEY `dimension2_id` (`dimension2_id`),
  KEY `tran_date` (`tran_date`),
  KEY `account_and_tran_date` (`account`,`tran_date`)
) ENGINE=InnoDB ;

### Data of table `0_gl_trans` ###


### Structure of table `0_grn_batch` ###

DROP TABLE IF EXISTS `0_grn_batch`;

CREATE TABLE `0_grn_batch` (
  `id` int(11) NOT NULL auto_increment,
  `supplier_id` int(11) NOT NULL default '0',
  `purch_order_no` int(11) default NULL,
  `reference` varchar(60) NOT NULL default '',
  `delivery_date` date NOT NULL default '0000-00-00',
  `loc_code` varchar(5) default NULL,
  PRIMARY KEY  (`id`),
  KEY `delivery_date` (`delivery_date`),
  KEY `purch_order_no` (`purch_order_no`)
) ENGINE=InnoDB ;

### Data of table `0_grn_batch` ###


### Structure of table `0_grn_items` ###

DROP TABLE IF EXISTS `0_grn_items`;

CREATE TABLE `0_grn_items` (
  `id` int(11) NOT NULL auto_increment,
  `grn_batch_id` int(11) default NULL,
  `po_detail_item` int(11) NOT NULL default '0',
  `item_code` varchar(20) NOT NULL default '',
  `description` tinytext,
  `qty_recd` double NOT NULL default '0',
  `quantity_inv` double NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `grn_batch_id` (`grn_batch_id`)
) ENGINE=InnoDB ;

### Data of table `0_grn_items` ###


### Structure of table `0_groups` ###

DROP TABLE IF EXISTS `0_groups`;

CREATE TABLE `0_groups` (
  `id` smallint(6) unsigned NOT NULL auto_increment,
  `description` varchar(60) NOT NULL default '',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM;

### Data of table `0_groups` ###

INSERT INTO `0_groups` VALUES
('1', 'Klein', '0'),
('2', 'Middel', '0'),
('3', 'Groot', '0');

### Structure of table `0_item_codes` ###

DROP TABLE IF EXISTS `0_item_codes`;

CREATE TABLE `0_item_codes` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `item_code` varchar(20) NOT NULL,
  `stock_id` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL default '',
  `category_id` smallint(6) unsigned NOT NULL,
  `quantity` double NOT NULL default '1',
  `is_foreign` tinyint(1) NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `stock_id` (`stock_id`,`item_code`),
  KEY `item_code` (`item_code`)
) ENGINE=MyISAM;

### Data of table `0_item_codes` ###

INSERT INTO `0_item_codes` VALUES
('23', 'ARBEID', 'ARBEID', 'Arbeid', '11', '1', '0', '0');

### Structure of table `0_item_tax_type_exemptions` ###

DROP TABLE IF EXISTS `0_item_tax_type_exemptions`;

CREATE TABLE `0_item_tax_type_exemptions` (
  `item_tax_type_id` int(11) NOT NULL default '0',
  `tax_type_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`item_tax_type_id`,`tax_type_id`)
) ENGINE=InnoDB ;

### Data of table `0_item_tax_type_exemptions` ###

INSERT INTO `0_item_tax_type_exemptions` VALUES
('9', '8'),
('9', '9'),
('10', '7'),
('10', '9'),
('12', '8'),
('12', '9'),
('13', '7'),
('13', '9'),
('15', '8'),
('15', '9'),
('16', '7'),
('16', '9');

### Structure of table `0_item_tax_types` ###

DROP TABLE IF EXISTS `0_item_tax_types`;

CREATE TABLE `0_item_tax_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(60) NOT NULL default '',
  `exempt` tinyint(1) NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB;

### Data of table `0_item_tax_types` ###

INSERT INTO `0_item_tax_types` VALUES
('9', 'Goederen (21%)', '0', '0'),
('10', 'Goederen (6%)', '0', '0'),
('11', 'Goederen (0%)', '1', '0'),
('12', 'Diensten (21%)', '0', '0'),
('13', 'Diensten (6%)', '0', '0'),
('14', 'Diensten (0%)', '1', '0'),
('15', 'Overige (21%)', '0', '0'),
('16', 'Overige (6%)', '0', '0'),
('17', 'Overige (0%)', '1', '0');

### Structure of table `0_item_units` ###

DROP TABLE IF EXISTS `0_item_units`;

CREATE TABLE `0_item_units` (
  `abbr` varchar(20) NOT NULL,
  `name` varchar(40) NOT NULL,
  `decimals` tinyint(2) NOT NULL,
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`abbr`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM ;

### Data of table `0_item_units` ###

INSERT INTO `0_item_units` VALUES
('st', 'stuk', '0', '0'),
('jaar', 'jaar', '0', '0'),
('  ', '  ', '0', '0'),
('uur', 'uur', '1', '0');

### Structure of table `0_loc_stock` ###

DROP TABLE IF EXISTS `0_loc_stock`;

CREATE TABLE `0_loc_stock` (
  `loc_code` char(5) NOT NULL default '',
  `stock_id` char(20) NOT NULL default '',
  `reorder_level` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`loc_code`,`stock_id`),
  KEY `stock_id` (`stock_id`)
) ENGINE=InnoDB ;

### Data of table `0_loc_stock` ###

INSERT INTO `0_loc_stock` VALUES
('DEF', 'ARBEID', '0');

### Structure of table `0_locations` ###

DROP TABLE IF EXISTS `0_locations`;

CREATE TABLE `0_locations` (
  `loc_code` varchar(5) NOT NULL default '',
  `location_name` varchar(60) NOT NULL default '',
  `delivery_address` tinytext NOT NULL,
  `phone` varchar(30) NOT NULL default '',
  `phone2` varchar(30) NOT NULL default '',
  `fax` varchar(30) NOT NULL default '',
  `email` varchar(100) NOT NULL default '',
  `contact` varchar(30) NOT NULL default '',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`loc_code`)
) ENGINE=MyISAM ;

### Data of table `0_locations` ###

INSERT INTO `0_locations` VALUES
('DEF', 'Algemeen', 'N/A', '', '', '', '', '', '0');

### Structure of table `0_movement_types` ###

DROP TABLE IF EXISTS `0_movement_types`;

CREATE TABLE `0_movement_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(60) NOT NULL default '',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM;

### Data of table `0_movement_types` ###

INSERT INTO `0_movement_types` VALUES
('1', 'Correctie voorraad', '0');

### Structure of table `0_payment_terms` ###

DROP TABLE IF EXISTS `0_payment_terms`;

CREATE TABLE `0_payment_terms` (
  `terms_indicator` int(11) NOT NULL auto_increment,
  `terms` char(80) NOT NULL default '',
  `days_before_due` smallint(6) NOT NULL default '0',
  `day_in_following_month` smallint(6) NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`terms_indicator`),
  UNIQUE KEY `terms` (`terms`)
) ENGINE=MyISAM;

### Data of table `0_payment_terms` ###

INSERT INTO `0_payment_terms` VALUES
('1', '60 dagen', '60', '0', '0'),
('2', '30 dagen', '30', '0', '0'),
('3', '14 dagen', '14', '0', '0'),
('4', 'Contant', '0', '0', '0'),
('5', 'Vooruitbetaling', '-1', '0', '0'),
('6', 'Incasso', '-1', '0', '0');

### Structure of table `0_prices` ###

DROP TABLE IF EXISTS `0_prices`;

CREATE TABLE `0_prices` (
  `id` int(11) NOT NULL auto_increment,
  `stock_id` varchar(20) NOT NULL default '',
  `sales_type_id` int(11) NOT NULL default '0',
  `curr_abrev` char(3) NOT NULL default '',
  `price` double NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `price` (`stock_id`,`sales_type_id`,`curr_abrev`)
) ENGINE=MyISAM;

### Data of table `0_prices` ###

INSERT INTO `0_prices` VALUES
('25', 'ARBEID', '3', 'EUR', '50'),
('24', 'ARBEID', '1', 'EUR', '50');

### Structure of table `0_print_profiles` ###

DROP TABLE IF EXISTS `0_print_profiles`;

CREATE TABLE `0_print_profiles` (
  `id` smallint(6) unsigned NOT NULL auto_increment,
  `profile` varchar(30) NOT NULL,
  `report` varchar(5) default NULL,
  `printer` tinyint(3) unsigned default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `profile` (`profile`,`report`)
) ENGINE=MyISAM;

### Data of table `0_print_profiles` ###

INSERT INTO `0_print_profiles` VALUES
('11', 'Standaard profiel', NULL, '0');

### Structure of table `0_printers` ###

DROP TABLE IF EXISTS `0_printers`;

CREATE TABLE `0_printers` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  `description` varchar(60) NOT NULL,
  `queue` varchar(20) NOT NULL,
  `host` varchar(40) NOT NULL,
  `port` smallint(11) unsigned NOT NULL,
  `timeout` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM;

### Data of table `0_printers` ###


### Structure of table `0_purch_data` ###

DROP TABLE IF EXISTS `0_purch_data`;

CREATE TABLE `0_purch_data` (
  `supplier_id` int(11) NOT NULL default '0',
  `stock_id` char(20) NOT NULL default '',
  `price` double NOT NULL default '0',
  `suppliers_uom` char(50) NOT NULL default '',
  `conversion_factor` double NOT NULL default '1',
  `supplier_description` char(50) NOT NULL default '',
  PRIMARY KEY  (`supplier_id`,`stock_id`)
) ENGINE=MyISAM ;

### Data of table `0_purch_data` ###


### Structure of table `0_purch_order_details` ###

DROP TABLE IF EXISTS `0_purch_order_details`;

CREATE TABLE `0_purch_order_details` (
  `po_detail_item` int(11) NOT NULL auto_increment,
  `order_no` int(11) NOT NULL default '0',
  `item_code` varchar(20) NOT NULL default '',
  `description` tinytext,
  `delivery_date` date NOT NULL default '0000-00-00',
  `qty_invoiced` double NOT NULL default '0',
  `unit_price` double NOT NULL default '0',
  `act_price` double NOT NULL default '0',
  `std_cost_unit` double NOT NULL default '0',
  `quantity_ordered` double NOT NULL default '0',
  `quantity_received` double NOT NULL default '0',
  PRIMARY KEY  (`po_detail_item`),
  KEY `order` (`order_no`,`po_detail_item`)
) ENGINE=InnoDB ;

### Data of table `0_purch_order_details` ###


### Structure of table `0_purch_orders` ###

DROP TABLE IF EXISTS `0_purch_orders`;

CREATE TABLE `0_purch_orders` (
  `order_no` int(11) NOT NULL auto_increment,
  `supplier_id` int(11) NOT NULL default '0',
  `comments` tinytext,
  `ord_date` date NOT NULL default '0000-00-00',
  `reference` tinytext NOT NULL,
  `requisition_no` tinytext,
  `into_stock_location` varchar(5) NOT NULL default '',
  `delivery_address` tinytext NOT NULL,
  `total` double NOT NULL default '0',
  `tax_included` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`order_no`),
  KEY `ord_date` (`ord_date`)
) ENGINE=InnoDB ;

### Data of table `0_purch_orders` ###


### Structure of table `0_quick_entries` ###

DROP TABLE IF EXISTS `0_quick_entries`;

CREATE TABLE `0_quick_entries` (
  `id` smallint(6) unsigned NOT NULL auto_increment,
  `type` tinyint(1) NOT NULL default '0',
  `description` varchar(60) NOT NULL,
  `base_amount` double NOT NULL default '0',
  `base_desc` varchar(60) default NULL,
  `bal_type` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `description` (`description`)
) ENGINE=MyISAM;

### Data of table `0_quick_entries` ###


### Structure of table `0_quick_entry_lines` ###

DROP TABLE IF EXISTS `0_quick_entry_lines`;

CREATE TABLE `0_quick_entry_lines` (
  `id` smallint(6) unsigned NOT NULL auto_increment,
  `qid` smallint(6) unsigned NOT NULL,
  `amount` double default '0',
  `action` varchar(2) NOT NULL,
  `dest_id` varchar(15) NOT NULL default '',
  `dimension_id` smallint(6) unsigned default NULL,
  `dimension2_id` smallint(6) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `qid` (`qid`)
) ENGINE=MyISAM;

### Data of table `0_quick_entry_lines` ###


### Structure of table `0_recurrent_invoices` ###

DROP TABLE IF EXISTS `0_recurrent_invoices`;

CREATE TABLE `0_recurrent_invoices` (
  `id` smallint(6) unsigned NOT NULL auto_increment,
  `description` varchar(60) NOT NULL default '',
  `order_no` int(11) unsigned NOT NULL,
  `debtor_no` int(11) unsigned default NULL,
  `group_no` smallint(6) unsigned default NULL,
  `days` int(11) NOT NULL default '0',
  `monthly` int(11) NOT NULL default '0',
  `begin` date NOT NULL default '0000-00-00',
  `end` date NOT NULL default '0000-00-00',
  `last_sent` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB ;

### Data of table `0_recurrent_invoices` ###


### Structure of table `0_refs` ###

DROP TABLE IF EXISTS `0_refs`;

CREATE TABLE `0_refs` (
  `id` int(11) NOT NULL default '0',
  `type` int(11) NOT NULL default '0',
  `reference` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`,`type`),
  KEY `Type_and_Reference` (`type`,`reference`)
) ENGINE=InnoDB ;

### Data of table `0_refs` ###


### Structure of table `0_sales_order_details` ###

DROP TABLE IF EXISTS `0_sales_order_details`;

CREATE TABLE `0_sales_order_details` (
  `id` int(11) NOT NULL auto_increment,
  `order_no` int(11) NOT NULL default '0',
  `trans_type` smallint(6) NOT NULL default '30',
  `stk_code` varchar(20) NOT NULL default '',
  `description` tinytext,
  `qty_sent` double NOT NULL default '0',
  `unit_price` double NOT NULL default '0',
  `quantity` double NOT NULL default '0',
  `discount_percent` double NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `sorder` (`trans_type`,`order_no`)
) ENGINE=InnoDB ;

### Data of table `0_sales_order_details` ###


### Structure of table `0_sales_orders` ###

DROP TABLE IF EXISTS `0_sales_orders`;

CREATE TABLE `0_sales_orders` (
  `order_no` int(11) NOT NULL,
  `trans_type` smallint(6) NOT NULL default '30',
  `version` tinyint(1) unsigned NOT NULL default '0',
  `type` tinyint(1) NOT NULL default '0',
  `debtor_no` int(11) NOT NULL default '0',
  `branch_code` int(11) NOT NULL default '0',
  `reference` varchar(100) NOT NULL default '',
  `customer_ref` tinytext NOT NULL,
  `comments` tinytext,
  `ord_date` date NOT NULL default '0000-00-00',
  `order_type` int(11) NOT NULL default '0',
  `ship_via` int(11) NOT NULL default '0',
  `delivery_address` tinytext NOT NULL,
  `contact_phone` varchar(30) default NULL,
  `contact_email` varchar(100) default NULL,
  `deliver_to` tinytext NOT NULL,
  `freight_cost` double NOT NULL default '0',
  `from_stk_loc` varchar(5) NOT NULL default '',
  `delivery_date` date NOT NULL default '0000-00-00',
  `payment_terms` int(11) default NULL,
  `total` double NOT NULL default '0',
  PRIMARY KEY  (`trans_type`,`order_no`)
) ENGINE=InnoDB ;

### Data of table `0_sales_orders` ###


### Structure of table `0_sales_pos` ###

DROP TABLE IF EXISTS `0_sales_pos`;

CREATE TABLE `0_sales_pos` (
  `id` smallint(6) unsigned NOT NULL auto_increment,
  `pos_name` varchar(30) NOT NULL,
  `cash_sale` tinyint(1) NOT NULL,
  `credit_sale` tinyint(1) NOT NULL,
  `pos_location` varchar(5) NOT NULL,
  `pos_account` smallint(6) unsigned NOT NULL,
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `pos_name` (`pos_name`)
) ENGINE=MyISAM;

### Data of table `0_sales_pos` ###

INSERT INTO `0_sales_pos` VALUES
('1', 'Standaard POS', '0', '1', 'DEF', '0', '0');

### Structure of table `0_sales_types` ###

DROP TABLE IF EXISTS `0_sales_types`;

CREATE TABLE `0_sales_types` (
  `id` int(11) NOT NULL auto_increment,
  `sales_type` char(50) NOT NULL default '',
  `tax_included` int(1) NOT NULL default '0',
  `factor` double NOT NULL default '1',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sales_type` (`sales_type`)
) ENGINE=MyISAM;

### Data of table `0_sales_types` ###

INSERT INTO `0_sales_types` VALUES
('1', 'Bedrijven', '0', '1', '0'),
('3', 'Particulieren', '1', '1', '0');

### Structure of table `0_salesman` ###

DROP TABLE IF EXISTS `0_salesman`;

CREATE TABLE `0_salesman` (
  `salesman_code` int(11) NOT NULL auto_increment,
  `salesman_name` char(60) NOT NULL default '',
  `salesman_phone` char(30) NOT NULL default '',
  `salesman_fax` char(30) NOT NULL default '',
  `salesman_email` varchar(100) NOT NULL default '',
  `provision` double NOT NULL default '0',
  `break_pt` double NOT NULL default '0',
  `provision2` double NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`salesman_code`),
  UNIQUE KEY `salesman_name` (`salesman_name`)
) ENGINE=MyISAM;

### Data of table `0_salesman` ###

INSERT INTO `0_salesman` VALUES
('5', 'Algemeen', 'Algemeen', 'Algemeen', 'Algemeen', '0', '0', '0', '0');

### Structure of table `0_security_roles` ###

DROP TABLE IF EXISTS `0_security_roles`;

CREATE TABLE `0_security_roles` (
  `id` int(11) NOT NULL auto_increment,
  `role` varchar(30) NOT NULL,
  `description` varchar(50) default NULL,
  `sections` text,
  `areas` text,
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `role` (`role`)
) ENGINE=MyISAM;

### Data of table `0_security_roles` ###

INSERT INTO `0_security_roles` VALUES
('1', 'Level 4 Ondersteuning', 'Level 4 Ondersteuning (alleen inzien)', '768;2816;3072;3328;5632;5888;8192;8448;10752;11008;13312;15872;16128', '257;258;259;260;513;514;515;516;517;518;519;520;521;522;523;524;525;526;773;774;2818;2822;3073;3075;3076;3077;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5640;5889;5891;7937;7938;7939;7940;8193;8194;8450;8451;10497;10753;11009;11010;11012;13057;13313;13315;15617;15618;15619;15620;15621;15622;15623;15624;15628;15625;15626;15627;15629;15873;15882;16129;16130;16131;16132;746596;812132', '0'),
('2', 'Level 3 Boekhouding', 'Level 3 Boekhouding (gebruiker)', '512;768;2816;3072;3328;5376;5632;5888;7936;8192;8448;10496;10752;11008;13312;15616;15872;16128', '257;258;259;260;513;519;520;521;522;523;524;525;769;771;772;773;774;2817;2818;2819;2820;2821;2822;2823;3073;3074;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5636;5637;5638;5639;5640;5889;5891;7937;7938;7939;7940;8193;8194;8195;8196;8197;8449;8450;8451;10497;10753;10754;10755;10756;10757;11009;11010;11012;13057;13313;13314;13315;15617;15618;15619;15620;15621;15622;15623;15624;15625;15626;15873;15874;15875;15876;15877;15878;15879;15880;15881;15882;16129;16130;16131;16132;746596;812132', '0'),
('3', 'Level 1 Beheerder', 'Level 1 Beheerder (systeem administrator)', '256;512;768;2816;3072;3328;5376;5632;5888;7936;8192;8448;10496;10752;11008;13056;13312;15616;15872;16128;746496;812032', '257;258;259;260;513;514;515;516;517;518;519;520;521;522;523;524;525;526;769;770;771;772;773;774;2817;2818;2819;2820;2821;2822;2823;3073;3074;3082;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5636;5637;5641;5638;5639;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8195;8196;8197;8449;8450;8451;10497;10753;10754;10755;10756;10757;11009;11010;11011;11012;13057;13313;13314;13315;15617;15618;15619;15620;15621;15622;15623;15624;15628;15625;15626;15627;15629;15873;15874;15875;15876;15877;15878;15879;15880;15883;15881;15882;15884;16129;16130;16131;16132;746596;812132', '0'),
('4', 'Level 2 Hoofd adm', 'Level 2 Hoofd administratie', '512;768;2816;3072;3328;5376;5632;5888;7936;8192;8448;10496;10752;11008;13312;15616;15872;16128', '257;258;259;260;513;519;520;521;522;523;524;525;769;771;772;773;774;2817;2818;2819;2820;2821;2822;2823;3073;3074;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5636;5637;5638;5639;5640;5889;5891;7937;7938;7939;7940;8193;8194;8195;8196;8197;8449;8450;8451;10497;10753;10754;10755;10756;10757;11009;11010;11012;13057;13313;13314;13315;15617;15618;15619;15620;15621;15622;15623;15624;15625;15626;15873;15874;15875;15876;15877;15878;15879;15880;15881;15882;16129;16130;16131;16132;746596;812132', '0'),
('5', 'Leesrechten', 'Leesrechten', '16128', '257;258;259;260;513;514;515;516;517;518;519;520;521;522;523;524;525;526;769;770;771;772;773;774;2817;2818;2819;2820;2821;2822;2823;3073;3074;3082;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5636;5637;5641;5638;5639;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8195;8196;8197;8449;8450;8451;10497;10753;10754;10755;10756;10757;11009;11010;11011;11012;13057;13313;13314;13315;15617;15618;15619;15620;15621;15622;15623;15624;15628;15625;15626;15627;15629;15873;15874;15875;15876;15877;15878;15879;15880;15883;15881;15882;15884;16132;746596;812132;1205348;1205349;1205350;1598564;1664100;1664101', '0');

### Structure of table `0_shippers` ###

DROP TABLE IF EXISTS `0_shippers`;

CREATE TABLE `0_shippers` (
  `shipper_id` int(11) NOT NULL auto_increment,
  `shipper_name` varchar(60) NOT NULL default '',
  `phone` varchar(30) NOT NULL default '',
  `phone2` varchar(30) NOT NULL default '',
  `contact` tinytext NOT NULL,
  `address` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`shipper_id`),
  UNIQUE KEY `name` (`shipper_name`)
) ENGINE=MyISAM;

### Data of table `0_shippers` ###

INSERT INTO `0_shippers` VALUES
('3', 'Afhalen', 'Afhalen', 'Afhalen', 'Afhalen', 'Afhalen', '0'),
('2', 'TNT Post', '', '', '', '', '0'),
('4', 'Online (dienst)', 'Online', 'Online', 'Online', 'Online', '0');

### Structure of table `0_sql_trail` ###

DROP TABLE IF EXISTS `0_sql_trail`;

CREATE TABLE `0_sql_trail` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `sql` text NOT NULL,
  `result` tinyint(1) NOT NULL,
  `msg` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM ;

### Data of table `0_sql_trail` ###


### Structure of table `0_stock_category` ###

DROP TABLE IF EXISTS `0_stock_category`;

CREATE TABLE `0_stock_category` (
  `category_id` int(11) NOT NULL auto_increment,
  `description` varchar(60) NOT NULL default '',
  `inactive` tinyint(1) NOT NULL default '0',
  `dflt_tax_type` int(11) NOT NULL default '1',
  `dflt_units` varchar(20) NOT NULL default 'each',
  `dflt_mb_flag` char(1) NOT NULL default 'B',
  `dflt_sales_act` varchar(15) NOT NULL default '',
  `dflt_cogs_act` varchar(15) NOT NULL default '',
  `dflt_inventory_act` varchar(15) NOT NULL default '',
  `dflt_adjustment_act` varchar(15) NOT NULL default '',
  `dflt_assembly_act` varchar(15) NOT NULL default '',
  `dflt_dim1` int(11) default NULL,
  `dflt_dim2` int(11) default NULL,
  `dflt_no_sale` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`category_id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM;

### Data of table `0_stock_category` ###

INSERT INTO `0_stock_category` VALUES
('11', 'Algemene dienstverlening', '0', '12', '  ', 'D', '8000', '8120', '3200', '8160', '6000', '0', '0', '0');

### Structure of table `0_stock_master` ###

DROP TABLE IF EXISTS `0_stock_master`;

CREATE TABLE `0_stock_master` (
  `stock_id` varchar(20) NOT NULL default '',
  `category_id` int(11) NOT NULL default '0',
  `tax_type_id` int(11) NOT NULL default '0',
  `description` varchar(200) NOT NULL default '',
  `long_description` tinytext NOT NULL,
  `units` varchar(20) NOT NULL default 'each',
  `mb_flag` char(1) NOT NULL default 'B',
  `sales_account` varchar(15) NOT NULL default '',
  `cogs_account` varchar(15) NOT NULL default '',
  `inventory_account` varchar(15) NOT NULL default '',
  `adjustment_account` varchar(15) NOT NULL default '',
  `assembly_account` varchar(15) NOT NULL default '',
  `dimension_id` int(11) default NULL,
  `dimension2_id` int(11) default NULL,
  `actual_cost` double NOT NULL default '0',
  `last_cost` double NOT NULL default '0',
  `material_cost` double NOT NULL default '0',
  `labour_cost` double NOT NULL default '0',
  `overhead_cost` double NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  `no_sale` tinyint(1) NOT NULL default '0',
  `editable` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`stock_id`)
) ENGINE=InnoDB ;

### Data of table `0_stock_master` ###

INSERT INTO `0_stock_master` VALUES
('ARBEID', '11', '12', 'Arbeid', 'Arbeid', 'uur', 'D', '8000', '8120', '3200', '8160', '6000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1');

### Structure of table `0_stock_moves` ###

DROP TABLE IF EXISTS `0_stock_moves`;

CREATE TABLE `0_stock_moves` (
  `trans_id` int(11) NOT NULL auto_increment,
  `trans_no` int(11) NOT NULL default '0',
  `stock_id` char(20) NOT NULL default '',
  `type` smallint(6) NOT NULL default '0',
  `loc_code` char(5) NOT NULL default '',
  `tran_date` date NOT NULL default '0000-00-00',
  `person_id` int(11) default NULL,
  `price` double NOT NULL default '0',
  `reference` char(40) NOT NULL default '',
  `qty` double NOT NULL default '1',
  `discount_percent` double NOT NULL default '0',
  `standard_cost` double NOT NULL default '0',
  `visible` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`trans_id`),
  KEY `type` (`type`,`trans_no`),
  KEY `Move` (`stock_id`,`loc_code`,`tran_date`)
) ENGINE=InnoDB ;

### Data of table `0_stock_moves` ###


### Structure of table `0_supp_allocations` ###

DROP TABLE IF EXISTS `0_supp_allocations`;

CREATE TABLE `0_supp_allocations` (
  `id` int(11) NOT NULL auto_increment,
  `amt` double unsigned default NULL,
  `date_alloc` date NOT NULL default '0000-00-00',
  `trans_no_from` int(11) default NULL,
  `trans_type_from` int(11) default NULL,
  `trans_no_to` int(11) default NULL,
  `trans_type_to` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `From` (`trans_type_from`,`trans_no_from`),
  KEY `To` (`trans_type_to`,`trans_no_to`)
) ENGINE=InnoDB ;

### Data of table `0_supp_allocations` ###


### Structure of table `0_supp_invoice_items` ###

DROP TABLE IF EXISTS `0_supp_invoice_items`;

CREATE TABLE `0_supp_invoice_items` (
  `id` int(11) NOT NULL auto_increment,
  `supp_trans_no` int(11) default NULL,
  `supp_trans_type` int(11) default NULL,
  `gl_code` varchar(15) NOT NULL default '',
  `grn_item_id` int(11) default NULL,
  `po_detail_item_id` int(11) default NULL,
  `stock_id` varchar(20) NOT NULL default '',
  `description` tinytext,
  `quantity` double NOT NULL default '0',
  `unit_price` double NOT NULL default '0',
  `unit_tax` double NOT NULL default '0',
  `memo_` tinytext,
  PRIMARY KEY  (`id`),
  KEY `Transaction` (`supp_trans_type`,`supp_trans_no`,`stock_id`)
) ENGINE=InnoDB ;

### Data of table `0_supp_invoice_items` ###


### Structure of table `0_supp_trans` ###

DROP TABLE IF EXISTS `0_supp_trans`;

CREATE TABLE `0_supp_trans` (
  `trans_no` int(11) unsigned NOT NULL default '0',
  `type` smallint(6) unsigned NOT NULL default '0',
  `supplier_id` int(11) unsigned default NULL,
  `reference` tinytext NOT NULL,
  `supp_reference` varchar(60) NOT NULL default '',
  `tran_date` date NOT NULL default '0000-00-00',
  `due_date` date NOT NULL default '0000-00-00',
  `ov_amount` double NOT NULL default '0',
  `ov_discount` double NOT NULL default '0',
  `ov_gst` double NOT NULL default '0',
  `rate` double NOT NULL default '1',
  `alloc` double NOT NULL default '0',
  `tax_included` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`type`,`trans_no`),
  KEY `supplier_id` (`supplier_id`),
  KEY `SupplierID_2` (`supplier_id`,`supp_reference`),
  KEY `type` (`type`),
  KEY `tran_date` (`tran_date`)
) ENGINE=InnoDB ;

### Data of table `0_supp_trans` ###


### Structure of table `0_suppliers` ###

DROP TABLE IF EXISTS `0_suppliers`;

CREATE TABLE `0_suppliers` (
  `supplier_id` int(11) NOT NULL auto_increment,
  `supp_name` varchar(60) NOT NULL default '',
  `address` tinytext NOT NULL,
  `supp_address` tinytext NOT NULL,
  `gst_no` varchar(25) NOT NULL default '',
  `contact` varchar(60) NOT NULL default '',
  `supp_account_no` varchar(40) NOT NULL default '',
  `website` varchar(100) NOT NULL default '',
  `bank_account` varchar(60) NOT NULL default '',
  `curr_code` char(3) default NULL,
  `payment_terms` int(11) default NULL,
  `tax_included` tinyint(1) NOT NULL default '0',
  `dimension_id` int(11) default '0',
  `dimension2_id` int(11) default '0',
  `tax_group_id` int(11) default NULL,
  `credit_limit` double NOT NULL default '0',
  `purchase_account` varchar(15) NOT NULL default '',
  `payable_account` varchar(15) NOT NULL default '',
  `payment_discount_account` varchar(15) NOT NULL default '',
  `notes` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL default '0',
  `supp_ref` varchar(30) NOT NULL,
  PRIMARY KEY  (`supplier_id`),
  KEY `supp_ref` (`supp_ref`)
) ENGINE=MyISAM;

### Data of table `0_suppliers` ###

INSERT INTO `0_suppliers` VALUES
('7', 'Algemene leverancier', 'Algemene leverancier', 'Algemene leverancier', '', '', '', '', 'Algemene leverancier', 'EUR', '3', '0', '0', '0', '5', '0', '', '1600', '8150', 'Algemene leverancier', '0', 'Algemene leverancier');

### Structure of table `0_sys_prefs` ###

DROP TABLE IF EXISTS `0_sys_prefs`;

CREATE TABLE `0_sys_prefs` (
  `name` varchar(35) NOT NULL default '',
  `category` varchar(30) default NULL,
  `type` varchar(20) NOT NULL default '',
  `length` smallint(6) default NULL,
  `value` tinytext,
  PRIMARY KEY  (`name`),
  KEY `category` (`category`)
) ENGINE=MyISAM ;

### Data of table `0_sys_prefs` ###

INSERT INTO `0_sys_prefs` VALUES
('coy_name', 'setup.company', 'varchar', '60', 'DemoCo'),
('gst_no', 'setup.company', 'varchar', '25', 'BE123456789'),
('coy_no', 'setup.company', 'varchar', '25', '0123456789'),
('tax_prd', 'setup.company', 'int', '11', '3'),
('tax_last', 'setup.company', 'int', '11', '0'),
('postal_address', 'setup.company', 'tinytext', '0', 'Demolaan 1\r\n1000 Brussel\r\n\r\n'),
('phone', 'setup.company', 'varchar', '30', '02/2345678'),
('fax', 'setup.company', 'varchar', '30', '02/2345678'),
('email', 'setup.company', 'varchar', '100', 'info@srng.be'),
('coy_logo', 'setup.company', 'varchar', '100', NULL),
('domicile', 'setup.company', 'varchar', '55', 'Brussel'),
('curr_default', 'setup.company', 'char', '3', 'EUR'),
('use_dimension', 'setup.company', 'tinyint', '1', '1'),
('f_year', 'setup.company', 'int', '11', '5'),
('no_item_list', 'setup.company', 'tinyint', '1', '0'),
('no_customer_list', 'setup.company', 'tinyint', '1', '0'),
('no_supplier_list', 'setup.company', 'tinyint', '1', '0'),
('base_sales', 'setup.company', 'int', '11', '0'),
('time_zone', 'setup.company', 'tinyint', '1', '0'),
('add_pct', 'setup.company', 'int', '5', '25'),
('round_to', 'setup.company', 'int', '5', '1'),
('login_tout', 'setup.company', 'smallint', '6', '1800'),
('past_due_days', 'glsetup.general', 'int', '11', '30'),
('profit_loss_year_act', 'glsetup.general', 'varchar', '15', '693000'),
('retained_earnings_act', 'glsetup.general', 'varchar', '15', '140000'),
('bank_charge_act', 'glsetup.general', 'varchar', '15', '550001'),
('exchange_diff_act', 'glsetup.general', 'varchar', '15', '754000'),
('default_credit_limit', 'glsetup.customer', 'int', '11', '1000'),
('accumulate_shipping', 'glsetup.customer', 'tinyint', '1', '0'),
('legal_text', 'glsetup.customer', 'tinytext', '0', 'Onze betalingstermijn is 30 dagen netto.'),
('freight_act', 'glsetup.customer', 'varchar', '15', '614000'),
('debtors_act', 'glsetup.sales', 'varchar', '15', '400000'),
('default_sales_act', 'glsetup.sales', 'varchar', '15', '700000'),
('default_sales_discount_act', 'glsetup.sales', 'varchar', '15', '708000'),
('default_prompt_payment_act', 'glsetup.sales', 'varchar', '15', '708000'),
('default_delivery_required', 'glsetup.sales', 'smallint', '6', '7'),
('default_dim_required', 'glsetup.dims', 'int', '11', '20'),
('pyt_discount_act', 'glsetup.purchase', 'varchar', '15', '708000'),
('creditors_act', 'glsetup.purchase', 'varchar', '15', '440000'),
('po_over_receive', 'glsetup.purchase', 'int', '11', '10'),
('po_over_charge', 'glsetup.purchase', 'int', '11', '10'),
('allow_negative_stock', 'glsetup.inventory', 'tinyint', '1', '0'),
('default_inventory_act', 'glsetup.items', 'varchar', '15', '330000'),
('default_cogs_act', 'glsetup.items', 'varchar', '15', '300000'),
('default_adj_act', 'glsetup.items', 'varchar', '15', '310000'),
('default_inv_sales_act', 'glsetup.items', 'varchar', '15', '700000'),
('default_assembly_act', 'glsetup.items', 'varchar', '15', '603000'),
('default_workorder_required', 'glsetup.manuf', 'int', '11', '20'),
('version_id', 'system', 'varchar', '11', '2.3rc'),
('auto_curr_reval', 'setup.company', 'smallint', '6', '1'),
('grn_clearing_act', 'glsetup.purchase', 'varchar', '15', '0');

### Structure of table `0_sys_types` ###

DROP TABLE IF EXISTS `0_sys_types`;

CREATE TABLE `0_sys_types` (
  `type_id` smallint(6) NOT NULL default '0',
  `type_no` int(11) NOT NULL default '1',
  `next_reference` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB ;

### Data of table `0_sys_types` ###

INSERT INTO `0_sys_types` VALUES
('0', '17', '1'),
('1', '7', 'BET2016001'),
('2', '4', 'ONTV2016001'),
('4', '3', '1'),
('10', '16', 'VF2016001'),
('11', '2', 'C2016001'),
('12', '6', 'DEB2016001'),
('13', '1', 'PB2016001'),
('16', '2', '1'),
('17', '2', '1'),
('18', '1', '1'),
('20', '6', 'IF2016001'),
('21', '1', 'C-IF2016001'),
('22', '3', 'LEV2016001'),
('25', '1', '1'),
('26', '1', 'WO2016001'),
('28', '1', '1'),
('29', '1', '1'),
('30', '0', 'VO2016001'),
('32', '0', 'OF2016001'),
('35', '1', '1'),
('40', '1', '1');

### Structure of table `0_tag_associations` ###

DROP TABLE IF EXISTS `0_tag_associations`;

CREATE TABLE `0_tag_associations` (
  `record_id` varchar(15) NOT NULL,
  `tag_id` int(11) NOT NULL,
  UNIQUE KEY `record_id` (`record_id`,`tag_id`)
) ENGINE=MyISAM ;

### Data of table `0_tag_associations` ###

INSERT INTO `0_tag_associations` VALUES
('1', '2');

### Structure of table `0_tags` ###

DROP TABLE IF EXISTS `0_tags`;

CREATE TABLE `0_tags` (
  `id` int(11) NOT NULL auto_increment,
  `type` smallint(6) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(60) default NULL,
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `type` (`type`,`name`)
) ENGINE=MyISAM;

### Data of table `0_tags` ###


### Structure of table `0_tax_group_items` ###

DROP TABLE IF EXISTS `0_tax_group_items`;

CREATE TABLE `0_tax_group_items` (
  `tax_group_id` int(11) NOT NULL default '0',
  `tax_type_id` int(11) NOT NULL default '0',
  `rate` double NOT NULL default '0',
  PRIMARY KEY  (`tax_group_id`,`tax_type_id`)
) ENGINE=InnoDB ;

### Data of table `0_tax_group_items` ###

INSERT INTO `0_tax_group_items` VALUES
('5', '7', '21'),
('5', '8', '6'),
('5', '9', '0'),
('6', '7', '21'),
('6', '8', '6'),
('6', '9', '0'),
('7', '7', '21'),
('7', '8', '6'),
('7', '9', '0');

### Structure of table `0_tax_groups` ###

DROP TABLE IF EXISTS `0_tax_groups`;

CREATE TABLE `0_tax_groups` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(60) NOT NULL default '',
  `tax_shipping` tinyint(1) NOT NULL default '0',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB;

### Data of table `0_tax_groups` ###

INSERT INTO `0_tax_groups` VALUES
('5', 'Diensten', '0', '0'),
('6', 'Goederen', '0', '0'),
('7', 'Overige', '1', '0');

### Structure of table `0_tax_types` ###

DROP TABLE IF EXISTS `0_tax_types`;

CREATE TABLE `0_tax_types` (
  `id` int(11) NOT NULL auto_increment,
  `rate` double NOT NULL default '0',
  `sales_gl_code` varchar(15) NOT NULL default '',
  `purchasing_gl_code` varchar(15) NOT NULL default '',
  `name` varchar(60) NOT NULL default '',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`,`rate`)
) ENGINE=InnoDB;

### Data of table `0_tax_types` ###

INSERT INTO `0_tax_types` VALUES
('7', '21', '451054', '411059', 'BTW 21', '0'),
('8', '6', '451054', '411059', 'BTW 06', '0'),
('9', '0', '451054', '411059', 'BTW vrij', '0');

### Structure of table `0_trans_tax_details` ###

DROP TABLE IF EXISTS `0_trans_tax_details`;

CREATE TABLE `0_trans_tax_details` (
  `id` int(11) NOT NULL auto_increment,
  `trans_type` smallint(6) default NULL,
  `trans_no` int(11) default NULL,
  `tran_date` date NOT NULL,
  `tax_type_id` int(11) NOT NULL default '0',
  `rate` double NOT NULL default '0',
  `ex_rate` double NOT NULL default '1',
  `included_in_price` tinyint(1) NOT NULL default '0',
  `net_amount` double NOT NULL default '0',
  `amount` double NOT NULL default '0',
  `memo` tinytext,
  PRIMARY KEY  (`id`),
  KEY `Type_and_Number` (`trans_type`,`trans_no`),
  KEY `tran_date` (`tran_date`)
) ENGINE=InnoDB ;

### Data of table `0_trans_tax_details` ###


### Structure of table `0_useronline` ###

DROP TABLE IF EXISTS `0_useronline`;

CREATE TABLE `0_useronline` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` int(15) NOT NULL default '0',
  `ip` varchar(40) NOT NULL default '',
  `file` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `timestamp` (`timestamp`),
  KEY `ip` (`ip`)
) ENGINE=MyISAM ;

### Data of table `0_useronline` ###


### Structure of table `0_users` ###

DROP TABLE IF EXISTS `0_users`;

CREATE TABLE `0_users` (
  `id` smallint(6) NOT NULL auto_increment,
  `user_id` varchar(60) NOT NULL default '',
  `password` varchar(100) NOT NULL default '',
  `real_name` varchar(100) NOT NULL default '',
  `role_id` int(11) NOT NULL default '1',
  `phone` varchar(30) NOT NULL default '',
  `email` varchar(100) default NULL,
  `language` varchar(20) default NULL,
  `date_format` tinyint(1) NOT NULL default '0',
  `date_sep` tinyint(1) NOT NULL default '0',
  `tho_sep` tinyint(1) NOT NULL default '0',
  `dec_sep` tinyint(1) NOT NULL default '0',
  `theme` varchar(20) NOT NULL default 'default',
  `page_size` varchar(20) NOT NULL default 'A4',
  `prices_dec` smallint(6) NOT NULL default '2',
  `qty_dec` smallint(6) NOT NULL default '2',
  `rates_dec` smallint(6) NOT NULL default '4',
  `percent_dec` smallint(6) NOT NULL default '1',
  `show_gl` tinyint(1) NOT NULL default '1',
  `show_codes` tinyint(1) NOT NULL default '0',
  `show_hints` tinyint(1) NOT NULL default '0',
  `last_visit_date` datetime default NULL,
  `query_size` tinyint(1) default '10',
  `graphic_links` tinyint(1) default '1',
  `pos` smallint(6) default '1',
  `print_profile` varchar(30) NOT NULL default '1',
  `rep_popup` tinyint(1) default '1',
  `sticky_doc_date` tinyint(1) default '0',
  `startup_tab` varchar(20) NOT NULL default 'orders',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM;

### Data of table `0_users` ###

INSERT INTO `0_users` VALUES
('7', 'admin', '5f4dcc3b5aa765d61d8327deb882cf99', '', '3', '', NULL, 'be_NL', '1', '0', '1', '1', 'default', 'A4', '2', '2', '4', '1', '1', '0', '0', '2013-01-06 20:26:40', '10', '1', '1', '', '1', '0', 'orders', '0');

### Structure of table `0_voided` ###

DROP TABLE IF EXISTS `0_voided`;

CREATE TABLE `0_voided` (
  `type` int(11) NOT NULL default '0',
  `id` int(11) NOT NULL default '0',
  `date_` date NOT NULL default '0000-00-00',
  `memo_` tinytext NOT NULL,
  UNIQUE KEY `id` (`type`,`id`)
) ENGINE=InnoDB ;

### Data of table `0_voided` ###


### Structure of table `0_wo_issue_items` ###

DROP TABLE IF EXISTS `0_wo_issue_items`;

CREATE TABLE `0_wo_issue_items` (
  `id` int(11) NOT NULL auto_increment,
  `stock_id` varchar(40) default NULL,
  `issue_id` int(11) default NULL,
  `qty_issued` double default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB ;

### Data of table `0_wo_issue_items` ###


### Structure of table `0_wo_issues` ###

DROP TABLE IF EXISTS `0_wo_issues`;

CREATE TABLE `0_wo_issues` (
  `issue_no` int(11) NOT NULL auto_increment,
  `workorder_id` int(11) NOT NULL default '0',
  `reference` varchar(100) default NULL,
  `issue_date` date default NULL,
  `loc_code` varchar(5) default NULL,
  `workcentre_id` int(11) default NULL,
  PRIMARY KEY  (`issue_no`),
  KEY `workorder_id` (`workorder_id`)
) ENGINE=InnoDB ;

### Data of table `0_wo_issues` ###


### Structure of table `0_wo_manufacture` ###

DROP TABLE IF EXISTS `0_wo_manufacture`;

CREATE TABLE `0_wo_manufacture` (
  `id` int(11) NOT NULL auto_increment,
  `reference` varchar(100) default NULL,
  `workorder_id` int(11) NOT NULL default '0',
  `quantity` double NOT NULL default '0',
  `date_` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`id`),
  KEY `workorder_id` (`workorder_id`)
) ENGINE=InnoDB ;

### Data of table `0_wo_manufacture` ###


### Structure of table `0_wo_requirements` ###

DROP TABLE IF EXISTS `0_wo_requirements`;

CREATE TABLE `0_wo_requirements` (
  `id` int(11) NOT NULL auto_increment,
  `workorder_id` int(11) NOT NULL default '0',
  `stock_id` char(20) NOT NULL default '',
  `workcentre` int(11) NOT NULL default '0',
  `units_req` double NOT NULL default '1',
  `std_cost` double NOT NULL default '0',
  `loc_code` char(5) NOT NULL default '',
  `units_issued` double NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `workorder_id` (`workorder_id`)
) ENGINE=InnoDB ;

### Data of table `0_wo_requirements` ###


### Structure of table `0_workcentres` ###

DROP TABLE IF EXISTS `0_workcentres`;

CREATE TABLE `0_workcentres` (
  `id` int(11) NOT NULL auto_increment,
  `name` char(40) NOT NULL default '',
  `description` char(50) NOT NULL default '',
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM ;

### Data of table `0_workcentres` ###


### Structure of table `0_workorders` ###

DROP TABLE IF EXISTS `0_workorders`;

CREATE TABLE `0_workorders` (
  `id` int(11) NOT NULL auto_increment,
  `wo_ref` varchar(60) NOT NULL default '',
  `loc_code` varchar(5) NOT NULL default '',
  `units_reqd` double NOT NULL default '1',
  `stock_id` varchar(20) NOT NULL default '',
  `date_` date NOT NULL default '0000-00-00',
  `type` tinyint(4) NOT NULL default '0',
  `required_by` date NOT NULL default '0000-00-00',
  `released_date` date NOT NULL default '0000-00-00',
  `units_issued` double NOT NULL default '0',
  `closed` tinyint(1) NOT NULL default '0',
  `released` tinyint(1) NOT NULL default '0',
  `additional_costs` double NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `wo_ref` (`wo_ref`)
) ENGINE=InnoDB ;

### Data of table `0_workorders` ###
