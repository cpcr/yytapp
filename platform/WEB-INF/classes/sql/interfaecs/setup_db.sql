drop table if exists SYS_INTERFACES_STATUS;

/*==============================================================*/
/* Table: SYS_INTERFACES_STATUS         前置机诊断记录表                                                                        */
/*==============================================================*/
create table SYS_INTERFACES_STATUS
(
   ID                   varchar(32) not null ,
   BRANCH_CODE          varchar(50),
   INTERFACES_ID        varchar(50),
   HOSPITAL_NAME        varchar(100),
   RESULT_CODE          varchar(10),
   RESULT_MESSAGE       varchar(250) comment '返回信息',
   STATUS               int comment '前置机状态：1 异常 0 正常',
   CREATE_TIME          datetime comment '诊断时间',
   primary key (ID)
);