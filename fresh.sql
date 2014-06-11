/*  Dom Parise 4/15/14
    push notifications
*/

DROP TABLE IF EXISTS `Notification`;
DROP TABLE IF EXISTS `User`;

# Represents people using the app
#
CREATE TABLE `User` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `deviceToken` varchar(100) DEFAULT NULL,
  `noteCount` int(11) NOT NULL DEFAULT 0,
  Primary Key (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Push notifications
# considered having notification id
CREATE TABLE `Notification` (
  `uid` int(11) NOT NULL,
  `note` varchar(256) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `user` (`uid`),
  KEY `userNoteHash` (`uid`) USING HASH,
  CONSTRAINT `user` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TRIGGER incNotification AFTER INSERT ON Notification FOR EACH ROW UPDATE User SET noteCount = noteCount + 1 WHERE uid=NEW.uid;
CREATE TRIGGER decNotification AFTER DELETE ON Notification FOR EACH ROW UPDATE User SET noteCount = noteCount - 1 WHERE uid=OLD.uid;

INSERT INTO `User` (`uid`,`deviceToken`) values(1,"d550e4689fa861e819edb72d05958672c0d0161bac16c54f145fb4141482f90d");