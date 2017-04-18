--数据库更新脚本文件
-------------------------------------2015年6月18日 16:10:59 添加/更新字段  更新人：周鉴斌 start------------------------------------------------------
alter table SYS_PAY_SETTINGS add IS_SUB_PAY int(1) comment '是否子商户支付 0：非子商户 1：子商户';

alter table SYS_PAY_SETTINGS add PARTNER_ID VARCHAR(100) comment '合作者Id 暂时为支付宝使用';

alter table SYS_PAY_SETTINGS add SUB_MCH_ID VARCHAR(100) comment '子商户号';

alter table SYS_PAY_MODE add code varchar(50) comment '支付方式编码';



alter table SYS_MENU add OPTIONAL_ID varchar(32) comment '功能ID';

alter table SYS_MENU add GRAPHICS_ID varchar(32) comment '图文ID';

alter table SYS_MENU add MEUN_TYPE int(1) comment '菜单类型 0：功能 1：图文 2：链接地址';


alter table SYS_PLATFORM_SETTINGS add TOKEN varchar(100) comment 'token值';

alter table SYS_PLATFORM_SETTINGS add WECHAT_ACCOUNT varchar(100) comment '微信公众帐号';

alter table SYS_OPTIONAL add BIZ_CODE int(2) comment '公共页面跳转业务编码 挂号：1  门诊：2 住院：3  检验检查：4';

alter table SYS_ATTACH add ATTACH_ID varchar(32) comment '表单ID';

alter table SYS_ATTACH add ATTACH_TYPE int(2) comment '文件类型 0：图片 1：文档 2：密钥 3：其他';

-------------------------------------2015年6月18日 16:10:59 添加/更新字段  更新人：周鉴斌 end------------------------------------------------------


-------------------------------------2015年6月23日 16:10:59 添加/更新字段  更新人：罗斌 start------------------------------------------------------

alter table SYS_MSG_RULE add THIRD_TYPE int comment '公众平台类型（1微信 2支付宝）';

alter table SYS_MSG_MIXED_METERIAL modify CONTENT varchar(10000) comment '正文';


-------------------------------------2015年6月23日 16:10:59 添加/更新字段  更新人：罗斌 end------------------------------------------------------

-------------------------------------2015年7月1日 20:51:46 添加/更新字段  更新人：周鉴斌 end------------------------------------------------------
alter table SYS_PAY_SETTINGS modify PAY_URL varchar(10000) comment '支付宝支付私钥';
-------------------------------------2015年7月1日 20:51:53 添加/更新字段  更新人：周鉴斌 end------------------------------------------------------

-------------------------------------2015年7月23日 20:16:45 添加/更新字段  更新人：周鉴斌 end------------------------------------------------------
alter table SYS_RULE_EDIT add PUSH_INFO_DAY INTEGER comment '停诊查询天数';
-------------------------------------2015年7月23日 20:16:45 添加/更新字段  更新人：周鉴斌 end------------------------------------------------------

-------------------------------------2015年8月14日 18:16:45 添加/更新字段  更新人：罗斌 start------------------------------------------------------
alter table SYS_MSG_MIXED_METERIAL add WECHAT_PIC_PATH varchar(1000) comment '微信图文上传图片路径';
-------------------------------------2015年8月14日 18:16:45 添加/更新字段  更新人：罗斌  end------------------------------------------------------

-------------------------------------2015年8月21日 16:16:45 添加/更新字段  更新人：罗斌 start------------------------------------------------------
alter table SYS_MSG_LOG add ERROR_CODE varchar(100) comment '公众平台错误代码err_code';
alter table SYS_MSG_LOG add ERROR_MSG varchar(1000) comment '公众平台错误信息err_msg';
alter table SYS_MSG_TEMPLATE_LIBRARY add TOP_COLOR varchar(50) comment '顶部颜色';
alter table SYS_MSG_TEMPLATE_LIBRARY add URL varchar(500) comment 'url';

-------------------------------------2015年8月21日 16:16:45 添加/更新字段  更新人：罗斌  end------------------------------------------------------


-------------------------------------2015年9月24日 09:16:45 添加/更新字段  更新人：罗斌 start------------------------------------------------------
alter table SYS_RULE_PUSH_WECHAT add CLINIC_REFUND int(1) DEFAULT '0' COMMENT '门诊退费是否推送(1-是  0-否)';
alter table SYS_RULE_PUSH_WECHAT add CLINIC_REFUND_CODE varchar(100) DEFAULT NULL COMMENT '门诊退费编号';
alter table SYS_RULE_PUSH_WECHAT add CLINIC_REFUND_PART int(1) DEFAULT '0' COMMENT '门诊部分退费是否推送(1-是  0-否)';
alter table SYS_RULE_PUSH_WECHAT add CLINIC_REFUND_PART_CODE varchar(100) DEFAULT NULL COMMENT '门诊部分退费编号';

