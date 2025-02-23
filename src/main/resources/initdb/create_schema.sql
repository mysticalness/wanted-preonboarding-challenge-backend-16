-- schema.sql
CREATE TABLE IF NOT EXISTS `performance`
(
    `id`         BINARY(16) default (uuid_to_bin(uuid())) NOT NULL COMMENT '공연/전시 ID',
    `name`       varchar(255)                             NOT NULL COMMENT '공연/전시 이름',
    `price`      INT                                      NOT NULL COMMENT '가격',
    `round`      INT                                      NOT NULL COMMENT '회차',
    `type`       INT                                      NOT NULL COMMENT 'NONE, CONCERT, EXHIBITION',
    `start_date` datetime                                 NOT NULL COMMENT '공연 일시',
    `is_reserve` varchar(255)                             NOT NULL DEFAULT 'disable',
    `created_at` DATETIME   DEFAULT NOW()                 NOT NULL,
    `updated_at` DATETIME   DEFAULT NOW()                 NOT NUll,
    PRIMARY KEY (id),
    UNIQUE KEY (id, round)
);

CREATE TABLE IF NOT EXISTS `performance_seat_info`
(
    `id`             INT(10)                NOT NULL AUTO_INCREMENT,
    `performance_id` BINARY(16)             NOT NULL COMMENT '공연전시ID',
    `round`          INT                    NOT NULL COMMENT '회차(FK)',
    `gate`           INT                    NOT NULL COMMENT '입장 게이트',
    `line`           CHAR(2)                NOT NULL COMMENT '좌석 열',
    `seat`           INT                    NOT NULL COMMENT '좌석 행',
    `is_reserve`     varchar(255)           NOT NULL default 'enable',
    `created_at`     DATETIME DEFAULT NOW() NOT NULL,
    `updated_at`     DATETIME DEFAULT NOW() NOT NUll,
    PRIMARY KEY (id),
    UNIQUE KEY performance_seat_info_unique (performance_id, round, `line`, seat)
);

CREATE TABLE IF NOT EXISTS `reservation`
(
    `id`             INT(10)                NOT NULL AUTO_INCREMENT,
    `performance_id` BINARY(16)             NOT NULL COMMENT '공연전시ID',
    `name`           varchar(255)           NOT NULL COMMENT '예약자명',
    `phone_number`   varchar(255)           NOT NULL COMMENT '예약자 휴대전화 번호',
    `round`          INT                    NOT NULL COMMENT '회차(FK)',
    `gate`           INT                    NOT NULL COMMENT '입장 게이트',
    `line`           CHAR                   NOT NULL COMMENT '좌석 열',
    `seat`           INT                    NOT NULL COMMENT '좌석 행',
    `created_at`     DATETIME DEFAULT NOW() NOT NULL,
    `updated_at`     DATETIME DEFAULT NOW() NOT NUll,
    PRIMARY KEY (id),
    UNIQUE KEY reservation_round_row_seat (performance_id, round, `line`, seat)
);


---------------------------------- MODIFY (MYSTICALNESS) ---------------------------------------------------------------

CREATE TABLE `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `performance_id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())) COMMENT '공연전시ID',
  `name` varchar(255) NOT NULL COMMENT '예약자명',
  `phone_number` varchar(255) NOT NULL COMMENT '예약자 휴대전화 번호',
  `status` varchar(255) NOT NULL,
  `amount` int NOT NULL,
  `round` int NOT NULL COMMENT '회차(FK)',
  `gate` int NOT NULL COMMENT '입장 게이트',
  `line` char(1) NOT NULL COMMENT '좌석 열',
  `seat` int NOT NULL COMMENT '좌석 행',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reservation_round_row_seat` (`performance_id`,`round`,`line`,`seat`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`performance_id`) REFERENCES `performance` (`id`),
  CONSTRAINT `reservation_chk_1` CHECK (((`status` = _utf8mb4'reserve') or (`status` = _utf8mb4'canceled')))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE `performance_seat_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `performance_id` binary(16) NOT NULL COMMENT '공연전시ID',
  `round` int NOT NULL COMMENT '회차(FK)',
  `gate` int NOT NULL COMMENT '입장 게이트',
  `line` char(2) NOT NULL COMMENT '좌석 열',
  `seat` int NOT NULL COMMENT '좌석 행',
  `is_reserve` varchar(255) NOT NULL DEFAULT 'enable',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `performance_seat_info_unique` (`performance_id`,`round`,`line`,`seat`),
  CONSTRAINT `performance_seat_info_ibfk_1` FOREIGN KEY (`performance_id`) REFERENCES `performance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE `performance` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())) COMMENT '공연/전시 ID',
  `name` varchar(255) NOT NULL COMMENT '공연/전시 이름',
  `price` int NOT NULL COMMENT '가격',
  `round` int NOT NULL COMMENT '회차',
  `type` int NOT NULL COMMENT 'NONE, CONCERT, EXHIBITION',
  `start_date` date NOT NULL,
  `is_reserve` varchar(255) NOT NULL DEFAULT 'disable',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`,`round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci



CREATE TABLE `alarm` (
  `id` int NOT NULL AUTO_INCREMENT,
  `performance_id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())) COMMENT '공연전시ID',
  `performance_name` varchar(255) NOT NULL COMMENT '공연/전시 이름',
  `name` varchar(255) NOT NULL COMMENT '고객이름',
  `phone_number` varchar(255) NOT NULL COMMENT '예약자 휴대전화 번호',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci