/*=========================================================================================================*/
/*                                                                                                         */
/*              云医通标准平台后台系统建表sql                                                                */
/*                                                                                                          */
/*                                                                                                          */
/*=====================医院管理  Yuce 2015-5-27 start =========================================================*/
drop table if exists SYS_HOSPITAL;
drop table if exists SYS_BRANCH_HOSPITAL;
drop table if exists SYS_OPTIONAL;
drop table if exists SYS_MENU;
drop table if exists SYS_PLATFORM;
drop table if exists SYS_HOSPITAL_OPTIONAL;
drop table if exists SYS_HOSPITAL_PLATFORM_SETTINGS;
drop table if exists SYS_PLATFORM_SETTINGS;
drop table if exists SYS_PLATFORM_SETTINGS_MENU;
drop table if exists SYS_HOSPITAL_PAY_SETTINGS;
drop table if exists SYS_PAY_MODE;
drop table if exists SYS_PAY_SETTINGS;

/*==============================================================*/
/* Table: SYS_HOSPITAL         医院表                                                                        */
/*==============================================================*/
create table SYS_HOSPITAL
(
   ID                   varchar(32) not null ,
   NAME                 varchar(50),
   CODE                 varchar(50),
   CONTACT_NAME         varchar(50),
   CONTACT_TEL          varchar(50),
   STATUS               int,
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   RULE_LAST_EDIT_TIME  datetime comment '最后修改时间',
   RULE_PUBLISH_TIME    datetime comment '发布时间',
   IS_PUBLISH_RULE      int default 0 comment '是否发布规则 0否  1是 默认0',
   RULE_LAST_HANDLER_ID      varchar(32) comment '最后操作人' ,
   SVC_TYPE varchar(1)  default '1' comment '医院类型，1-真正的医院，2-服务平台',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_BRANCH_HOSPITAL                     分院表                     */
/*==============================================================*/
create table SYS_BRANCH_HOSPITAL
(
   ID                   varchar(32) not null ,
   HOSPITAL_ID          varchar(32),
   CODE                 varchar(50),
   INTERFACE_ID         varchar(100),
   NAME                 varchar(50),
   ADDRESS              varchar(50),
   TEL                  varchar(50),
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_OPTIONAL            可选功能表                                                      */
/*==============================================================*/
create table SYS_OPTIONAL
(
   ID                   varchar(32) not null ,
   NAME                 varchar(50),
   CONTROLLER_PATH      varchar(300),
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   BIZ_CODE 			int(2) comment '公共页面跳转业务编码 挂号：1  门诊：2 住院：3  检验检查：4',
   primary key (ID)
);



/*==============================================================*/
/* Table: SYS_HOSPITAL_OPTIONAL              医院可选功能中间表     */
/*==============================================================*/
create table SYS_HOSPITAL_OPTIONAL
(
   ID                   varchar(32) not null ,
   HOSPITAL_ID          varchar(32),
   OPTIONAL_ID          varchar(32),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_HOSPITAL_PLATFORM_SETTINGS      医院和接入平台配置信息中间表    */
/*==============================================================*/
create table SYS_HOSPITAL_PLATFORM_SETTINGS
(
   ID                   varchar(32) not null ,
   PLATFORM_SETTINGS_ID varchar(32),
   HOSPITAL_ID          varchar(32),
   STATUS               int,
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_PLATFORM_SETTINGS           接入平台配置信息表     */
/*==============================================================*/
create table SYS_PLATFORM_SETTINGS
(
   ID                   varchar(32) not null ,
   APP_ID               varchar(50),
   PRIVATE_KEY          varchar(1000),
   PUBLIC_KEY           varchar(1000),
   PLATFORM_ID          varchar(32),
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);



/*==============================================================*/
/* Table: SYS_PLATFORM_SETTINGS_MENU      平台配置信息和自定义菜单中间表 */
/*==============================================================*/
create table SYS_PLATFORM_SETTINGS_MENU
(
   ID                   varchar(32) not null ,
   PLATFORM_SETTINGS_ID varchar(32),
   MENU_ID              varchar(32),
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_MENU            自定义菜单表            */
/*==============================================================*/
create table SYS_MENU
(
   ID                   varchar(32) not null ,
   NAME                 varchar(50),
   PARENT_ID            varchar(32),
   CONTENT              varchar(500),
   SORT                 int,
   OPTIONAL_ID          varchar(32),
   GRAPHICS_ID          varchar(32),
   MEUN_TYPE            int,
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_PLATFORM                    接入平台表          */
/*==============================================================*/
create table SYS_PLATFORM
(
   ID                   varchar(32) not null ,
   NAME                 varchar(50),
   CODE                 varchar(50),
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_HOSPITAL_PAY_SETTINGS       医院和支付信息中间表 */
/*==============================================================*/
create table SYS_HOSPITAL_PAY_SETTINGS
(
   ID                   varchar(32) not null ,
   PAY_SETTINGS_ID      varchar(32),
   HOSPITAL_ID          varchar(32),
   STATUS               int,
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_PAY_SETTINGS          支付配置信息表         */
/*==============================================================*/
create table SYS_PAY_SETTINGS
(
   ID                   varchar(32) not null ,
   MCH_ID               varchar(50),
   PARENT_ID            varchar(32),
   PAY_KEY              varchar(1000),
   CERTIFICATE_PATH     varchar(1000),
   MCH_ACCOUNT          varchar(100),
   PAY_URL              varchar(500),
   PAY_MODE_ID          varchar(32),
   IS_SUB_PAY           int,
   PARTNER_ID           varchar(100),
   SUB_MCH_ID           varchar(100),
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_PAY_MODE             支付方式表              */
/*==============================================================*/
create table SYS_PAY_MODE
(
   ID                   varchar(32) not null ,
   NAME                 varchar(50),
   VERSION              varchar(20),
   CODE                 varchar(50),
   PLATFORM_ID          varchar(32),
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);




alter table SYS_PAY_SETTINGS add constraint FK_PAY_S_REF_PAY_MODE foreign key (PAY_MODE_ID)
      references SYS_PAY_MODE (ID) on delete restrict on update restrict;
alter table SYS_HOSPITAL_PAY_SETTINGS add constraint FK_HOSPITAL_PAY_S_REF_HOSPITAL foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete restrict on update restrict;

alter table SYS_HOSPITAL_PAY_SETTINGS add constraint FK_HOSPITAL_PAY_S_REF_PAY_S foreign key (PAY_SETTINGS_ID)
      references SYS_PAY_SETTINGS (ID) on delete restrict on update restrict;

alter table SYS_PLATFORM_SETTINGS_MENU add constraint FK_PS_MENU_REF_MENU foreign key (MENU_ID)
      references SYS_MENU (ID) on delete restrict on update restrict;

alter table SYS_PLATFORM_SETTINGS_MENU add constraint FK_PS_MENU_REF_PS foreign key (PLATFORM_SETTINGS_ID)
      references SYS_PLATFORM_SETTINGS (ID) on delete restrict on update restrict;
alter table SYS_PLATFORM_SETTINGS add constraint FK_PLATFORM_SETTINGS_REF_PLATFORM foreign key (PLATFORM_ID)
      references SYS_PLATFORM (ID) on delete restrict on update restrict;
alter table SYS_BRANCH_HOSPITAL add constraint FK_BRANCH_HOSPITAL_REF_HOSPITAL foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete restrict on update restrict;

alter table SYS_HOSPITAL_OPTIONAL add constraint FK_HOSPITA_OPTIONAL_REF_HOSPITA foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete restrict on update restrict;

alter table SYS_HOSPITAL_OPTIONAL add constraint FK_HOSPITA_OPTIONAL_REF_OPTIONAL foreign key (OPTIONAL_ID)
      references SYS_OPTIONAL (ID) on delete restrict on update restrict;

alter table SYS_HOSPITAL_PLATFORM_SETTINGS add constraint FK_HOSPITAL_PS_REF_PS foreign key (PLATFORM_SETTINGS_ID)
      references SYS_PLATFORM_SETTINGS (ID) on delete restrict on update restrict;

alter table SYS_HOSPITAL_PLATFORM_SETTINGS add constraint FK_PLATFORM_SETTINGS_REF_HOSPITAL foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete restrict on update restrict;
alter table SYS_PAY_MODE add constraint FK_PAY_MODE_REF_PLATFORM foreign key (PLATFORM_ID)
      references SYS_PLATFORM (ID) on delete restrict on update restrict;

/*================================================= 医院管理  Yuce 2015-5-27 end ====================================*/


/*================================================= 配置规则建表  yuce  2015-5-27  start ====================================*/
drop table if exists SYS_RULE_EDIT;
drop table if exists SYS_RULE_ONLINE_FILING;
drop table if exists SYS_RULE_TIED_CARD;
drop table if exists SYS_RULE_REGISTER;

/*==============================================================*/
/* Table: SYS_RULE_EDIT       医院配置规则-->全局规则                               */
/*==============================================================*/
create table SYS_RULE_EDIT
(
   ID                   varchar(32) not null ,
   HOSPITAL_ID          varchar(32),
   IS_SHOW_APP_MENU     int(1) comment '是否显示平台菜单',
   IS_HAS_BRANCH        int(1) comment '是否有分院',
   SKIN_WEIXIN_TYPE     int comment   '微信皮肤颜色类型： 0 蓝色  1绿色',
   SKIN_ALIPAY_TYPE     int comment   '支付宝皮肤颜色类型： 0 蓝色  1绿色',
   ADD_VP_NUM           int comment   '同一个账号允许添加就诊人个数',
   ACCEPT_STOP_INFO_TYPE int comment  '接受停诊信息方式:0：医院his主动推送1：标准平台轮询查询',
   PUSH_INFO_TIME       time comment  '推送/查询停诊信息时间',
   PAYMENT_INFO_GET_TYPE int comment  '获取患者门诊缴费信息的方式0：医院HIS主动推送1：标准平台定时轮询',
   INPATIENT_INQUIRY_MODE int comment '住院功能查询方式0：仅通过门诊信息查询住院信息1：仅通过住院号/住院流水号查询住院信息 2：可通过以上两种方式查询住院信息',
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);    

/*==============================================================*/
/* Table: SYS_RULE_ONLINE_FILING      医院配置规则-->在线建档规则*/
/*==============================================================*/
create table SYS_RULE_ONLINE_FILING
(
   ID                   varchar(32) not null  ,
   HOSPITAL_ID          varchar(32),
   VISITING_PERSON_TYPE varchar(10)  comment '就诊人类型  1 本人   2 他人   3 儿童  可多选  ,号隔开',
   CERTIFICATES_TYPE    varchar(10)  comment '1：2代身份证     2：港澳通行证     3：台湾居民身份证 4：护照',
   TIP_WARM_CONTENT     varchar(500) comment '温馨提示内容',
   INPUT_INCORRECT_TIP  varchar(500) comment '输入不正确提示内容',
   ONLINE_FILING_TIP    varchar(500) comment '在线建档提示',
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);
alter table SYS_RULE_ONLINE_FILING comment '医院配置规则-->在线建档规则';

/*==============================================================*/
/* Table: SYS_RULE_TIED_CARD        医院配置规则-->绑卡规则                */
/*==============================================================*/
create table SYS_RULE_TIED_CARD
(
   ID                       varchar(32) not null  ,
   HOSPITAL_ID              varchar(32),
   VISITING_PERSON_TYPE     varchar(10)  comment '就诊人类型  1 本人   2 他人   3 儿童  可多选  ,号隔开',
   CARD_TYPE                varchar(10)  comment '就诊卡类型  1：就诊卡、2：社保卡、3：医保卡、4：住院号 ',
   CERTIFICATES_TYPE        varchar(10)  comment '证件类型 1：二代身份证    2：港澳通行证     3：台湾居民身份证   4：护照',
   IS_SHOW_CARD_NO          int comment  '是否显示卡号   0：否  1：是',
   TIP_WARM_CONTENT         varchar(500) comment '温馨提示内容',
   IS_SHOW_ONLINE_FILING    int comment  '是否显示在线建档    0：否    1：是',
   VERIFY_CONDITION_TYPE    varchar(10) comment  '添加就诊人需要验证的内容类型  0：不验证    1：姓名   2 ：身份证  3：手机号   4：卡号',
   INPUT_INCOMPLETE_TIP     varchar(500) comment '输入不完整提示内容',
   INPUT_INCORRECT_TIP      varchar(500) comment '输入不正确提示内容',
   TIED_CARD_TIP            varchar(500) comment '绑卡提示',
   CP                       varchar(32),
   CT                       datetime,
   EP                       varchar(32),
   ET                       datetime,
   primary key (ID)
);
alter table SYS_RULE_TIED_CARD comment '医院配置规则-->绑卡规则';

/*==============================================================*/
/* Table: SYS_RULE_REGISTER                                     */
/*==============================================================*/
create table SYS_RULE_REGISTER
(
   ID                           varchar(32) not null ,
   HOSPITAL_ID                  varchar(32),
   IS_HAS_BRANCH                int comment '是否有分院  1：有  0：没有',
   IS_HAS_GRADE_TWO_DEPT        int comment '是否有二级科室 1：有   0 ：没有',
   CALENDAR_DAYS_TYPE           int comment '预约挂号日历显示天数  1：7天  2：15天 3：30天',
   ONLINE_PAYMENT_CONTROL       int comment '在线支付控制  :1：必须在线支付    2：不用在线支付     3：支持暂不支付',
   IS_SUPPORT_REFUND_ON_DUTY    int comment '当班挂号是否支持退费   0：不支持    1：支持',
   ON_DUTY_REG_END_TIME         time comment '当班挂号允许挂号截止时间点',
   APPOINTMENT_TOMORROW_END_TIME time comment '允许预约明天号的截止时间点',
   PAYMENT_TIME_OUT_TIME         int comment '单位分钟',
   IS_VIEW_DISEASE_DESC          int  comment '是否显示病情描述  1：是  0：否',
   REG_MAXIMUM_SAME_DOCTOR int comment '每个人每天允许挂同一医生号次数',
   REG_MAXIMUM_IN_DAY   int comment '每个人每天允许最大挂号次数',
   REG_MAXIMUM_IN_WEEK  int comment '每个人每周允许挂号次数',
   REG_MAXIMUM_IN_MONTH int comment '每个人每月允许挂号次数',
   REG_CANCEL_MAXNUM_IN_DAY int comment '每个人每天允许取消挂号次数',
   CANCEL_BESPEAK_CLOSE_TYPE int comment '取消预约挂号截止时间点的计算类型 1：就诊前一天几点  2：就诊当天几点  3：就诊时间段前几小时',
   CANCEL_BESPEAK_END_TIME int comment '取消预约挂号截至时间  ',
   CANCEL_ON_DUTY_CLOSE_TYPE int comment '取消当班挂号截止类型  1：就诊时间段前几小时    2：就诊时间段前多少分钟',
   CANCEL_ON_DUTY_END_TIMES int comment '取消当班挂号的截至时间  类型为1是单位为小时  类型为2是单位为分钟',
   NO_SOURCE_TIP_CONTENT varchar(250) comment '所选日期号源已挂完时提示语',
   ON_DUTY_REG_TIP_CONTENT varchar(250) comment '当班挂号温馨提示语',
   ON_DUTY_REG_OVER_TIME_TIP varchar(250) comment '超过当班挂号截止时间点的提示语',
   BESPEAK_REG_OVER_TIME_TIP varchar(250) comment '超过预约明天号的截止时间点提示语',
   REG_FAILED_TIP       varchar(250) comment '挂号失败提示语',
   REG_DISCOUNT_TIP     varchar(250) comment '可享受医院挂号优惠提示语',
   OVER_MAXIMUM_SAME_DOCTOR_TIP varchar(250) comment '超过每天挂同一医生号次数提示语',
   OVER_MAXIMUM_IN_DAY_TIP varchar(250) comment '超过每天允许挂号次数提示语',
   OVER_MAXIMUM_IN_WEEK_TIP varchar(250) comment '超过每周允许挂号次数提示语',
   OVER_MAXIMUM_IN_MONTH_TIP varchar(250) comment '超过每月允许挂号次数提示语',
   OVER_CANCEL_MAXNUM_IN_DAY_TIP varchar(250) comment '超过每天允许取消挂号次数提示语',
   CANCEL_BESPEAK_TIME_OUT_TIP varchar(250) comment '超过取消预约挂号截止时间点提示语',
   CANCEL_ON_DUTY_TIME_OUT_TIP varchar(250) comment '超过取消当班挂号截止时间点提示语',
   BLACKLIST_USER_REG_TIP varchar(250) comment '黑名单用户挂号提示语',
   CONFIRM_REG_INFO_TIP varchar(250) comment '确认挂号信息（暂不支付）页面提示语',
   REG_PAY_TIME_OUT_TIP varchar(250) comment '挂号支付超时提示语',
   REG_SUCCESS_HAD_PAY_TIP varchar(250) comment '挂号成功（已缴费）时提示语',
   REG_SUCCESS_NO_PAY_TIP varchar(250) comment '挂号成功（未缴费）时提示语',
   REG_SUCCESS_ON_DUTY_TIP varchar(250) comment '挂号成功（当班挂号）时提示语',
   IS_HAS_ONDUTY_REG    int(1) comment '是否有当班挂号  1有   0没有',
   ON_DUTY_REG_START_TIME time comment '当班挂号开始时间',
   CP                       varchar(32),
   CT                       datetime,
   EP                       varchar(32),
   ET                       datetime,
   primary key (ID)
);

alter table SYS_RULE_REGISTER comment '医院配置规则-->挂号规则';

    
      
alter table SYS_RULE_TIED_CARD add constraint FK_RULE_TIE_CARD_REF_BH foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete cascade on update cascade;
alter table SYS_RULE_ONLINE_FILING add constraint FK_RULE_ONLINE_FILING_REF_HS foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete cascade on update cascade;
alter table SYS_RULE_EDIT add constraint FK_RULE_EDIT_REF_HS foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete cascade on update cascade;
alter table SYS_RULE_REGISTER add constraint FK_RULE_REG_REF_HOSPITAL foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete cascade on update cascade;  
      

drop table if exists SYS_RULE_PAYMENT;

/*==============================================================*/
/* Table: RULE_PAYMENT                                          */
/*==============================================================*/
create table SYS_RULE_PAYMENT
(
   ID                   varchar(32) not null,
   HOSPITAL_ID          varchar(32) comment '关联医院ID',
   IS_SUPPORT_COMBINED_PAYMENTS int(1) comment '门诊缴费是否支持合并支付  1：支持   0：不支持',
   IS_SUPPORT_HEALTH_PAYMENTS int(1) comment '门诊缴费是否支持医保结算  1：支持     0：不支持',
   HOSPITAL_DEPOSIT_MIN_MONEY double comment '住院押金补缴最低缴费金额',
   NOT_SUPPORT_HEALTH_PAYMENTS_TIP varchar(250) comment '门诊缴费不支持医保结算提示语',
   SUPPORT_HEALTH_PAYMENTS_TIP varchar(250) comment '门诊缴费支持医保结算提示语',
   OUTPATIENT_PAYMENT_FAILED_TIP varchar(250) comment '门诊缴费失败提示语',
   DEPOSIT_PAYMENT_FAILED_TIP varchar(250) comment '押金补缴失败提示语',
   CP                       varchar(32),
   CT                       datetime,
   EP                       varchar(32),
   ET                       datetime,
   primary key (ID)
);

alter table SYS_RULE_PAYMENT comment '医院配置规则-->缴费规则';

alter table SYS_RULE_PAYMENT add constraint FK_RULE_PAYMENT_REF_HOSPITAL foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete cascade on update cascade;

drop table if exists SYS_RULE_QUERY;

/*==============================================================*/
/* Table: SYS_RULE_QUERY                                        */
/*==============================================================*/
create table SYS_RULE_QUERY
(
   ID                   varchar(32) not null comment '主键ID',
   HOSPITAL_ID          varchar(32) comment '医院ID',
   REPORT_COULD_QUERY_TYPE varchar(10) comment '报告可查询的类别  1：检验    2：检查     3：体检  多个值,号隔开',
   REPORT_VIEW_CSS_TYPE int comment '报告详情的界面样式  1：数据样式        2：图形样式',
   BESPEAK_RECORD_QUERY_TYPE varchar(10) comment '预约记录可查询的类别  1：预约挂号     2：预约体检    3：预约加床 多个值逗号隔开',
   PAYMENT_RECORD_QUERY_TYPE varchar(5) comment '缴费记录可查询的类别 1：门诊缴费    2：住院押金补缴  多个值逗号隔开',
   REPORT_RECORD_QUERY_MAX_MONTHS int(2) comment '单位月',
   BESPEAK_RECORD_QUERY_MAX_MONTHS int(2) comment '预约记录允许查询时长 单位月',
   PAYMENT_RECORD_QUERY_MAX_MONTHS int(2) comment '缴费记录允许查询时长 单位月',
   ONE_DAY_RECORD_MAX_MONTHS int(2) comment '一日清单允许查询时长',
   QUEUE_TYPE varchar(32) comment '排队信息查询的类别 1：门诊候诊    2：检查、检验、体检排队   3：取药排队   4：报告出具进度  多个值逗号隔开',
   CP                       varchar(32),
   CT                       datetime,
   EP                       varchar(32),
   ET                       datetime,
   primary key (ID)
);

alter table SYS_RULE_QUERY comment '医院配置规则-->查询规则';

alter table SYS_RULE_QUERY add constraint FK_RULE_QUERY_REF_HOSPITAL foreign key (HOSPITAL_ID)
      references SYS_HOSPITAL (ID) on delete cascade on update cascade;
    

/*=========================================================================================================*/
/* ----------------  配置规则建表  yuce  2015-5-27  end ------------ --*/
/*=========================================================================================================*/

/*=========================================================================================*/
/*---------------------消息推送  申午武  2015-06-02 start-----------------------------------------*/
/*=========================================================================================*/


/*==============================================================*/
/* Table: SYS_MSG_TEMPLATE  模板消息表                                                                                */
/*==============================================================*/
drop table if exists SYS_MSG_TEMPLATE;
create table SYS_MSG_TEMPLATE
(
   ID                   varchar(32) not null comment '主键ID',
   TEMPLATE_ID          varchar(100) comment '微信公众号或者支付宝服务窗指定的模板ID',
   CODE                 varchar(50) comment '模板编码',
   TITLE                varchar(50) comment '模板标题',
   TOP_COLOR            varchar(20) comment '模板顶部颜色',
   SOURCE               int(1) comment '1:微信公众号,2:支付宝服务窗',
   URL                  varchar(500) comment '模板消息跳转链接',
   LIBRARY_CODE         varchar(50) comment '模板库编号',
   APP_ID               varchar(32) comment '微信公众号或者支付宝服务窗APPID',
   HOSPITAL_ID          varchar(32) comment '医院ID',
   CP                   varchar(32) comment '创建人ID',
   CT                   datetime comment '创建时间',
   EP                   varchar(32) comment '修改人ID',
   ET                   datetime comment '修改时间',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_MSG_TEMPLATE_LIBRARY 消息模板库                                                             */
/*==============================================================*/
drop table if exists SYS_MSG_TEMPLATE_LIBRARY;
create table SYS_MSG_TEMPLATE_LIBRARY
(
   ID                   varchar(32) not null comment '主键',
   TEMPLATE_ID          varchar(100) comment '模板ID',
   TEMPLATE_CODE        varchar(50) comment '模板编码',
   TITLE                varchar(100) comment '标题',
   SOURCE               int(1) comment '1:微信公众号,2:支付宝服务窗',
   PRIMARY_INDUSTRY     varchar(50) comment '一级行业',
   SECOND_INDUSTRY      varchar(50) comment '二级行业',
   CP                   varchar(32) comment '创建人ID',
   CT                   datetime comment '创建时间',
   EP                   varchar(32) comment '修改人ID',
   ET                   datetime comment '修改时间',
   primary key (ID)
);



/*==============================================================*/
/* Table: SYS_MSG_TEMPLATE_CONTENT  消息内容                                                              */
/*==============================================================*/
drop table if exists SYS_MSG_TEMPLATE_CONTENT;
create table SYS_MSG_TEMPLATE_CONTENT
(
   ID                   varchar(32) not null comment '主键',
   SORT                 int(10) comment '序号',
   KEYWORD              varchar(20) comment '关键字',
   VALUE                varchar(255) comment '内容',
   NODE                 varchar(20) comment '节点',
   FONT_COLOR           varchar(20) comment '字体颜色',
   TEMPLATE_ID          varchar(32) comment '模板ID',
   CP                   varchar(32) comment '创建人ID',
   CT                   datetime comment '创建时间',
   EP                   varchar(32) comment '修改人ID',
   ET                   datetime comment '修改时间',
   primary key (ID)
);


/*==============================================================*/
/* Table: SYS_MSG_CUSTOMER 客服消息                                                                                       */
/*==============================================================*/
drop table if exists SYS_MSG_CUSTOMER;
create table SYS_MSG_CUSTOMER
(
   ID                   varchar(32) not null comment '主键',
   CODE                 varchar(50) comment '消息编码',
   TITLE                varchar(50) comment '消息标题',
   CONTENT              varchar(5000) comment '消息内容',
   SOURCE               int(1) comment '1:微信公众号,2:支付宝服务窗',
   TYPE                 int(1) comment '1:text,目前默认为1',
   APP_ID               varchar(50) comment '微信公众号或者支付宝服务窗APPID',
   HOSPITAL_ID          varchar(32) comment '医院ID',
   CP                   varchar(32) comment '创建人ID',
   CT                   datetime comment '创建时间',
   EP                   varchar(32) comment '修改人ID',
   ET                   datetime comment '修改时间',
   primary key (ID)
);


drop table if exists SYS_MSG_LOG;

/*==============================================================*/
/* Table: SYS_MSG_LOG 消息日志                                                                                                     */
/*==============================================================*/
create table SYS_MSG_LOG
(
   ID                   varchar(32) not null comment '主键',
   MSG_CODE               varchar(50) comment '模板消息或者客服消息code',
   APP_ID               varchar(32) comment '微信公众平台或者支付宝服务窗APPID',
   HOSPITAL_ID          varchar(32) comment '医院ID',
   OPEN_ID              varchar(100) comment '用户ID',
   SOURCE               int(1) comment '1:微信公众号,2:支付宝服务窗',
   PUSH_STATUS          int(1) comment '1:成功,2:失败,3:http请求失败',
   PUSH_FAILED_NUM      int(1) comment '推送失败次数',
   PUSH_CONTENT         varchar(5000) comment '推送的JSON内容',
   PUSH_DATE            datetime comment '推送时间',
   primary key (ID)
);
/*=========================================================================================================*/
/* ----------------  模板消息  申午武  2015-06-02  end ------------ --*/
/*=========================================================================================================*/


/*================-----------------账户管理  luobin 2015-06-02  start------------------============*/
/*==============================================================*/
/* Table: SYS_USER   账户表                                     */
/*==============================================================*/
CREATE TABLE SYS_USER (
  ID varchar(32) NOT NULL COMMENT '账号ID',
  USER_NAME varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '账户名称',
  PASSWORD varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '密码',
  LOGIN_COUNT int(11) DEFAULT '0' COMMENT '登录次数',
  LAST_LOGIN_TIME datetime DEFAULT NULL COMMENT '最近登录时间',
  STATUS int(11) DEFAULT '1' COMMENT '启用状态（0 禁用 1 启用）',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（ 0 已删除 1 未删除）',
  PRIMARY KEY (ID)
); 

/*==============================================================*/
/* Table: SYS_USER_HOSPITALS   账户医院关系表                                     */
/*==============================================================*/
CREATE TABLE SYS_USER_HOSPITALS (
  ID varchar(32) NOT NULL  COMMENT '用户医院关联ID',
  USER_ID varchar(32) DEFAULT NULL COMMENT '账户表-账户ID',
  HOSPITAL_ID varchar(32) DEFAULT NULL COMMENT '医院表-医院ID',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（1未删除 0已删除）',
  PRIMARY KEY (ID)
);
/*==============================================================*/
/* Table: SYS_USER_ROLES   账户角色关系表                                     */
/*==============================================================*/
CREATE TABLE SYS_USER_ROLES (
  ID varchar(32) NOT NULL COMMENT '用户角色关联ID',
  USER_ID varchar(32) DEFAULT NULL COMMENT '账户表-账户ID',
  ROLE_ID varchar(32) DEFAULT NULL COMMENT '角色表-角色ID',
  STATE int(11) DEFAULT '1' COMMENT '删除状态 （1未删除  0已删除）',
  PRIMARY KEY (ID)
);
/*==============================================================*/
/* Table: SYS_ROLE   角色表                                     */
/*==============================================================*/
CREATE TABLE SYS_ROLE (
  ID varchar(32) NOT NULL ,
  ROLE_NAME varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '角色名称',
  STATUS int(11) DEFAULT '1' COMMENT '启用状态（1启用 0禁用）',
  PRIMARY KEY (ID)
);
/*===========----------------账户管理  luobin 2015-06-02  end--------------============*/

/*===========-----------------消息管理  luobin 2015-06-02  start--------------============*/
/*==============================================================*/
/* Table: SYS_MSG_REPLY   消息回复表                                     */
/*==============================================================*/
CREATE TABLE SYS_MSG_REPLY (
  ID varchar(32) NOT NULL  COMMENT '回复ID',
  TYPE int(11) DEFAULT NULL COMMENT '回复类型（1被添加/关注后回复 2关键词自动回复）',
  CONTENT_TYPE int(11) DEFAULT NULL COMMENT '回复内容类型（1文字 2图片 3图文）',
  THIRD_TYPE int(11) DEFAULT NULL COMMENT '第三方类型（1微信 2支付宝）',
  HOSPITAL_ID varchar(32) DEFAULT NULL COMMENT '医院ID',
  HOSPITAL_BRANCH_ID varchar(32) DEFAULT NULL COMMENT '分院ID',
  CONTENT varchar(1000) DEFAULT NULL COMMENT '文字内容',
  PIC_PATHS varchar(1000) DEFAULT NULL COMMENT '多图片路径（逗号隔开）',
  CP varchar(32) DEFAULT NULL COMMENT '创建人',
  CT datetime DEFAULT NULL COMMENT ' 创建时间',
  EP varchar(32) DEFAULT NULL COMMENT '修改人',
  ET datetime DEFAULT NULL COMMENT '修改时间',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（1未删除 0已删除）',
  PRIMARY KEY (ID)
);
/*==============================================================*/
/* Table: SYS_MSG_REPLY_METERIAL   回复素材关系表                                     */
/*==============================================================*/
CREATE TABLE SYS_MSG_REPLY_METERIAL (
  ID varchar(32) NOT NULL  COMMENT '回复ID',
  REPLY_ID varchar(32) DEFAULT NULL COMMENT '回复ID',
  MIXED_METERIAL_ID varchar(32) DEFAULT NULL COMMENT '素材ID',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（1未删除 0已删除）',
  PRIMARY KEY (ID)
);
/*==============================================================*/
/* Table: SYS_MSG_RULE_REPLY   规则回复关系表                                     */
/*==============================================================*/
CREATE TABLE SYS_MSG_RULE_REPLY (
  ID varchar(32) NOT NULL  COMMENT '回复ID',
  REPLY_ID varchar(32) DEFAULT NULL COMMENT '回复ID',
  RULE_ID varchar(32) DEFAULT NULL COMMENT '规则ID',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（1未删除 0已删除）',
  PRIMARY KEY (ID)
);
/*==============================================================*/
/* Table: SYS_MSG_RULE   规则表                                     */
/*==============================================================*/
CREATE TABLE SYS_MSG_RULE (
  ID varchar(32) NOT NULL  COMMENT '规则ID',
  HOSPITAL_ID varchar(32) DEFAULT NULL COMMENT '医院ID',
  RULE_NAME varchar(100) DEFAULT NULL COMMENT '规则名称',
  TYPE int(11) DEFAULT '1' COMMENT '规则回复类型（1随机回复 2回复全部）',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（1未删除 0已删除）',
  PRIMARY KEY (ID)
);
/*==============================================================*/
/* Table: SYS_MSG_MIXED_METERIAL   混合素材表                                     */
/*==============================================================*/
CREATE TABLE SYS_MSG_MIXED_METERIAL (
  ID varchar(32) NOT NULL  COMMENT '素材ID',
  TITLE varchar(100) DEFAULT NULL COMMENT '素材标题',
  AUTHOR varchar(100) DEFAULT NULL COMMENT '作者',
  DESCRIPTION varchar(1000) DEFAULT NULL COMMENT '摘要',
  CONTENT varchar(15000) DEFAULT NULL COMMENT '正文',
  LINK varchar(1000) DEFAULT NULL COMMENT '正文',
  TYPE int(11) DEFAULT NULL COMMENT '回复类型（1单图文 2多图文）',
  COVER_PIC_PATH  varchar(1000) DEFAULT NULL COMMENT '图片路径',
  IS_PARENT int(11) DEFAULT '1' COMMENT '是否是父节点（1是 0否）',
  PARENT_ID varchar(32) DEFAULT NULL  COMMENT '父节点ID',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（1未删除 0已删除）',
  CP                       varchar(32),
  CT                       datetime,
  EP                       varchar(32),
  ET                       datetime,
  PRIMARY KEY (ID)
);
/*==============================================================*/
/* Table: SYS_MSG_METERIAL   单一素材表                                     */
/*==============================================================*/
CREATE TABLE SYS_MSG_METERIAL (
  ID varchar(32) NOT NULL  COMMENT '单一素材表(图片/语音/视频)表ID',
  METERIAL_GROUP_ID varchar(32) DEFAULT NULL COMMENT '素材分组ID',
  NAME varchar(255) DEFAULT NULL COMMENT '素材资源名称',
  PATH varchar(255) DEFAULT NULL COMMENT '素材资源路径',
  SIZE varchar(255) DEFAULT NULL COMMENT '素材资源大小',
  DURATION varchar(255) DEFAULT NULL COMMENT '素材资源时长',
  COVER_PIC_PATH varchar(255) DEFAULT NULL COMMENT '视频封面',
  TYPE int(11) DEFAULT NULL COMMENT '类型（1.图片 2.语音 3.视频）',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（1未删除 0已删除）',
  CP                       varchar(32),
  CT                       datetime,
  EP                       varchar(32),
  ET                       datetime,
  PRIMARY KEY (ID)
);
/*==============================================================*/
/* Table: SYS_MSG_METERIAL_GROUP   素材分组表                                     */
/*==============================================================*/
CREATE TABLE SYS_MSG_METERIAL_GROUP (
  ID varchar(32)  NOT NULL  COMMENT '分组ID',
  NAME varchar(255) DEFAULT NULL COMMENT '素材分组名称',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（1未删除 0已删除）',
  PRIMARY KEY (ID)
);
/*==============================================================*/
/* Table: SYS_MSG_KEYWORD   规则关键字表                                     */
/*==============================================================*/
CREATE TABLE SYS_MSG_KEYWORD (
  ID varchar(32) NOT NULL  COMMENT '关键字表ID',
  CONTENT varchar(30) DEFAULT NULL COMMENT '关键字内容',
  RULE_ID varchar(32) DEFAULT NULL COMMENT '规则ID',
  TYPE int(11) DEFAULT NULL COMMENT '关键字类型（0 未完全匹配 1 完全匹配）',
  STATE int(11) DEFAULT '1' COMMENT '删除状态（1未删除 0已删除）',
  PRIMARY KEY (ID)
);
/*=============================================== 消息管理  luobin 2015-06-02  end ======================*/


/*=============================================== 上传文件表  zhoujb 2015-06-10  start ======================*/
drop table if exists SYS_ATTACH;

/*==============================================================*/
/* Table: SYS_ATTACH	上传文件表                      							*/
/*==============================================================*/
create table SYS_ATTACH 
(
   ID                   varchar(32)                    not null,
   APP_ID               varchar(32)                    null,
   ORIGINAL_NAME        varchar(500)                   null,
   ARCHIVE_NAME         varchar(100)                   null,
   RELATIVE_PATH        varchar(500)                   null,
   ABSOLUTE_PATH        varchar(500)                   null,
   EXT_NAME             varchar(20)                    null,
   ATTACH_SIZE          integer                        null,
   UPLOAD_DATE          timestamp                      null,
   UPLOAD_PERSONID      varchar(32)                    null,
   constraint PK_SYS_ATTACH primary key (ID)
);

comment on column SYS_ATTACH.ID is 
'主键ID';

comment on column SYS_ATTACH.APP_ID is 
'关联数据ID';

comment on column SYS_ATTACH.ORIGINAL_NAME is 
'原始名称';

comment on column SYS_ATTACH.ARCHIVE_NAME is 
'真实名称';

comment on column SYS_ATTACH.RELATIVE_PATH is 
'相对路径';

comment on column SYS_ATTACH.ABSOLUTE_PATH is 
'绝对路径';

comment on column SYS_ATTACH.ATTACH_SIZE is 
'附件大小(以字节为单位)';

comment on column SYS_ATTACH.UPLOAD_DATE is 
'上传时间';

comment on column SYS_ATTACH.UPLOAD_PERSONID is 
'上传人';
/*=============================================== 上传文件表 zhoujb 2015-06-10  end ======================*/






/*=============================================== 上传文件表 luob 2015-07-03  start ======================*/


/*==============================================================*/
/* Table: SYS_RULE_PUSH_WECHAT	推送配置表                    					*/
/*==============================================================*/
CREATE TABLE SYS_RULE_PUSH_WECHAT (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `HOSPITAL_ID` varchar(32) DEFAULT NULL COMMENT '医院ID',
  `BIND_CARD_SUC` int(1) DEFAULT '0' COMMENT '绑卡成功是否推送(1-是  0-否)',
  `BIND_CARD_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '绑卡成功模版编码',
  `CREATE_CARD_SUC` int(1) DEFAULT '0' COMMENT '建档成功是否推送(1-是  0-否)',
  `CREATE_CARD_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '建档成功模版编码',
  `PREDAY_VISIT` int(1) DEFAULT '0' COMMENT '就诊前一天是否推送(1-是  0-否)',
  `PREDAY_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '就诊前一天模版编码',
  `CURDAY_VISIT` int(1) DEFAULT '0' COMMENT '就诊当天是否推送(1-是  0-否)',
  `CURDAY_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '就诊当天是否推送模版',
  `LOCK_RES_SUC` int(1) DEFAULT '0' COMMENT '锁号成功是否推送(1-是  0-否)',
  `LOCK_RES_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '锁号成功模版编号',
  `ON_DUTY_PAY_SUC` int(1) DEFAULT '0' COMMENT '当班挂号支付成功(1-是  0-否)',
  `ON_DUTY_PAY_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '当班挂号支付成功模版编号',
  `APPOINT_PAY_SUC` int(1) DEFAULT '0' COMMENT '预约支付成功是否推送(1-是  0-否)',
  `APPOINT_PAY_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '预约支付成功模版编号',
  `APPOINT_PAY_FAIL` int(1) DEFAULT '0' COMMENT '挂号支付失败是否推送(1-是  0-否)',
  `APPOINT_PAY_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '挂号支付失败模版编号',
  `APPOINT_PAY_EXP` int(1) DEFAULT '0' COMMENT '挂号支付异常是否推送(1-是  0-否)',
  `APPOINT_PAY_EXP_CODE` varchar(100) DEFAULT NULL COMMENT '挂号支付异常模版编号',
  `CANCEL_ON_DUTY` int(1) DEFAULT '0' COMMENT '取消当班挂号是否推送(1-是  0-否)',
  `CANCEL_ON_DUTY_CODE` varchar(100) DEFAULT NULL COMMENT '取消当班挂号模版编号',
  `CANCEL_APPOINTMENT` int(1) DEFAULT '0' COMMENT '取消预约挂号是否推送(1-是  0-否)',
  `CANCEL_APPOINTMENT_CODE` varchar(100) DEFAULT NULL COMMENT '取消预约挂号模版编号',
  `REFUND_SUCCESS` int(1) DEFAULT '0' COMMENT '挂号退费成功是否推送(1-是  0-否)',
  `REFUND_SUCCESS_CODE` varchar(100) DEFAULT NULL COMMENT '挂号退费成功模版编号',
  `REFUND_FAIL` int(1) DEFAULT '0' COMMENT '挂号退费失败是否推送(1-是  0-否)',
  `REFUND_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '挂号退费失败模版编号',
  `REFUND_EXCEPTION` int(1) DEFAULT '0' COMMENT '挂号退费异常是否推送(1-是  0-否)',
  `REFUND_EXCEPTION_CODE` varchar(100) DEFAULT NULL COMMENT '挂号退费异常模版编号',
  `STOP_VISIT` int(1) DEFAULT '0' COMMENT '医生停诊是否推送(1-是  0-否)',
  `STOP_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '医生停诊模版编号',
  `WAIT_VISIT` int(1) DEFAULT '0' COMMENT '候诊排队是否推送(1-是  0-否)',
  `WAIT_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '候诊排队模版编号',
  `CLINIC_PAY_SUC` int(1) DEFAULT '0' COMMENT '门诊缴费成功是否推送(1-是  0-否)',
  `CLINIC_PAY_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '门诊缴费成功模版编号',
  `CLINIC_PAY_FAIL` int(1) DEFAULT '0' COMMENT '门诊缴费失败是否推送(1-是  0-否)',
  `CLINIC_PAY_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '门诊缴费失败模版编号',
  `CLINIC_PAY_EXP` int(1) DEFAULT '0' COMMENT '门诊缴费异常是否推送(1-是  0-否)',
  `CLINIC_PAY_EXP_CODE` varchar(100) DEFAULT NULL COMMENT '门诊缴费异常模版编号',
  `PAY_DEPOSIT_SUC` int(1) DEFAULT '0' COMMENT '押金补缴成功是否推送(1-是  0-否)',
  `PAY_DEPOSIT_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '押金补缴成功模版编号',
  `PAY_DEPOSIT_FAIL` int(1) DEFAULT '0' COMMENT '押金补缴失败是否推送(1-是  0-否)',
  `PAY_DEPOSIT_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '押金补缴失败模版编号',
  `PAY_DEPOSIT_EXP` int(1) DEFAULT '0' COMMENT '押金补缴异常是否推送(1-是  0-否)',
  `PAY_DEPOSIT_EXP_CODE` varchar(100) DEFAULT NULL COMMENT '押金补缴异常模版编号',
  `GENERATE_REPORT` int(1) DEFAULT '0' COMMENT '报告出结果是否推送(1-是  0-否)',
  `GENERATE_REPORT_CODE` varchar(100) DEFAULT NULL COMMENT '报告出结果模版编号',
  `CP` varchar(32) DEFAULT NULL,
  `CT` datetime DEFAULT NULL,
  `EP` varchar(32) DEFAULT NULL,
  `ET` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
);



/*==============================================================*/
/* Table: SYS_RULE_PUSH_ALIPAY	推送配置表                    					*/
/*==============================================================*/
CREATE TABLE SYS_RULE_PUSH_ALIPAY (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `HOSPITAL_ID` varchar(32) DEFAULT NULL COMMENT '医院ID',
  `BIND_CARD_SUC` int(1) DEFAULT '0' COMMENT '绑卡成功是否推送(1-是  0-否)',
  `BIND_CARD_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '绑卡成功模版编码',
  `CREATE_CARD_SUC` int(1) DEFAULT '0' COMMENT '建档成功是否推送(1-是  0-否)',
  `CREATE_CARD_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '建档成功模版编码',
  `PREDAY_VISIT` int(1) DEFAULT '0' COMMENT '就诊前一天是否推送(1-是  0-否)',
  `PREDAY_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '就诊前一天模版编码',
  `CURDAY_VISIT` int(1) DEFAULT '0' COMMENT '就诊当天是否推送(1-是  0-否)',
  `CURDAY_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '就诊当天是否推送模版',
  `LOCK_RES_SUC` int(1) DEFAULT '0' COMMENT '锁号成功是否推送(1-是  0-否)',
  `LOCK_RES_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '锁号成功模版编号',
  `ON_DUTY_PAY_SUC` int(1) DEFAULT '0' COMMENT '当班挂号支付成功(1-是  0-否)',
  `ON_DUTY_PAY_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '当班挂号支付成功模版编号',
  `APPOINT_PAY_SUC` int(1) DEFAULT '0' COMMENT '预约支付成功是否推送(1-是  0-否)',
  `APPOINT_PAY_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '预约支付成功模版编号',
  `APPOINT_PAY_FAIL` int(1) DEFAULT '0' COMMENT '挂号支付失败是否推送(1-是  0-否)',
  `APPOINT_PAY_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '挂号支付失败模版编号',
  `APPOINT_PAY_EXP` int(1) DEFAULT '0' COMMENT '挂号支付异常是否推送(1-是  0-否)',
  `APPOINT_PAY_EXP_CODE` varchar(100) DEFAULT NULL COMMENT '挂号支付异常模版编号',
  `CANCEL_ON_DUTY` int(1) DEFAULT '0' COMMENT '取消当班挂号是否推送(1-是  0-否)',
  `CANCEL_ON_DUTY_CODE` varchar(100) DEFAULT NULL COMMENT '取消当班挂号模版编号',
  `CANCEL_APPOINTMENT` int(1) DEFAULT '0' COMMENT '取消预约挂号是否推送(1-是  0-否)',
  `CANCEL_APPOINTMENT_CODE` varchar(100) DEFAULT NULL COMMENT '取消预约挂号模版编号',
  `REFUND_SUCCESS` int(1) DEFAULT '0' COMMENT '挂号退费成功是否推送(1-是  0-否)',
  `REFUND_SUCCESS_CODE` varchar(100) DEFAULT NULL COMMENT '挂号退费成功模版编号',
  `REFUND_FAIL` int(1) DEFAULT '0' COMMENT '挂号退费失败是否推送(1-是  0-否)',
  `REFUND_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '挂号退费失败模版编号',
  `REFUND_EXCEPTION` int(1) DEFAULT '0' COMMENT '挂号退费异常是否推送(1-是  0-否)',
  `REFUND_EXCEPTION_CODE` varchar(100) DEFAULT NULL COMMENT '挂号退费异常模版编号',
  `STOP_VISIT` int(1) DEFAULT '0' COMMENT '医生停诊是否推送(1-是  0-否)',
  `STOP_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '医生停诊模版编号',
  `WAIT_VISIT` int(1) DEFAULT '0' COMMENT '候诊排队是否推送(1-是  0-否)',
  `WAIT_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '候诊排队模版编号',
  `CLINIC_PAY_SUC` int(1) DEFAULT '0' COMMENT '门诊缴费成功是否推送(1-是  0-否)',
  `CLINIC_PAY_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '门诊缴费成功模版编号',
  `CLINIC_PAY_FAIL` int(1) DEFAULT '0' COMMENT '门诊缴费失败是否推送(1-是  0-否)',
  `CLINIC_PAY_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '门诊缴费失败模版编号',
  `CLINIC_PAY_EXP` int(1) DEFAULT '0' COMMENT '门诊缴费异常是否推送(1-是  0-否)',
  `CLINIC_PAY_EXP_CODE` varchar(100) DEFAULT NULL COMMENT '门诊缴费异常模版编号',
  `PAY_DEPOSIT_SUC` int(1) DEFAULT '0' COMMENT '押金补缴成功是否推送(1-是  0-否)',
  `PAY_DEPOSIT_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '押金补缴成功模版编号',
  `PAY_DEPOSIT_FAIL` int(1) DEFAULT '0' COMMENT '押金补缴失败是否推送(1-是  0-否)',
  `PAY_DEPOSIT_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '押金补缴失败模版编号',
  `PAY_DEPOSIT_EXP` int(1) DEFAULT '0' COMMENT '押金补缴异常是否推送(1-是  0-否)',
  `PAY_DEPOSIT_EXP_CODE` varchar(100) DEFAULT NULL COMMENT '押金补缴异常模版编号',
  `GENERATE_REPORT` int(1) DEFAULT '0' COMMENT '报告出结果是否推送(1-是  0-否)',
  `GENERATE_REPORT_CODE` varchar(100) DEFAULT NULL COMMENT '报告出结果模版编号',
  `CP` varchar(32) DEFAULT NULL,
  `CT` datetime DEFAULT NULL,
  `EP` varchar(32) DEFAULT NULL,
  `ET` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
);
/*==============================================================*/
/* Table: SYS_RULE_PUSH_EASYHEALTH	健康易推送配置表                    					*/
/*==============================================================*/
CREATE TABLE `SYS_RULE_PUSH_EASYHEALTH` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `HOSPITAL_ID` varchar(32) DEFAULT NULL COMMENT '医院ID',
  `BIND_CARD_SUC` int(1) DEFAULT '0' COMMENT '绑卡成功是否推送(1-是  0-否)',
  `BIND_CARD_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '绑卡成功模版编码',
  `CREATE_CARD_SUC` int(1) DEFAULT '0' COMMENT '建档成功是否推送(1-是  0-否)',
  `CREATE_CARD_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '建档成功模版编码',
  `PREDAY_VISIT` int(1) DEFAULT '0' COMMENT '就诊前一天是否推送(1-是  0-否)',
  `PREDAY_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '就诊前一天模版编码',
  `CURDAY_VISIT` int(1) DEFAULT '0' COMMENT '就诊当天是否推送(1-是  0-否)',
  `CURDAY_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '就诊当天是否推送模版',
  `LOCK_RES_SUC` int(1) DEFAULT '0' COMMENT '锁号成功是否推送(1-是  0-否)',
  `LOCK_RES_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '锁号成功模版编号',
  `ON_DUTY_PAY_SUC` int(1) DEFAULT '0' COMMENT '当班挂号支付成功(1-是  0-否)',
  `ON_DUTY_PAY_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '当班挂号支付成功模版编号',
  `APPOINT_PAY_SUC` int(1) DEFAULT '0' COMMENT '预约支付成功是否推送(1-是  0-否)',
  `APPOINT_PAY_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '预约支付成功模版编号',
  `APPOINT_PAY_FAIL` int(1) DEFAULT '0' COMMENT '挂号支付失败是否推送(1-是  0-否)',
  `APPOINT_PAY_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '挂号支付失败模版编号',
  `APPOINT_PAY_EXP` int(1) DEFAULT '0' COMMENT '挂号支付异常是否推送(1-是  0-否)',
  `APPOINT_PAY_EXP_CODE` varchar(100) DEFAULT NULL COMMENT '挂号支付异常模版编号',
  `CANCEL_ON_DUTY` int(1) DEFAULT '0' COMMENT '取消当班挂号是否推送(1-是  0-否)',
  `CANCEL_ON_DUTY_CODE` varchar(100) DEFAULT NULL COMMENT '取消当班挂号模版编号',
  `CANCEL_APPOINTMENT` int(1) DEFAULT '0' COMMENT '取消预约挂号是否推送(1-是  0-否)',
  `CANCEL_APPOINTMENT_CODE` varchar(100) DEFAULT NULL COMMENT '取消预约挂号模版编号',
  `REFUND_SUCCESS` int(1) DEFAULT '0' COMMENT '挂号退费成功是否推送(1-是  0-否)',
  `REFUND_SUCCESS_CODE` varchar(100) DEFAULT NULL COMMENT '挂号退费成功模版编号',
  `REFUND_FAIL` int(1) DEFAULT '0' COMMENT '挂号退费失败是否推送(1-是  0-否)',
  `REFUND_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '挂号退费失败模版编号',
  `REFUND_EXCEPTION` int(1) DEFAULT '0' COMMENT '挂号退费异常是否推送(1-是  0-否)',
  `REFUND_EXCEPTION_CODE` varchar(100) DEFAULT NULL COMMENT '挂号退费异常模版编号',
  `STOP_VISIT` int(1) DEFAULT '0' COMMENT '医生停诊是否推送(1-是  0-否)',
  `STOP_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '医生停诊模版编号',
  `WAIT_VISIT` int(1) DEFAULT '0' COMMENT '候诊排队是否推送(1-是  0-否)',
  `WAIT_VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '候诊排队模版编号',
  `CLINIC_PAY_SUC` int(1) DEFAULT '0' COMMENT '门诊缴费成功是否推送(1-是  0-否)',
  `CLINIC_PAY_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '门诊缴费成功模版编号',
  `CLINIC_PAY_FAIL` int(1) DEFAULT '0' COMMENT '门诊缴费失败是否推送(1-是  0-否)',
  `CLINIC_PAY_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '门诊缴费失败模版编号',
  `CLINIC_PAY_EXP` int(1) DEFAULT '0' COMMENT '门诊缴费异常是否推送(1-是  0-否)',
  `CLINIC_PAY_EXP_CODE` varchar(100) DEFAULT NULL COMMENT '门诊缴费异常模版编号',
  `PAY_DEPOSIT_SUC` int(1) DEFAULT '0' COMMENT '押金补缴成功是否推送(1-是  0-否)',
  `PAY_DEPOSIT_SUC_CODE` varchar(100) DEFAULT NULL COMMENT '押金补缴成功模版编号',
  `PAY_DEPOSIT_FAIL` int(1) DEFAULT '0' COMMENT '押金补缴失败是否推送(1-是  0-否)',
  `PAY_DEPOSIT_FAIL_CODE` varchar(100) DEFAULT NULL COMMENT '押金补缴失败模版编号',
  `PAY_DEPOSIT_EXP` int(1) DEFAULT '0' COMMENT '押金补缴异常是否推送(1-是  0-否)',
  `PAY_DEPOSIT_EXP_CODE` varchar(100) DEFAULT NULL COMMENT '押金补缴异常模版编号',
  `GENERATE_REPORT` int(1) DEFAULT '0' COMMENT '报告出结果是否推送(1-是  0-否)',
  `GENERATE_REPORT_CODE` varchar(100) DEFAULT NULL COMMENT '报告出结果模版编号',
  `CLINIC_REFUND` int(1) DEFAULT '0' COMMENT '门诊退费是否推送(1-是  0-否)',
  `CLINIC_REFUND_CODE` varchar(100) DEFAULT NULL COMMENT '门诊退费编号',
  `CLINIC_REFUND_PART` int(1) DEFAULT '0' COMMENT '门诊部分退费是否推送(1-是  0-否)',
  `CLINIC_REFUND_PART_CODE` varchar(100) DEFAULT NULL COMMENT '门诊部分退费编号',
  `CP` varchar(32) DEFAULT NULL,
  `CT` datetime DEFAULT NULL,
  `EP` varchar(32) DEFAULT NULL,
  `ET` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

/*=============================================== 上传文件表 luob 2015-07-03  end ======================*/

/*=============================================== 上传文件表 dfw 2015-07-10  end ======================*/
/*
Navicat MySQL Data Transfer

Source Server         : 外网标准版
Source Server Version : 50173
Source Host           : 192.168.8.169:3306
Source Database       : yx129_dev

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2015-07-10 14:59:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for SYS_RULE_USER_CONTENT
-- ----------------------------
DROP TABLE IF EXISTS `SYS_RULE_USER_CONTENT`;
CREATE TABLE `SYS_RULE_USER_CONTENT` (
  `ID` varchar(32) NOT NULL,
  `HOSPITAL_ID` varchar(32) DEFAULT NULL,
  `INDEX_CONTENT` varchar(32) DEFAULT NULL COMMENT '1.我的家人 2.挂号记录 3.缴费记录 4.我的医生 5.我的咨询 6.我的消息 7.我的服务 8.健康记录 9.服务评价',
  `BARCODE_STYLE` int(11) DEFAULT NULL COMMENT '1.EAN码 2.UPC码 3.39码 4.128码 5.库德巴码',
  `USER_INFO_CONTENT` varchar(32) DEFAULT NULL COMMENT '1.条形码 2.身份证号 3.手机号码 4.就诊卡号 5.社保卡号 6.住院号 7.社保卡号',
  `CP` varchar(32) DEFAULT NULL,
  `CT` datetime DEFAULT NULL,
  `EP` varchar(32) DEFAULT NULL,
  `ET` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_USER_CONTENT_HOSPITALID_REF_HOSPITAL` (`HOSPITAL_ID`),
  CONSTRAINT `FK_USER_CONTENT_HOSPITALID_REF_HOSPITAL` FOREIGN KEY (`HOSPITAL_ID`) REFERENCES `SYS_HOSPITAL` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*=============================================== 上传文件表 dfw 2015-07-10  end ======================*/

/*=============================================== 检查检验报告入库表 周鉴斌 2015-07-13  start ======================*/
--检查入库表（包含检查详细部分）
/*
DROP TABLE IF EXISTS `DATA_EXAMINE`;
CREATE TABLE `DATA_EXAMINE` (
  `ID` CHAR(32) NOT NULL,
  `HOSPITAL_ID` CHAR(32) DEFAULT NULL,
  `HOSPITAL_CODE` VARCHAR(50) DEFAULT NULL,
  `HOSPITAL_NAME` VARCHAR(50) DEFAULT NULL,
  `BRANCH_ID` CHAR(32) DEFAULT NULL,
  `BRANCH_CODE` VARCHAR(50) DEFAULT NULL,
  `BRANCH_NAME` VARCHAR(50) DEFAULT NULL,
  `CHECK_ID` VARCHAR(200) DEFAULT NULL,
  `CHECK_NAME` VARCHAR(200) DEFAULT NULL,
  `CHECK_TYPE` VARCHAR(200) DEFAULT NULL,
  `CHECK_TYPE_NAME` VARCHAR(200) DEFAULT NULL,
  `DEPT_NAME` VARCHAR(200) DEFAULT NULL,
  `DOCTOR_NAME` VARCHAR(100) DEFAULT NULL,
  `CHECK_TIME` VARCHAR(20) DEFAULT NULL,
  `ORDER_DOCTOR` VARCHAR(100) DEFAULT NULL,
  `ORDER_DOCTOR_CODE` VARCHAR(100) DEFAULT NULL,
  `ORDER_DEPT` VARCHAR(200) DEFAULT NULL,
  `REPORT_TIME` VARCHAR(20) DEFAULT NULL,
  `FILE_ADDRESS` VARCHAR(500) DEFAULT NULL,
  `CHECK_PART` VARCHAR(1000) DEFAULT NULL,
  `CHECK_METHOD` VARCHAR(200) DEFAULT NULL,
  `CHECK_SITUATION` VARCHAR(1000) DEFAULT NULL,
  `OPINIONS` VARCHAR(1000) DEFAULT NULL,
  `ADVICE` VARCHAR(1000) DEFAULT NULL,
  `STORAGE_TIME` TIMESTAMP NULL DEFAULT NULL,
  `STORAGE_OPEN_ID` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检查入库表';
*/

--检验入库表（主表）
/*
DROP TABLE IF EXISTS `DATA_INSPECT`;
CREATE TABLE `DATA_INSPECT` (
  `ID` CHAR(32) NOT NULL,
  `HOSPITAL_ID` CHAR(32) DEFAULT NULL,
  `HOSPITAL_CODE` VARCHAR(50) DEFAULT NULL,
  `HOSPITAL_NAME` VARCHAR(50) DEFAULT NULL,
  `BRANCH_ID` CHAR(32) DEFAULT NULL,
  `BRANCH_CODE` VARCHAR(50) DEFAULT NULL,
  `BRANCH_NAME` VARCHAR(50) DEFAULT NULL,
  `INSPECT_ID` VARCHAR(200) DEFAULT NULL,
  `INSPECT_NAME` VARCHAR(200) DEFAULT NULL,
  `DEPT_NAME` VARCHAR(200) DEFAULT NULL,
  `DOCTOR_NAME` VARCHAR(50) DEFAULT NULL,
  `DOCTOR_CODE` VARCHAR(200) DEFAULT NULL,
  `INSPECT_TIME` VARCHAR(20) DEFAULT NULL,
  `VERIFY_DOCTOR` VARCHAR(50) DEFAULT NULL,
  `VERIFY_TIME` VARCHAR(20) DEFAULT NULL,
  `INSPECT_DOCTOR` VARCHAR(50) DEFAULT NULL,
  `PROVING_TIME` VARCHAR(20) DEFAULT NULL,
  `REPORT_TIME` VARCHAR(20) DEFAULT NULL,
  `FILE_ADDRESS` VARCHAR(500) DEFAULT NULL,
  `STORAGE_TIME` TIMESTAMP NULL DEFAULT NULL,
  `STORAGE_OPEN_ID` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--检验入库表（从表）
DROP TABLE IF EXISTS `DATA_INSPECT_DETAIL`;
CREATE TABLE `DATA_INSPECT_DETAIL` (
  `ID` CHAR(32) NOT NULL,
  `INSPECT_ID` CHAR(32) DEFAULT NULL,
  `ITEM_NAME` VARCHAR(200) DEFAULT NULL,
  `RESULT` VARCHAR(500) DEFAULT NULL,
  `UNIT` VARCHAR(100) DEFAULT NULL,
  `REF_RANGE` VARCHAR(200) DEFAULT NULL,
  `ABNORMAL` VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
*/
/*=============================================== 检查检验报告入库表 周鉴斌 2015-07-13  end ======================*/

/*=============================================== 停诊异常日志表 周鉴斌 2015-07-22  start ======================*/
DROP TABLE IF EXISTS BIZ_REGISTER_STOP_LOG;
CREATE TABLE BIZ_REGISTER_STOP_LOG 
(
   ID                   CHAR(32)                       NOT NULL,
   HOSPITAL_CODE        VARCHAR(50)                    NULL,
   BRANCH_HOSPITAL_CODE VARCHAR(50)                    NULL,
   REG_MODE             INTEGER                        NULL,
   BEGIN_DATE           VARCHAR(20)                    NULL,
   END_DATE             VARCHAR(20)                    NULL,
   STORAGE_TIME         TIMESTAMP                      NULL,
   CONSTRAINT PK_BIZ_REGISTER_STOP_LOG PRIMARY KEY CLUSTERED (ID)
);
/*=============================================== 停诊异常日志表 周鉴斌 2015-07-22  end ======================*/

/*=============================================== 模版库详情表 罗斌 2015-08-21  start ======================*/
DROP TABLE IF EXISTS `SYS_MSG_LIBRARY_CONTENT`;
CREATE TABLE `SYS_MSG_LIBRARY_CONTENT` (
  `ID` varchar(32) NOT NULL COMMENT '主键',
  `TEMP_LIBRARY_ID` varchar(32) DEFAULT NULL COMMENT '模版库主表ID',
  `SORT` int(10) DEFAULT NULL COMMENT '序号',
  `KEYWORD` varchar(20) DEFAULT NULL COMMENT '关键字',
  `VALUE` varchar(255) DEFAULT NULL COMMENT '内容',
  `NODE` varchar(20) DEFAULT NULL COMMENT '节点',
  `FONT_COLOR` varchar(20) DEFAULT NULL COMMENT '字体颜色',
  `CP` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `CT` datetime DEFAULT NULL COMMENT '创建时间',
  `EP` varchar(32) DEFAULT NULL COMMENT '修改人ID',
  `ET` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
);
/*=============================================== 模版库详情表 罗斌  2015-08-21  end ======================*/

/*=============================================== 权限管理 黄忠英 2015-10-12  start ======================*/
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `SYS_USER_HOSPITALS`;
DROP TABLE IF EXISTS SYS_USER_ROLES;

-- ----------------------------
-- Table structure for SYS_ORGANIZATION
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ORGANIZATION`;
CREATE TABLE `SYS_ORGANIZATION` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(64) DEFAULT NULL COMMENT '组织/机构/公司 名称',
  `INTRODUCTION` varchar(1024) DEFAULT NULL COMMENT '简介',
  `PARENT_ID` varchar(32) DEFAULT NULL COMMENT '父ID',
  `CODE` varchar(16) DEFAULT NULL COMMENT '编码(预留)',
  `MEMO` varchar(255) DEFAULT NULL COMMENT '备注',
  `CP` varchar(32) DEFAULT NULL,
  `CT` datetime DEFAULT NULL,
  `EP` varchar(32) DEFAULT NULL,
  `ET` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_9` (`PARENT_ID`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`PARENT_ID`) REFERENCES `SYS_ORGANIZATION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织/机构/公司';

-- ----------------------------
-- Table structure for SYS_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_RESOURCE`;
CREATE TABLE `SYS_RESOURCE` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(128) NOT NULL COMMENT '资源名称',
  `CODE` varchar(128) DEFAULT NULL COMMENT '编码(预留)',
  `ABSTR` varchar(128) DEFAULT NULL COMMENT '资源抽象(类型为菜单则值为菜单ID;其它则为字符串或正规表达式)',
  `TYPE` smallint(6) NOT NULL COMMENT '资源类型(1菜单;2;按钮;3普通链接;4医院)',
  `MEMO` varchar(255) DEFAULT NULL COMMENT '备注',
  `CP` varchar(32) DEFAULT NULL,
  `CT` datetime DEFAULT NULL,
  `EP` varchar(32) DEFAULT NULL,
  `ET` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Table structure for SYS_ROLE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ROLE`;
CREATE TABLE `SYS_ROLE` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL COMMENT '角色名称',
  `CODE` varchar(32) DEFAULT NULL COMMENT '角色编码',
  `MEMO` varchar(255) DEFAULT NULL COMMENT '备注',
  `AVAILABLE` smallint(6) DEFAULT NULL COMMENT '是否可用(0禁用;1可用)',
  `CP` varchar(32) DEFAULT NULL,
  `CT` datetime DEFAULT NULL,
  `EP` varchar(32) DEFAULT NULL,
  `ET` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for SYS_ROLE_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ROLE_RESOURCE`;
CREATE TABLE `SYS_ROLE_RESOURCE` (
  `ID` varchar(32) NOT NULL,
  `ROLE_ID` varchar(32) NOT NULL,
  `RESOURCE_ID` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_5` (`ROLE_ID`),
  KEY `FK_Reference_6` (`RESOURCE_ID`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `SYS_RESOURCE` (`ID`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`ROLE_ID`) REFERENCES `SYS_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色资源表';

-- ----------------------------
-- Table structure for SYS_USER
-- ----------------------------
DROP TABLE IF EXISTS `SYS_USER`;
CREATE TABLE `SYS_USER` (
  `ID` varchar(32) NOT NULL,
  `FULL_NAME` varchar(25) DEFAULT NULL COMMENT '显示名称',
  `USER_NAME` varchar(25) DEFAULT NULL COMMENT '登录名',
  `PASSWORD` varchar(128) DEFAULT NULL COMMENT '密码',
  `SALT` varchar(25) DEFAULT NULL COMMENT '盐值',
  `EMAIL` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `MEMO` varchar(255) DEFAULT NULL COMMENT '备注',
  `AVAILABLE` smallint(6) DEFAULT NULL COMMENT '是否可用(0禁用;1可用)',
  `ORGANIZATION_ID` varchar(32) DEFAULT NULL COMMENT '组织/机构/公司ID',
  `LAST_LOGIN_TIME` datetime DEFAULT NULL COMMENT '上次登录时间',
  `LAST_LOGIN_IP` varchar(15) DEFAULT NULL COMMENT '上次登录IP',
  `CP` varchar(32) DEFAULT NULL,
  `CT` datetime DEFAULT NULL,
  `EP` varchar(32) DEFAULT NULL,
  `ET` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_7` (`ORGANIZATION_ID`),
  KEY `FK_Reference_8` (`CP`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`CP`) REFERENCES `SYS_USER` (`ID`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`ORGANIZATION_ID`) REFERENCES `SYS_ORGANIZATION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- ----------------------------
-- Table structure for SYS_USER_ROLE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_USER_ROLE`;
CREATE TABLE `SYS_USER_ROLE` (
  `ID` varchar(32) NOT NULL,
  `USER_ID` varchar(32) NOT NULL,
  `ROLE_ID` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_3` (`USER_ID`),
  KEY `FK_Reference_4` (`ROLE_ID`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`ROLE_ID`) REFERENCES `SYS_ROLE` (`ID`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`USER_ID`) REFERENCES `SYS_USER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';
SET FOREIGN_KEY_CHECKS=1;
/*=============================================== 权限管理 黄忠英 2015-10-12  end ======================*/

/*=============================================== 消息模板库功能 申午武 2015-10-15  start ======================*/

drop table if exists SYS_MSG_TEMPLATE_LIBRARY_FUNCTION;

/*==============================================================*/
/* Table: SYS_MSG_TEMPLATE_LIBRARY_FUNCTION                     */
/*==============================================================*/
create table SYS_MSG_TEMPLATE_LIBRARY_FUNCTION
(
   ID                   varchar(32) not null comment '主键ID',
   TEMP_LIBRARY_ID      varchar(32) comment '模板库的模板ID',
   FUNCTION_NAME        varchar(50) comment '功能名称',
   FUNCTION_TYPE        int(1) comment '1:超链接,2:JS函数名称',
   FUNCTION_CODE        varchar(500) comment 'JS函数名称或者URL地址',
   SORT                 int(10) comment '功能点排序号',
   CP                   varchar(32) comment '创建人ID',
   CT                   datetime comment '创建时间',
   EP                   varchar(32) comment '修改人ID',
   ET                   datetime comment '修改时间',
   primary key (ID)
);

alter table SYS_MSG_TEMPLATE_LIBRARY_FUNCTION comment '消息模板库功能';
/*=============================================== 消息模板库功能 申午武 2015-10-15  end ======================*/

/*=============================================== 消息中心,设备信息库 申午武 2015-10-16  start ======================*/
drop table if exists SYS_MSG_CENTER;

/*==============================================================*/
/* Table: SYS_MSG_CENTER                                        */
/*==============================================================*/
create table SYS_MSG_CENTER
(
   ID                   varchar(32) not null comment 'ID',
   USER_ID              varchar(32) comment '用户ID',
   TEMPLATE_ID          varchar(32) comment '模板ID',
   HOSPITAL_ID          varchar(32)  comment '医院ID',
   HOSPITAL_NAME        varchar(100) comment '医院名称',
   MSG_TITLE            varchar(100) comment '消息标题',
   ICON_NAME			varchar(50) comment '图标名称',
   ICON_PATH            varchar(500) comment '图标路径',
   IS_READ              int(1) comment '1:未读,2:已读',
   MSG_CONTENT          varchar(5000) comment '消息内容',
   CP                   varchar(32) comment '创建人ID',
   CT                   datetime comment '创建时间',
   EP                   varchar(32) comment '修改人ID',
   ET                   datetime comment '修改时间',
   primary key (ID)
);

alter table SYS_MSG_CENTER comment '健康易消息中心(通知中心)';


drop table if exists EH_DEVICE_INFO;

/*==============================================================*/
/* Table: EH_DEVICE_INFO                                        */
/*==============================================================*/
create table EH_DEVICE_INFO
(
   ID                   varchar(32) not null comment '主键ID',
   USER_ID              varchar(32) comment '用户ID',
   APP_ID               varchar(100) comment '目前用来存储在百度云推送平台申请的账号ID,一个应用ID可以有多个应用类别',
   APP_TYPE             int(1) comment '1:健康易',
   DEVICE_ID            varchar(100) comment '设备ID',
   DEVICE_TYPE          int(1) comment '1:苹果,2:安卓',
   CHANNEL_ID           varchar(100) comment '渠道ID',
   CP                   varchar(32) comment '创建人ID',
   CT                   datetime comment '创建时间',
   EP                   varchar(32) comment '修改人ID',
   ET                   datetime comment '修改时间',
   primary key (ID)
);

alter table EH_DEVICE_INFO comment '设备信息表';

drop table if exists SYS_MSG_TEMPLATE_FUNCTION;

/*==============================================================*/
/* Table: SYS_MSG_TEMPLATE_FUNCTION                            */
/*==============================================================*/
create table SYS_MSG_TEMPLATE_FUNCTION
(
   ID                   varchar(32) not null comment '主键ID',
   TEMPLATE_ID          varchar(32) comment '模板ID',
   FUNCTION_NAME        varchar(50) comment '功能名称',
   FUNCTION_TYPE        int(1) comment '1:超链接,2:JS函数名称',
   FUNCTION_CODE        varchar(500) comment 'JS函数名称或者URL地址',
   SORT                 int(10) comment '功能点排序号',
   CP                   varchar(32) comment '创建人ID',
   CT                   datetime comment '创建时间',
   EP                   varchar(32) comment '修改人ID',
   ET                   datetime comment '修改时间',
   primary key (ID)
);

alter table SYS_MSG_TEMPLATE_FUNCTION comment '消息模板功能';

/*=============================================== 消息中心,设备信息库,功能 申午武 2015-10-16  end ======================*/


-------------------------------------2015年12月11日 健康易添加接种疫苗表  更新人：YY  start------------------

drop table if exists BIZ_VACCINATE;
CREATE TABLE `BIZ_VACCINATE` (
  `ID` varchar(32) NOT NULL,
  `REGION_NAME` varchar(50) DEFAULT NULL COMMENT '地区名',
  `VACCINATE_CLINIC_NAME` varchar(255) DEFAULT NULL COMMENT '接种门诊名称',
  `VACCINATE_CLINIC_ADDR` varchar(500) DEFAULT NULL COMMENT '接种门诊地址',
  `VACCINATE_CLINIC_TEL` varchar(50) DEFAULT NULL COMMENT '接种门诊电话',
  `AREA_CODE` varchar(50) DEFAULT NULL COMMENT '区域编码',
  `AREA_NAME` varchar(50) DEFAULT NULL COMMENT '区域名称',
   CP varchar(32) comment '创建人ID',
   CT datetime comment '创建时间',
   EP varchar(32) comment '修改人ID',
   ET datetime comment '修改时间',
  PRIMARY KEY (`ID`),
  KEY `IDX_VACCINATE_RNAME` (`REGION_NAME`) USING BTREE
);

-------------------------------------2015年12月11日 健康易添加接种疫苗表  更新人：YY  end------------------


/*==============================================================*/
/* Table: SYS_SETTING 全局配置表      2016-01-04 11:18                */
/*==============================================================*/
DROP TABLE IF EXISTS `SYS_SETTING`;
CREATE TABLE `SYS_SETTING` (
  `ID` varchar(32) NOT NULL,
  `FINISH_USER_INFO` int(1) DEFAULT '0' COMMENT '完成注册后是否推送完善资料提示',
  `FINISH_USER_INFO_CODE` varchar(100) DEFAULT NULL COMMENT '完成注册后是否推送完善资料提示code',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


/*=================================================================*/
/* Table: SYS_APP_HOSPITAL APP包含医院	  2016-04-22 09:38:20   更新人:zkw  */
/*=================================================================*/
create table SYS_APP_HOSPITAL
(
   ID                   varchar(32) not null ,
   PARENTAPPID          varchar(50) comment '父APPID',
   HOSPITAL_ID          varchar(32) comment '医院ID',
   SORT                 int comment '医院排序',
   CP                   varchar(32),
   CT                   datetime,
   EP                   varchar(32),
   ET                   datetime,
   primary key (ID)
);
