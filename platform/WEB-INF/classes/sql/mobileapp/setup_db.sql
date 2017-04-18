/*==============================================================*/
/*                                                              */
/*              云医通标准平台前端系统建表sql                     */
/*                                                              */
/*                                                              */
/*==============================================================*/


/*=====================  挂号记录与订单  Yuce 2015-6-11 start ==========*/
drop table if exists BIZ_REGISTER_RECORD;

/*==============================================================*/
/* Table: BIZ_REGISTER_RECORD                                   */
/*==============================================================*/
create table BIZ_REGISTER_RECORD
(
   ID                   varchar(32) not null,
   HOSPITAL_ID          varchar(32),
   HOSPITAL_CODE        varchar(32) comment '医院代码',
   BRANCH_ID            varchar(32),
   BRANCH_CODE          varchar(32),
   REG_STATUS           int(2) comment '0:预约中,1:已预约,2:已取消-用户取消, 3:已取消-网络异常系统自动取消, 4:已取消-支付超过规定时长, 5:预约异常(his锁号异常), 6:支付异常(公共支付), 7:取消挂号异常, 8:退费异常(公共退费), 9:支付后提交his异常 10:停诊取消',
   PAY_STATUS           int(1) comment '支付状态：1：未支付, 2：已支付3：已退费',
   CARD_TYPE            int(1) comment '绑定诊疗卡类型',
   CARD_NO              varchar(32) comment '绑定诊疗卡号',
   OPEN_ID              varchar(100) not null comment '用户openId',
   IS_EXCEPTION            int(1) comment '是否发生异常  0 否 1是',
   IS_HANDLE_SUCCESS    int(1) comment '是否处理成功   1是   0 否',
   HANDLE_COUNT         int(1) comment '处理次数',
   HANDLE_LOG           varchar(500) comment '异常处理日志',
   REG_TYPE             int(1) comment '挂号类型,1：预约,2：当天',
   PATIENT_NAME         varchar(10) comment '患者姓名',
   PATIENT_MOBILE       varchar(32) comment '患者手机号码',
   ORDER_NO             varchar(23),
   ORDER_NO_HASH_VAL    bigint,
   DEPT_CODE            varchar(32),
   DEPT_NAME            varchar(32),
   CATEGORY             int(1) comment '类别,1 专家医生；2 专科医生,3 专科',
   DOCTOR_CODE          varchar(32) comment '医生/专科代码 ,预约挂号专科时该字段可为空，跟预约号源信息查询所返回的专科代码一致',
   DOCTOR_NAME          varchar(30) comment '医生/专科名称,',
   DOCTOR_TITLE         varchar(30) comment '职称',
   REGISTER_TIME        bigint comment '挂号时间,格式：时间毫秒数',
   PAY_TIMEOUT_TIME     bigint,
   SCHEDULE_DATE        date comment '就诊日期,格式：YYYY-MM-DD',
   BEGIN_TIME           time comment '分时开始时间 ,格式：HH:mm',
   END_TIME             time comment '分时结束时间：HH:mm',
   REG_MODE             int(1) comment '预约来源   1：微信公众号    2：支付宝服务窗',
   REG_FEE              int comment '单位：分,原挂号费用',
   REAL_REG_FEE         int comment ',单位：分,优惠后的挂号费用',
   TREAT_FEE            int comment ',单位：分,原诊疗费用',
   REAL_TREAT_FEE       int comment ',单位：分,优惠后的诊疗费用',
   FEE_DESC             varchar(500) comment '费用说明',
   HIS_ORD_NO           varchar(32) comment '医院预约流水号',
   SERIAL_NUM           int comment '就诊序号',
   VISIT_LOCATION       varchar(500) comment '提醒患者就诊的地方',
   BARCODE              varchar(32),
   VISIT_DESC           varchar(2000) comment '就诊说明',
   REG_PERSON_TYPE      int(1) comment '1：为本人挂号,2：为子女挂号,3：为他人挂号',
   UPDATE_TIME          bigint comment '修改时间的毫秒数',
   TIME_FLAG            int(1) comment '分时 时段   1：上午   2：下午     3：晚上',
   ONLINE_PAYMENT_TYPE  int(1) comment '支付控制类型  1：必须在线支付    2：不用在线支付     3：支持暂不支付',
   IS_VALID             int(1) default 1 comment '是否是有效的挂号记录  比如挂号时锁号异常后轮询处理变为取消状态的记录为无效挂号记录    1有效   0 无效',
   primary key (ID)
);

