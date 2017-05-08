/* 
================================================================================
檔案代號:gldm_t
檔案名稱:合併報表會計科目沖銷規則_MULTI對沖科目公式資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gldm_t
(
gldment       number(5)      ,/* 企業代碼 */
gldm001       varchar2(10)      ,/* 公司編號(來源) */
gldm002       varchar2(5)      ,/* 合併帳別(來源) */
gldm003       varchar2(10)      ,/* 公司編號(對沖) */
gldm004       varchar2(5)      ,/* 合併帳別(對沖) */
gldm005       varchar2(10)      ,/* 上層公司(合併主體) */
gldm006       varchar2(5)      ,/* 合併帳別(合併主體) */
gldm007       number(10,0)      ,/* 沖銷組別序號 */
gldm008       varchar2(24)      ,/* MULTI科目設定值(對沖公司) */
gldm009       varchar2(24)      ,/* 科目編號 */
gldm010       varchar2(1)      ,/* 加/減項 */
gldmownid       varchar2(20)      ,/* 資料所有者 */
gldmowndp       varchar2(10)      ,/* 資料所屬部門 */
gldmcrtid       varchar2(20)      ,/* 資料建立者 */
gldmcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldmcrtdt       timestamp(0)      ,/* 資料創建日 */
gldmmodid       varchar2(20)      ,/* 資料修改者 */
gldmmoddt       timestamp(0)      ,/* 最近修改日 */
gldmstus       varchar2(10)      ,/* 狀態碼 */
gldmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldm_t add constraint gldm_pk primary key (gldment,gldm001,gldm002,gldm003,gldm004,gldm005,gldm006,gldm007,gldm008,gldm009) enable validate;

create unique index gldm_pk on gldm_t (gldment,gldm001,gldm002,gldm003,gldm004,gldm005,gldm006,gldm007,gldm008,gldm009);

grant select on gldm_t to tiptop;
grant update on gldm_t to tiptop;
grant delete on gldm_t to tiptop;
grant insert on gldm_t to tiptop;

exit;