alter table SYS_RULE_PUSH_ALIPAY add CLINIC_REFUND int(1) DEFAULT '0' COMMENT '门诊退费是否推送(1-是  0-否)';
alter table SYS_RULE_PUSH_ALIPAY add CLINIC_REFUND_CODE varchar(100) DEFAULT NULL COMMENT '门诊退费编号';
alter table SYS_RULE_PUSH_ALIPAY add CLINIC_REFUND_PART int(1) DEFAULT '0' COMMENT '门诊部分退费是否推送(1-是  0-否)';
alter table SYS_RULE_PUSH_ALIPAY add CLINIC_REFUND_PART_CODE varchar(100) DEFAULT NULL COMMENT '门诊部分退费编号';

-------------------------------------2015年9月24日 09:16:45 添加/更新字段  更新人：罗斌  end------------------------------------------------------


-------------------------------------2015年10月13日 11:30:25 添加/更新字段  更新人：周鉴斌 start------------------------------------------------------
alter table SYS_HOSPITAL add AREA_CODE varchar(50) comment '医院区域代码';

-------------------------------------2015年10月13日 11:30:29 添加/更新字段  更新人：周鉴斌  end------------------------------------------------------

-------------------------------------2015年10月15日 14:43:25 添加/更新字段  更新人：申午武 start------------------------------------------------------
alter table SYS_MSG_TEMPLATE_LIBRARY add ICON_NAME varchar(50) comment '图标名称';
alter table SYS_MSG_TEMPLATE_LIBRARY add ICON_PATH varchar(500) comment '图标地址';
alter table SYS_MSG_TEMPLATE_LIBRARY add ANIMATION_NAME varchar(50) comment '动画名称';
alter table SYS_MSG_TEMPLATE_LIBRARY add ANIMATION_PATH varchar(500) comment '动画地址';

alter table SYS_MSG_TEMPLATE add ICON_NAME varchar(50) comment '图标名称';
alter table SYS_MSG_TEMPLATE add ICON_PATH varchar(500) comment '图标地址';
alter table SYS_MSG_TEMPLATE add ANIMATION_NAME varchar(50) comment '动画名称';
alter table SYS_MSG_TEMPLATE add ANIMATION_PATH varchar(500) comment '动画地址';

-------------------------------------2015年10月15日 14:43:29 添加/更新字段  更新人：申午武  end------------------------------------------------------

-------------------------------------2015年10月18日 19:30:25 添加/更新字段  更新人：罗斌 start------------------------------------------------------
alter table SYS_RULE_PUSH_ALIPAY add SEND_COMMENT int(1) DEFAULT '0' COMMENT '发表评价是否推送(1-是  0-否)';
alter table SYS_RULE_PUSH_ALIPAY add SEND_COMMENT_CODE varchar(100) DEFAULT NULL COMMENT '发表评价编号';
alter table SYS_RULE_PUSH_WECHAT add SEND_COMMENT int(1) DEFAULT '0' COMMENT '发表评价是否推送(1-是  0-否)';
alter table SYS_RULE_PUSH_WECHAT add SEND_COMMENT_CODE varchar(100) DEFAULT NULL COMMENT '发表评价编号';
alter table SYS_RULE_PUSH_EASYHEALTH add SEND_COMMENT int(1) DEFAULT '0' COMMENT '发表评价是否推送(1-是  0-否)';
alter table SYS_RULE_PUSH_EASYHEALTH add SEND_COMMENT_CODE varchar(100) DEFAULT NULL COMMENT '发表评价编号';

-------------------------------------2015年10月18日 19:30:29 添加/更新字段  更新人：罗斌  end------------------------------------------------------

alter table SYS_OPTIONAL add IS_EASY_HEALTH int(1)  DEFAULT '0' COMMENT '是否健康易功能 0:否 1：是';

-------------------------------------2015年11月06日 09:28 健康易用户表身份证字段添加唯一约束  更新人：YY  start------------------------------------------------------