alter table BIZ_REGISTER_RECORD comment '挂号记录';

alter table BIZ_REGISTER_RECORD add constraint FK_REG_RECORD_REF_HOSPITAL foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete cascade on update cascade;
ALTER TABLE BIZ_REGISTER_RECORD
    ADD UNIQUE INDEX INDEX_REGRECORD_ORDER_NO (ORDER_NO) ,
    ADD INDEX INDEX_REGRECORD_HASH_VAL (ORDER_NO_HASH_VAL),
    ADD INDEX INDEX_REGRECORD_OPENID(OPEN_ID),
    ADD INDEX INDEX_REGRECORD_BRANCHID(BRANCH_ID),
    ADD INDEX INDEX_REGRECORD_CARDNO (CARD_NO) ;

drop table if exists BIZ_REGISTER_ORDER;

/*==============================================================*/
/* Table: BIZ_REGISTER_ORDER                                    */
/*==============================================================*/
create table BIZ_REGISTER_ORDER
(
   ID                   varchar(32) not null,
   ORDER_NO             varchar(23),
   ORDER_NO_HASH_VAL    bigint comment '用于查询时提高性能',
   RELATIVE_ORDER_NO    varchar(23) comment '关联订单号 (此订单对应的退费等业务订单)',
   APP_ID               varchar(50),
   APP_CODE             varchar(50),
   REG_TYPE             int(1) comment '挂号类型,1：预约,2：当天',
   ORDER_TITLE          varchar(200),
   OPEN_ID              varchar(50) not null,
   MCH_OPEN_ID          varchar(50) comment '子商户时需要的openId', 
   MCH_ID               varchar(50) comment '商户mchId', 
   MCH_SECRET           varchar(50) comment '商户secret',  
   SUB_MCH_ID           varchar(50) comment '子商户mchId', 
   IS_SUB_PAY           int(1) comment '是否有子商户   1 有   0 没有',
   MCH_KEY              varchar(50) comment '商户key', 
   HIS_ORD_NUM          varchar(32) comment '医院订单号',
   HIS_REF_ORD_NUM      varchar(32),
   AGT_ORD_NUM          varchar(32) comment '交易机构(微信、支付宝)支付单号',
   AGT_REF_ORD_NUM      varchar(32) comment '交易机构退费单号 ',
   AGT_CODE             varchar(32) comment '交易机构代码 ,财付通账号、银行卡账号等',
   PAY_MODE             int(1) not null comment '支付方式,1：微信公众号,2：支付宝服务窗,3：其他',
   PAY_AMOUT            int comment '支付金额,单位：分',
   PAY_TIME             date comment '支付时间 格式：yyyy-MM-dd HH:mm:ss',
   PAY_DESC             varchar(300) comment '支付说明',
   REFUND_MODE          int(1) not null comment '退费方式,1：微信公众号,2：支付宝服务窗,3：其他',
   REFUND_AMOUT         int comment  '退费金额,单位：分',
   REFUND_TIME          date comment '退费时间格式：yyyy-MM-dd HH:mm:ss',
   REFUND_DESC          varchar(300) comment '退费说明',
   CANCEL_REASON        varchar(300) comment '订单取消原因',
   STATE                int(1) comment '订单状态：1：未支付   2：已支付   3：已退费',
   ORDER_DESC           varchar(255),
   BUSINESS_CODE        varchar(32),
   BUSINESS_NAME        varchar(32),
   MZ_ORD_NUM           varchar(32) comment '医院订单支付/退费确认收据号',
   CARD_TYPE            int(1) comment '绑定诊疗卡类型',
   CARD_NO              varchar(50) comment '诊疗卡卡号',
   LOCK_ID              varchar(32),
   BRANCH_ID            varchar(32),
   SUB_APP_ID           varchar(50),
   HOSPITAL_ID          varchar(32),
   ORDER_TIME           date comment '订单生成时间',
   WAIT_PAY_TIME        int  comment '等待支付时间(分钟)',
   ONLINE_PAYMENT_TYPE  int(1) comment '支付控制类型  1：必须在线支付    2：不用在线支付     3：支持暂不支付',
   primary key (ID)
);

