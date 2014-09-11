SET NAMES 'UTF8';

--
-- Table structure for table `cdef`
--

CREATE TABLE cdef (
  id mediumint(8) unsigned NOT NULL auto_increment,
  hash varchar(32) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table `cdef`
--

INSERT INTO cdef VALUES (3,'3d352eed9fa8f7b2791205b3273708c7','构建反向栈');
INSERT INTO cdef VALUES (4,'e961cc8ec04fda6ed4981cf5ad501aa5','构建每五分钟');
INSERT INTO cdef VALUES (12,'f1ac79f05f255c02f914c920f1038c54','汇总所有数据源');
INSERT INTO cdef VALUES (2,'73f95f8b77b5508157d64047342c421e','转换字节至位');
INSERT INTO cdef VALUES (14,'634a23af5e78af0964e8d33b1a4ed26b','乘1024');
INSERT INTO cdef VALUES (15,'068984b5ccdfd2048869efae5166f722','汇总所有数据源,乘1024');

--
-- Table structure for table `cdef_items`
--

CREATE TABLE cdef_items (
  id mediumint(8) unsigned NOT NULL auto_increment,
  hash varchar(32) NOT NULL default '',
  cdef_id mediumint(8) unsigned NOT NULL default '0',
  sequence mediumint(8) unsigned NOT NULL default '0',
  type tinyint(2) NOT NULL default '0',
  value varchar(150) NOT NULL default '',
  PRIMARY KEY  (id),
  KEY cdef_id (cdef_id)
) TYPE=MyISAM;

--
-- Dumping data for table `cdef_items`
--

INSERT INTO cdef_items VALUES (7,'9bbf6b792507bb9bb17d2af0970f9be9',2,1,4,'CURRENT_DATA_SOURCE');
INSERT INTO cdef_items VALUES (9,'a4b8eb2c3bf4920a3ef571a7a004be53',2,2,6,'8');
INSERT INTO cdef_items VALUES (8,'caa4e023ac2d7b1c4b4c8c4adfd55dfe',2,3,2,'3');
INSERT INTO cdef_items VALUES (10,'c888c9fe6b62c26c4bfe23e18991731d',3,1,4,'CURRENT_DATA_SOURCE');
INSERT INTO cdef_items VALUES (11,'1e1d0b29a94e08b648c8f053715442a0',3,3,2,'3');
INSERT INTO cdef_items VALUES (12,'4355c197998c7f8b285be7821ddc6da4',3,2,6,'-1');
INSERT INTO cdef_items VALUES (13,'40bb7a1143b0f2e2efca14eb356236de',4,1,4,'CURRENT_DATA_SOURCE');
INSERT INTO cdef_items VALUES (14,'42686ea0925c0220924b7d333599cd67',4,3,2,'3');
INSERT INTO cdef_items VALUES (15,'faf1b148b2c0e0527362ed5b8ca1d351',4,2,6,'300');
INSERT INTO cdef_items VALUES (16,'0ef6b8a42dc83b4e43e437960fccd2ea',12,1,4,'ALL_DATA_SOURCES_NODUPS');
INSERT INTO cdef_items VALUES (18,'86370cfa0008fe8c56b28be80ee39a40',14,1,4,'CURRENT_DATA_SOURCE');
INSERT INTO cdef_items VALUES (19,'9a35cc60d47691af37f6fddf02064e20',14,2,6,'1024');
INSERT INTO cdef_items VALUES (20,'5d7a7941ec0440b257e5598a27dd1688',14,3,2,'3');
INSERT INTO cdef_items VALUES (21,'44fd595c60539ff0f5817731d9f43a85',15,1,4,'ALL_DATA_SOURCES_NODUPS');
INSERT INTO cdef_items VALUES (22,'aa38be265e5ac31783e57ce6f9314e9a',15,2,6,'1024');
INSERT INTO cdef_items VALUES (23,'204423d4b2598f1f7252eea19458345c',15,3,2,'3');

--
-- Table structure for table `colors`
--