ALTER TABLE EH_USER_1 ADD UNIQUE (CARD_NO);
ALTER TABLE EH_USER_2 ADD UNIQUE (CARD_NO);
ALTER TABLE EH_USER_3 ADD UNIQUE (CARD_NO);
ALTER TABLE EH_USER_4 ADD UNIQUE (CARD_NO);
ALTER TABLE EH_USER_5 ADD UNIQUE (CARD_NO);
ALTER TABLE EH_USER_6 ADD UNIQUE (CARD_NO);
ALTER TABLE EH_USER_7 ADD UNIQUE (CARD_NO);
ALTER TABLE EH_USER_8 ADD UNIQUE (CARD_NO);
ALTER TABLE EH_USER_9 ADD UNIQUE (CARD_NO);
ALTER TABLE EH_USER_10 ADD UNIQUE (CARD_NO);

-------------------------------------2015年11月06日 09:28 健康易用户表身份证字段添加唯一约束  更新人：YY  over------------------------------------------------------


-------------------------------------2015年12月02日 15:50 健康易用户表添加账号字段并添加账号唯一约束和把所有的身份证信息录入账号字段  更新人：YY  start------------------

ALTER TABLE EH_USER_1 ADD ACCOUNT VARCHAR(50);
ALTER TABLE EH_USER_2 ADD ACCOUNT VARCHAR(50);
ALTER TABLE EH_USER_3 ADD ACCOUNT VARCHAR(50);
ALTER TABLE EH_USER_4 ADD ACCOUNT VARCHAR(50);
ALTER TABLE EH_USER_5 ADD ACCOUNT VARCHAR(50);
ALTER TABLE EH_USER_6 ADD ACCOUNT VARCHAR(50);
ALTER TABLE EH_USER_7 ADD ACCOUNT VARCHAR(50);
ALTER TABLE EH_USER_8 ADD ACCOUNT VARCHAR(50);
ALTER TABLE EH_USER_9 ADD ACCOUNT VARCHAR(50);
ALTER TABLE EH_USER_10 ADD ACCOUNT VARCHAR(50);

ALTER TABLE EH_USER_1 ADD UNIQUE INDEX `IDX_EH_USER_1_ACCOUNT` USING BTREE (`ACCOUNT`) ;
ALTER TABLE EH_USER_2 ADD UNIQUE INDEX `IDX_EH_USER_2_ACCOUNT` USING BTREE (`ACCOUNT`) ;
ALTER TABLE EH_USER_3 ADD UNIQUE INDEX `IDX_EH_USER_3_ACCOUNT` USING BTREE (`ACCOUNT`) ;
ALTER TABLE EH_USER_4 ADD UNIQUE INDEX `IDX_EH_USER_4_ACCOUNT` USING BTREE (`ACCOUNT`) ;
ALTER TABLE EH_USER_5 ADD UNIQUE INDEX `IDX_EH_USER_5_ACCOUNT` USING BTREE (`ACCOUNT`) ;
ALTER TABLE EH_USER_6 ADD UNIQUE INDEX `IDX_EH_USER_6_ACCOUNT` USING BTREE (`ACCOUNT`) ;
ALTER TABLE EH_USER_7 ADD UNIQUE INDEX `IDX_EH_USER_7_ACCOUNT` USING BTREE (`ACCOUNT`) ;
ALTER TABLE EH_USER_8 ADD UNIQUE INDEX `IDX_EH_USER_8_ACCOUNT` USING BTREE (`ACCOUNT`) ;
ALTER TABLE EH_USER_9 ADD UNIQUE INDEX `IDX_EH_USER_9_ACCOUNT` USING BTREE (`ACCOUNT`) ;
ALTER TABLE EH_USER_10 ADD UNIQUE INDEX `IDX_EH_USER_10_ACCOUNT` USING BTREE (`ACCOUNT`) ;

UPDATE EH_USER_1 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;
UPDATE EH_USER_2 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;
UPDATE EH_USER_3 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;
UPDATE EH_USER_4 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;
UPDATE EH_USER_5 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;
UPDATE EH_USER_6 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;
UPDATE EH_USER_7 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;
UPDATE EH_USER_8 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;
UPDATE EH_USER_9 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;
UPDATE EH_USER_10 SET ACCOUNT = CARD_NO WHERE ACCOUNT IS NULL;

-------------------------------------2015年12月02日 15:50 健康易用户表添加账号字段并添加账号唯一约束和把所有的身份证信息录入账号字段  更新人：YY  over------------------


-------------------------------------2015年12月08日 14:24 健康易用户表添加生日、性别、地址字段  更新人：YY  start------------------

ALTER TABLE `EH_USER_1`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

ALTER TABLE `EH_USER_2`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

ALTER TABLE `EH_USER_3`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

ALTER TABLE `EH_USER_4`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

