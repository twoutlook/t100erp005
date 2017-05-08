/* 
================================================================================
檔案代號:gztf_t
檔案名稱:模組流程使用作業紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gztf_t
(
gztf001       varchar2(10)      ,/* 流程編號 */
gztf002       varchar2(20)      ,/* 作業編號 */
gztf003       varchar2(1)      ,/* 測試通過否 */
gztf004       number(5,0)      ,/* 序號 */
gztfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gztfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gztfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gztfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gztfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gztfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gztfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gztfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gztfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gztfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gztfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gztfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gztfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gztfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gztfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gztfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gztfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gztfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gztfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gztfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gztfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gztfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gztfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gztfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gztfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gztfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gztfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gztfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gztfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gztfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gztf_t add constraint gztf_pk primary key (gztf001,gztf004) enable validate;

create unique index gztf_pk on gztf_t (gztf001,gztf004);

grant select on gztf_t to tiptop;
grant update on gztf_t to tiptop;
grant delete on gztf_t to tiptop;
grant insert on gztf_t to tiptop;

exit;