alter table BIZ_REGISTER_ORDER comment '挂号订单表';
ALTER TABLE BIZ_REGISTER_ORDER
    ADD UNIQUE INDEX INDEX_REGORDER_ORDER_NO (ORDER_NO) ,
    ADD INDEX INDEX_REGORDER_HASH_VAL (ORDER_NO_HASH_VAL),
    ADD INDEX INDEX_REGORDER_OPENID(OPEN_ID) ;

 /*=====================  挂号记录  Yuce 2015-6-11 end ==========*/

      
 

/*==============================================================*/
/* Table: EVER_HAD_REG_DOCTOR             曾挂号医生        yuce      */
/*==============================================================*/
drop table if exists BIZ_HAD_REG_DOCTOR;
create table BIZ_HAD_REG_DOCTOR
(
   ID                   varchar(32) not null comment '主键ID',
   OPEN_ID              varchar(100),
   APP_CODE             varchar(50),
   APP_ID               varchar(50),
   HOSPITAL_ID          varchar(32) comment '医院ID',
   HOSPITAL_CODE        varchar(50) comment '医院CODE',
   HOSPITAL_NAME        varchar(50),
   BRANCH_HOSPITAL_ID   varchar(32) comment '分院ID',
   BRANCH_HOSPITAL_CODE varchar(50) comment '分院CODE',
   DEPT_CODE            varchar(50),
   DEPT_NAME            varchar(50) comment '科室名称',
   DOCTOR_CODE          varchar(50) comment '医生编码',
   DOCTOR_NAME          varchar(50) comment '医生名称',
   primary key (ID)
);

alter table BIZ_HAD_REG_DOCTOR comment '曾挂号医生';
ALTER TABLE BIZ_HAD_REG_DOCTOR
    ADD INDEX INDEX_OPEN_ID_FOR_HAD_REG_DOCTOR (OPEN_ID) ,
    ADD INDEX INDEX_HOSPITAL_FOR_HAD_REG_DOCTOR (HOSPITAL_CODE) ,
    ADD INDEX INDEX_BRANCH_FOR_HAD_REG_DOCTOR (BRANCH_HOSPITAL_CODE) ;