ALTER TABLE `EH_USER_5`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

ALTER TABLE `EH_USER_6`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

ALTER TABLE `EH_USER_7`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

ALTER TABLE `EH_USER_8`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

ALTER TABLE `EH_USER_9`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

ALTER TABLE `EH_USER_10`
ADD COLUMN `BIRTHDAY`  varchar(20) NULL AFTER `ACCOUNT`,
ADD COLUMN `SEX`  smallint NULL AFTER `BIRTHDAY`,
ADD COLUMN `ADDRESS`  varchar(500) NULL AFTER `SEX`;

-------------------------------------2015年12月08日 14:24 健康易用户表添加生日、性别、地址字段  更新人：YY  over------------------

-------------------------------------2015年12月08日 16:42 健康易用户表删除证件号唯一索引  更新人：YY  start------------------
------------完善资料填写证件号需呀验证是否被使用，但有需要兼容以前用身份证注册的用户，如果使用手机号注册可以用原来的身份证补充资料

ALTER TABLE `EH_USER_1` DROP INDEX `CARD_NO`;
ALTER TABLE `EH_USER_2` DROP INDEX `CARD_NO`;
ALTER TABLE `EH_USER_3` DROP INDEX `CARD_NO`;
ALTER TABLE `EH_USER_4` DROP INDEX `CARD_NO`;
ALTER TABLE `EH_USER_5` DROP INDEX `CARD_NO`;
ALTER TABLE `EH_USER_6` DROP INDEX `CARD_NO`;
ALTER TABLE `EH_USER_7` DROP INDEX `CARD_NO`;
ALTER TABLE `EH_USER_8` DROP INDEX `CARD_NO`;
ALTER TABLE `EH_USER_9` DROP INDEX `CARD_NO`;
ALTER TABLE `EH_USER_10` DROP INDEX `CARD_NO`;


ALTER TABLE `EH_USER_1` ADD INDEX `IDX_EH_USER_1_CARD_NO` USING BTREE (`CARD_NO`) ;
ALTER TABLE `EH_USER_2` ADD INDEX `IDX_EH_USER_2_CARD_NO` USING BTREE (`CARD_NO`) ;
ALTER TABLE `EH_USER_3` ADD INDEX `IDX_EH_USER_3_CARD_NO` USING BTREE (`CARD_NO`) ;
ALTER TABLE `EH_USER_4` ADD INDEX `IDX_EH_USER_4_CARD_NO` USING BTREE (`CARD_NO`) ;
ALTER TABLE `EH_USER_5` ADD INDEX `IDX_EH_USER_5_CARD_NO` USING BTREE (`CARD_NO`) ;
ALTER TABLE `EH_USER_6` ADD INDEX `IDX_EH_USER_6_CARD_NO` USING BTREE (`CARD_NO`) ;
ALTER TABLE `EH_USER_7` ADD INDEX `IDX_EH_USER_7_CARD_NO` USING BTREE (`CARD_NO`) ;
ALTER TABLE `EH_USER_8` ADD INDEX `IDX_EH_USER_8_CARD_NO` USING BTREE (`CARD_NO`) ;
ALTER TABLE `EH_USER_9` ADD INDEX `IDX_EH_USER_9_CARD_NO` USING BTREE (`CARD_NO`) ;
ALTER TABLE `EH_USER_10` ADD INDEX `IDX_EH_USER_10_CARD_NO` USING BTREE (`CARD_NO`) ;


ALTER TABLE `EH_USER_1` ADD INDEX `IDX_EH_USER_1_MOBILE` USING BTREE (`MOBILE`) ;
ALTER TABLE `EH_USER_2` ADD INDEX `IDX_EH_USER_2_MOBILE` USING BTREE (`MOBILE`) ;
ALTER TABLE `EH_USER_3` ADD INDEX `IDX_EH_USER_3_MOBILE` USING BTREE (`MOBILE`) ;
ALTER TABLE `EH_USER_4` ADD INDEX `IDX_EH_USER_4_MOBILE` USING BTREE (`MOBILE`) ;
ALTER TABLE `EH_USER_5` ADD INDEX `IDX_EH_USER_5_MOBILE` USING BTREE (`MOBILE`) ;
ALTER TABLE `EH_USER_6` ADD INDEX `IDX_EH_USER_6_MOBILE` USING BTREE (`MOBILE`) ;
ALTER TABLE `EH_USER_7` ADD INDEX `IDX_EH_USER_7_MOBILE` USING BTREE (`MOBILE`) ;
ALTER TABLE `EH_USER_8` ADD INDEX `IDX_EH_USER_8_MOBILE` USING BTREE (`MOBILE`) ;
ALTER TABLE `EH_USER_9` ADD INDEX `IDX_EH_USER_9_MOBILE` USING BTREE (`MOBILE`) ;
ALTER TABLE `EH_USER_10` ADD INDEX `IDX_EH_USER_10_MOBILE` USING BTREE (`MOBILE`) ;

