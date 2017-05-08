/* 
================================================================================
檔案代號:logs_t
檔案名稱:参数更改纪录表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logs_t
(
logsent       number(5)      ,/* 企业编号 */
logs001       varchar2(20)      ,/* 员工编号 */
logs002       varchar2(10)      ,/* 参数编号 */
logs003       varchar2(10)      ,/* 营运据点编号 */
logs004       varchar2(80)      ,/* 数据旧值 */
logs005       varchar2(80)      ,/* 数据新值 */
logs006       timestamp(0)      ,/* 更改时间 */
logs007       varchar2(10)      ,/* 更改人员部门 */
logsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logsud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
logs008       varchar2(20)      ,/* 异动作业 */
logs009       varchar2(40)      ,/* client IP */
logs010       varchar2(20)      /* sessionkey */
);


grant select on logs_t to tiptop;
grant update on logs_t to tiptop;
grant delete on logs_t to tiptop;
grant insert on logs_t to tiptop;

exit;