/*==============================================================*/
/* Table: BIZ_MEDICAL_CARD_1             就诊卡表        			        */
/*==============================================================*/
drop table if exists BIZ_MEDICAL_CARD_1;
CREATE TABLE `BIZ_MEDICAL_CARD_1` (
  `ID` varchar(32) NOT NULL COMMENT '编号',
  `USER_ID` varchar(32) DEFAULT NULL COMMENT '用户编号（外键）',
  `BRANCH_ID` varchar(32) NOT NULL COMMENT '分院编号（外键）',
  `BRANCH_NAME` varchar(255) DEFAULT NULL,
  `BRANCH_CODE` varchar(100) NOT NULL,
  `HOSPITAL_ID` varchar(32) DEFAULT NULL COMMENT '医院编号',
  `HOSPITAL_NAME` varchar(255) DEFAULT NULL,
  `HOSPITAL_CODE` varchar(100) DEFAULT NULL COMMENT '医院代码',
  `PLATFORM` int(11) NOT NULL DEFAULT '0' COMMENT '平台(1微信，2支付宝)',
  `NAME` varchar(255) DEFAULT NULL COMMENT '名称',
  `SEX` int(11) DEFAULT NULL COMMENT '性别(1男，2女)',
  `AGE` int(11) DEFAULT NULL COMMENT ' 年龄',
  `BIRTH` varchar(10) DEFAULT NULL COMMENT '出生日期',
  `MOBILE` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `ID_TYPE` int(11) DEFAULT NULL COMMENT '证件类型（配置）',
  `ID_NO` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '地址',
  `OPEN_ID` varchar(255) NOT NULL,
  `OWNERSHIP` int(11) NOT NULL COMMENT '与本人关系（配置）',
  `CARD_TYPE` int(11) DEFAULT NULL COMMENT '卡类型（配置）',
  `CARD_NO` varchar(255) DEFAULT NULL COMMENT '就诊卡号',
  `ADMISSION_NO` varchar(255) DEFAULT NULL COMMENT '住院号',
  `GUARD_NAME` varchar(255) DEFAULT NULL COMMENT '监护人名称',
  `GUARD_ID_TYPE` int(11) DEFAULT NULL COMMENT '监护人证件类型（配置）',
  `GUARD_ID_NO` varchar(255) DEFAULT NULL COMMENT '监护人证件号码',
  `GUARD_MOBILE` varchar(255) DEFAULT NULL COMMENT '监护人手机号码',
  `IS_MEDICARE` int(11) DEFAULT '0' COMMENT '是否有医保（0没有，1有）',
  `MEDICARE_NO` varchar(255) DEFAULT NULL COMMENT '医保卡号',
  `MARK` varchar(2000) DEFAULT NULL COMMENT '备注',
  `BIND_WAY` int(11) NOT NULL DEFAULT '0' COMMENT '绑卡方式(0绑卡,1建档)',
  `PATIENT_ID` varchar(255) DEFAULT NULL,
  `STATE` int(11) NOT NULL DEFAULT '0' COMMENT '是否启用（0不启用，1启用）',
  `CREATE_TIME` bigint(20) NOT NULL,
  `UPDATE_TIME` bigint(20) NOT NULL,
  `FAMILY_ID` varchar(32) DEFAULT NULL COMMENT '从属的家人ID',
  PRIMARY KEY (`ID`),
  KEY `FK_MEDICAL_CARD_REF_HOSPITAL` (`HOSPITAL_ID`) USING BTREE,
  KEY `FK_MEDICAL_CARD_REF_BRANCH_HOSPITAL` (`BRANCH_ID`) USING BTREE,
  KEY `IDX_MEDICAL_CARD_ALL` (`STATE`) USING BTREE,
  KEY `IDX_MEDICAL_CARD_BY_OWNERSHIP` (`HOSPITAL_CODE`,`PLATFORM`,`OPEN_ID`,`OWNERSHIP`,`STATE`) USING BTREE,
  KEY `IDX_MEDICAL_CARD_BY_IDNO` (`HOSPITAL_CODE`,`PLATFORM`,`ID_TYPE`,`ID_NO`,`STATE`) USING BTREE,
  KEY `IDX_MEDICAL_CARD_BY_CARDNO` (`HOSPITAL_CODE`,`PLATFORM`,`CARD_TYPE`,`CARD_NO`,`STATE`) USING BTREE,
  KEY `IDX_MEDICAL_CARD_BY_OPENID` (`HOSPITAL_CODE`,`PLATFORM`,`OPEN_ID`,`STATE`) USING BTREE,
  CONSTRAINT `BIZ_MEDICAL_CARD_1_ibfk_1` FOREIGN KEY (`BRANCH_ID`) REFERENCES `SYS_BRANCH_HOSPITAL` (`ID`),
  CONSTRAINT `BIZ_MEDICAL_CARD_1_ibfk_2` FOREIGN KEY (`HOSPITAL_ID`) REFERENCES `SYS_HOSPITAL` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table BIZ_MEDICAL_CARD_1 comment '就诊卡表';

/*==============================================================*/
/* Table: BIZ_CLINIC_RECORD_9             门诊缴费记录        			        */
/*==============================================================*/
drop table if exists BIZ_CLINIC_RECORD_9;
CREATE TABLE `BIZ_CLINIC_RECORD_9` (
  `ID` varchar(32) NOT NULL,
  `HOSPITAL_ID` varchar(32) DEFAULT NULL,
  `HOSPITAL_CODE` varchar(100) DEFAULT NULL COMMENT '医院代码',
  `HOSPITAL_NAME` varchar(100) DEFAULT NULL,
  `BRANCH_ID` varchar(32) DEFAULT NULL,
  `BRANCH_CODE` varchar(100) DEFAULT NULL,
  `APP_ID` varchar(32) DEFAULT NULL,
  `APP_CODE` varchar(32) DEFAULT NULL,
  `PAY_STATUS` int(1) DEFAULT NULL COMMENT '支付状态：1：未支付, 2：已支付3：已退费',
  `CARD_TYPE` int(1) DEFAULT NULL COMMENT '绑定诊疗卡类型',
  `CARD_NO` varchar(32) DEFAULT NULL COMMENT '绑定诊疗卡号',
  `OPEN_ID` varchar(100) NOT NULL COMMENT '用户openId',
  `IS_EXCEPTION` int(1) DEFAULT NULL COMMENT '是否发生异常  0 否 1是',
  `IS_HANDLE_SUCCESS` int(1) DEFAULT NULL COMMENT '是否处理成功   1是   0 否',
  `HANDLE_COUNT` int(1) DEFAULT NULL COMMENT '处理次数',
  `HANDLE_LOG` varchar(1200) DEFAULT NULL COMMENT '异常处理日志',
  `PATIENT_NAME` varchar(10) DEFAULT NULL COMMENT '患者姓名',
  `ORDER_NO` varchar(23) DEFAULT NULL,
  `ORDER_NO_HASH_VAL` bigint(20) DEFAULT NULL,
  `REFUND_ORDER_NO` varchar(23) DEFAULT NULL,
  `REFUND_HISORD_NO` varchar(50) DEFAULT NULL,
  `AGT_ORD_NUM` varchar(50) DEFAULT NULL,
  `AGT_REFUND_ORD_NUM` varchar(50) DEFAULT NULL,
  `FEE_DESC` varchar(500) DEFAULT NULL COMMENT '费用说明',
  `IS_HAD_CALL_BACK` int(1) unsigned zerofill DEFAULT '0' COMMENT '是否已被支付回调  1 是  0 否',
  `RECORD_TITLE` varchar(250) DEFAULT NULL COMMENT '记录名称',
  `FAILURE_MSG` varchar(2000) DEFAULT NULL,
  `IS_VALID` int(1) DEFAULT '1' COMMENT '1有效   0 无效',
  `CLINIC_STATUS` int(1) DEFAULT '0' COMMENT '0待缴费,1已缴费,2缴费失败,3缴费异常',
  `MZFEE_ID` varchar(4000) NOT NULL,
  `PAY_IDS` varchar(1000) NOT NULL COMMENT '对应His订单号列表, 英文逗号隔开',
  `MEDICARE_TYPE` varchar(50) DEFAULT '' COMMENT '医保类型',
  `TOTAL_FEE` int(11) DEFAULT NULL COMMENT '单位：分,总金额',
  `MEDICARE_FEE` int(11) DEFAULT NULL COMMENT '单位：分,医保金额',
  `PAY_FEE` int(11) DEFAULT NULL COMMENT '单位：分,实付金额',
  `BARCODE` varchar(32) DEFAULT NULL,
  `DOCTOR_NAME` varchar(50) DEFAULT NULL COMMENT '医生名称',
  `DEPT_NAME` varchar(50) DEFAULT NULL COMMENT '科室名称',
  `TRADE_MODE` int(1) DEFAULT NULL COMMENT '支付方式：1微信，2支付宝，..银联',
  `PAY_MODE` int(1) DEFAULT NULL COMMENT '支付渠道 1微信，2支付宝',
  `HIS_ORD_NO` varchar(50) DEFAULT NULL COMMENT '医院交易流水号',
  `RECEIPT_NUM` varchar(4000) DEFAULT '' COMMENT '收据号',
  `HIS_MESSAGE` varchar(4000) DEFAULT '' COMMENT '医院返回的取药信息',
  `CREATE_TIME` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `PAY_TIME` bigint(20) DEFAULT NULL COMMENT '支付时间',
  `REFUND_TIME` bigint(20) DEFAULT NULL COMMENT '退费时间',
  `PATIENT_MOBILE` varchar(20) DEFAULT NULL COMMENT '电话号码',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CLINICRECORD_ORDER_NO` (`ORDER_NO`) USING BTREE,
  KEY `INDEX_CLINICRECORD_ORDER_NO_OPEN_ID` (`CARD_NO`,`OPEN_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


drop table if exists BIZ_VOTE;
/*==============================================================*/
/* Table: BIZ_VOTE         评价                                   */
/*==============================================================*/
create table BIZ_VOTE
(
   ID                   varchar(32) comment '主键ID(32位UUID)',
   HOSPITAL_ID          varchar(32),
   HOSPITAL_CODE        varchar(50),
   HOSPITAL_NAME        varchar(32),
   APP_ID               varchar(50),
   APP_CODE             varchar(10),
   OPEN_ID              varchar(50),
   CARD_NO              varchar(50),
   BIZ_CODE             varchar(10),
   APPRAISE_LEVEL       smallint comment '0  赞  1  踩',
   SUGGESTION           text,
   ORDER_NO             varchar(50) comment '订单号',
   ORDER_NO_HASH_VAL    bigint,
   RATER_CODE           varchar(50),
   primary key (ID)
);

alter table BIZ_VOTE comment '评价';

DROP TABLE IF EXISTS `BIZ_DEPOSIT_RECORD_1`;
/*==============================================================*/
/* Table: BIZ_INPATIENT_RECORD_1         住院押金补缴订单表                                 */
/*==============================================================*/
CREATE TABLE `BIZ_DEPOSIT_RECORD_1` (
  `ID` varchar(32) NOT NULL,
  `HOSPITAL_ID` varchar(32) DEFAULT NULL,
  `HOSPITAL_CODE` varchar(100) DEFAULT NULL COMMENT '医院代码',
  `HOSPITAL_NAME` varchar(100) DEFAULT NULL,
  `BRANCH_ID` varchar(32) DEFAULT NULL,
  `BRANCH_CODE` varchar(100) DEFAULT NULL,
  `PAY_STATUS` int(1) DEFAULT NULL COMMENT '支付状态：1：未支付, 2：已支付3：已退费',
  `CARD_TYPE` int(1) DEFAULT NULL COMMENT '绑定诊疗卡类型',
  `CARD_NO` varchar(32) DEFAULT NULL COMMENT '绑定诊疗卡号',
  `OPEN_ID` varchar(100) NOT NULL COMMENT '用户openId',
  `IS_EXCEPTION` int(1) DEFAULT NULL COMMENT '是否发生异常  0 否 1是',
  `IS_HANDLE_SUCCESS` int(1) DEFAULT NULL COMMENT '是否处理成功   1是   0 否',
  `HANDLE_COUNT` int(1) DEFAULT NULL COMMENT '处理次数',
  `HANDLE_LOG` varchar(1200) DEFAULT NULL COMMENT '异常处理日志',
  `PATIENT_NAME` varchar(10) DEFAULT NULL COMMENT '患者姓名',
  `ORDER_NO` varchar(23) DEFAULT NULL,
  `ORDER_NO_HASH_VAL` bigint(20) DEFAULT NULL,
  `REFUND_ORDER_NO` varchar(23) DEFAULT NULL,
  `REFUND_HISORD_NO` varchar(50) DEFAULT NULL,
  `AGT_ORD_NUM` varchar(50) DEFAULT NULL,
  `AGT_REFUND_ORD_NUM` varchar(50) DEFAULT NULL,
  `FEE_DESC` varchar(500) DEFAULT NULL COMMENT '费用说明',
  `IS_HAD_CALL_BACK` int(1) unsigned zerofill DEFAULT '0' COMMENT '是否已被支付回调  1 是  0 否',
  `RECORD_TITLE` varchar(250) DEFAULT NULL COMMENT '记录名称',
  `FAILURE_MSG` varchar(2000) DEFAULT NULL,
  `IS_VALID` int(1) DEFAULT '1' COMMENT '1有效   0 无效',
  `DEPOSIT_STATUS` int(1) DEFAULT '0' COMMENT '0待缴费,1已缴费,2缴费失败,3缴费异常',
  `ADMISSION_NO` varchar(30) DEFAULT NULL COMMENT '住院号',
  `INTIME` int(10) DEFAULT NULL COMMENT '使用该住院号的住院次数',
  `INPATIENT_ID` varchar(30) DEFAULT NULL COMMENT '住院编号，表示唯一的一次住院',
  `TOTAL_FEE` int(11) DEFAULT NULL COMMENT '单位：分,总金额',
  `PAID_FEE` int(11) DEFAULT NULL COMMENT '单位：分,总金额',
  `PAY_FEE` int(11) DEFAULT NULL COMMENT '单位：分, 本次支付金额',
  `BALANCE_BEFORE_PAY` int(11) DEFAULT NULL COMMENT '缴费前余额(His返回)',
  `BALANCE_AFTER_PAY` int(11) DEFAULT NULL COMMENT '缴费后余额(His返回)',
  `BARCODE` varchar(32) DEFAULT NULL COMMENT '条形码',
  `PAY_MODE` int(1) DEFAULT NULL COMMENT '支付渠道 1微信，2支付宝',
  `HIS_ORD_NO` varchar(50) DEFAULT NULL COMMENT '医院交易流水号',
  `RECEIPT_NUM` varchar(50) DEFAULT '' COMMENT '收据号',
  `CREATE_TIME` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `PAY_TIME` bigint(20) DEFAULT NULL COMMENT '支付时间',
  `REFUND_TIME` bigint(20) DEFAULT NULL COMMENT '退费时间',
  `PATIENT_MOBILE` varchar(20) DEFAULT '' COMMENT '手机号码',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_INPATIENTRECORD_ORDER_NO` (`ORDER_NO`) USING BTREE,
  KEY `INDEX_INPATIENTRECORD_ORDER_NO_OPEN_ID` (`CARD_NO`,`OPEN_ID`) USING BTREE
) 
alter table BIZ_DEPOSIT_RECORD_1 comment '住院押金补缴表';

/*
Navicat MySQL Data Transfer

Source Server         : 外网标准版
Source Server Version : 50173
Source Host           : 192.168.8.169:3306
Source Database       : yx129_dev

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2015-09-22 16:42:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for BIZ_CLINIC_PART_REFUND_RECORD
-- ----------------------------
DROP TABLE IF EXISTS `BIZ_CLINIC_PART_REFUND_RECORD`;
CREATE TABLE `BIZ_CLINIC_PART_REFUND_RECORD` (
  `ID` varchar(32) NOT NULL,
  `HOSPITAL_ID` varchar(32) DEFAULT NULL,
  `HOSPITAL_CODE` varchar(100) DEFAULT NULL COMMENT '医院代码',
  `HOSPITAL_NAME` varchar(100) DEFAULT NULL,
  `BRANCH_ID` varchar(32) DEFAULT NULL,
  `BRANCH_CODE` varchar(100) NOT NULL,
  `CARD_TYPE` int(1) DEFAULT NULL COMMENT '绑定诊疗卡类型',
  `CARD_NO` varchar(32) DEFAULT NULL COMMENT '绑定诊疗卡号',
  `OPEN_ID` varchar(100) NOT NULL COMMENT '用户openId',
  `IS_EXCEPTION` int(1) DEFAULT NULL COMMENT '是否发生异常  0 否 1是',
  `IS_HANDLE_SUCCESS` int(1) DEFAULT NULL COMMENT '是否处理成功   1是   0 否',
  `HANDLE_COUNT` int(1) DEFAULT NULL COMMENT '处理次数',
  `HANDLE_LOG` varchar(1200) DEFAULT NULL COMMENT '异常处理日志',
  `PATIENT_NAME` varchar(10) DEFAULT NULL COMMENT '患者姓名',
  `ORDER_NO` varchar(23) DEFAULT NULL COMMENT '原平台订单号',
  `REFUND_ORDER_NO` varchar(23) DEFAULT NULL COMMENT '退费订单号',
  `REFUND_ORDER_NO_HASH_VAL` bigint(20) DEFAULT NULL,
  `REFUND_HIS_ORD_NO` varchar(50) DEFAULT NULL,
  `AGT_REFUND_ORD_NUM` varchar(50) DEFAULT NULL,
  `FEE_DESC` varchar(500) DEFAULT NULL COMMENT '费用说明',
  `IS_HAD_CALL_BACK` int(1) unsigned zerofill DEFAULT '0' COMMENT '是否已被退费回调  1 是  0 否',
  `RECORD_TITLE` varchar(250) DEFAULT NULL COMMENT '记录名称',
  `FAILURE_MSG` varchar(1000) DEFAULT NULL,
  `REFUND_STATUS` int(1) DEFAULT '0' COMMENT '0待缴费,1已缴费,2缴费失败,3缴费异常',
  `TOTAL_FEE` int(11) DEFAULT NULL COMMENT '单位：分,总金额',
  `REFUND_FEE` int(11) DEFAULT NULL COMMENT '单位：分,本次退费金额',
  `REFUND_MODE` int(1) DEFAULT NULL COMMENT '原订单渠道 1微信，2支付宝',
  `HIS_ORD_NO` varchar(50) DEFAULT NULL COMMENT '医院交易流水号',
  `CREATE_TIME` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `REFUND_TIME` bigint(20) DEFAULT NULL COMMENT '退费时间',
  `PATIENT_MOBILE` varchar(20) DEFAULT '' COMMENT '手机号码',
  PRIMARY KEY (`ID`,`BRANCH_CODE`),
  UNIQUE KEY `INDEX_CLINIC_PART_REFFUND_ORDER_NO` (`REFUND_ORDER_NO`) USING BTREE,
  KEY `INDEX_CLINIC_PART_REFUND_REFUND_ORDER` (`REFUND_STATUS`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table 客服中心反馈意见表 `BIZ_CUSTOM_FEEDBACK`
-- ----------------------------
DROP TABLE IF EXISTS `BIZ_CUSTOM_FEEDBACK`;
CREATE TABLE `BIZ_CUSTOM_FEEDBACK` (
  `ID` varchar(32) NOT NULL COMMENT '客服中心反馈意见表ID',
  `OPEN_ID` varchar(100) DEFAULT NULL COMMENT 'openID',
  `PLATFORM_TYPE` varchar(10) DEFAULT NULL COMMENT '平台类型(wechat alipay easyhealth)',
  `FEEDBACK` varchar(2000) DEFAULT NULL COMMENT '用户建议反馈',
  `CT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