-------------------------------------2015年12月08日 16:42 健康易用户表删除证件号唯一索引  更新人：YY  over------------------
-------------------------------------2015年12月15日 10:42 后台医院管理-分院表增加经纬度  更新人：罗斌 start  楼上么么哒------------------------
alter table SYS_BRANCH_HOSPITAL add LATITUDE varchar(50) DEFAULT NULL COMMENT '分院纬度';
alter table SYS_BRANCH_HOSPITAL add LONGITUDE varchar(50) DEFAULT NULL COMMENT '分院经度';
-------------------------------------2015年12月15日 10:42 后台医院管理-分院表增加经纬度 罗斌  end-------------------------------------------

-------------------------------------2015年12月15日 10:42 消息推送配置增加注册后推送提醒  更新人：罗斌 start  ---------------------------------
alter table SYS_RULE_PUSH_ALIPAY add FINISH_USER_INFO int(1) DEFAULT '0' COMMENT '注册后是否发送完善资料消息(1-是  0-否)';
alter table SYS_RULE_PUSH_ALIPAY add FINISH_USER_INFO_CODE varchar(100) DEFAULT NULL COMMENT '注册后是否发送完善资料消息code';
alter table SYS_RULE_PUSH_WECHAT add FINISH_USER_INFO int(1) DEFAULT '0' COMMENT '注册后是否发送完善资料消息(1-是  0-否)';
alter table SYS_RULE_PUSH_WECHAT add FINISH_USER_INFO_CODE varchar(100) DEFAULT NULL COMMENT '注册后是否发送完善资料消息code';
alter table SYS_RULE_PUSH_EASYHEALTH add FINISH_USER_INFO int(1) DEFAULT '0' COMMENT '注册后是否发送完善资料消息(1-是  0-否)';
alter table SYS_RULE_PUSH_EASYHEALTH add FINISH_USER_INFO_CODE varchar(100) DEFAULT NULL COMMENT '注册后是否发送完善资料消息code';
-------------------------------------2015年12月15日 10:42 消息推送配置增加注册后推送提醒   罗斌  end-------------------------

-------------------------------------2015年12月17日  15:42  客服反馈表增加客服回复字段  更新人：罗斌 start  ----------------------
alter table BIZ_CUSTOM_FEEDBACK add FEEDBACK_REPLY varchar(2000) DEFAULT NULL COMMENT '回复内容';
-------------------------------------2015年12月17日  15:42  客服反馈表增加客服回复字段  更新人：罗斌 end  ------------------------


-------------------------------------2015年12月31日  15:42  医院表增加url配置及logo字段  更新人：罗斌 start  -----------------------
alter table SYS_HOSPITAL add GUIDE_URL varchar(200) DEFAULT NULL COMMENT '就医指南';
alter table SYS_HOSPITAL add CLOUD_HOSP_URL varchar(200) DEFAULT NULL COMMENT '云医院';
alter table SYS_HOSPITAL add TRAFFIC_URL varchar(300) DEFAULT NULL COMMENT '交通指引';
alter table SYS_HOSPITAL add LOGO varchar(300) DEFAULT NULL COMMENT 'LOGO';
-------------------------------------2015年12月31日  15:42  医院表增加url配置及logo字段  更新人：罗斌 end  -----------------------


-------------------------------------2016年01月21日  15:42  用户表添加支付宝ID和微信ID字段  更新人：YY start  -----------------------
ALTER TABLE `EH_USER_1` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
ALTER TABLE `EH_USER_2` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
ALTER TABLE `EH_USER_3` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
ALTER TABLE `EH_USER_4` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
ALTER TABLE `EH_USER_5` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
ALTER TABLE `EH_USER_6` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
ALTER TABLE `EH_USER_7` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
ALTER TABLE `EH_USER_8` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
ALTER TABLE `EH_USER_9` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
ALTER TABLE `EH_USER_10` ADD COLUMN `ALIPAY_ID`  varchar(50) NULL, ADD COLUMN `WECHAT_ID`  varchar(50) NULL;
-------------------------------------2016年01月21日  15:42  用户表添加支付宝ID和微信ID字段  更新人：YY end  -----------------------









