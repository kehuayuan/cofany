CREATE TABLE `USER_MSG` (
  `msgId` varchar(36) NOT NULL,
  `content` longtext,
  `fromUserCaption` varchar(128) DEFAULT NULL,
  `fromUserOpenid` varchar(36) DEFAULT NULL,
  `msgTime` bigint(20) DEFAULT NULL,
  `msgType` varchar(255) DEFAULT NULL,
  `toUserCaption` varchar(128) DEFAULT NULL,
  `toUserOpenid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`msgId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8