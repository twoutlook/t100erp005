/* 
================================================================================
檔案代號:mmcm_t
檔案名稱:換贈贈品資訊單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmcm_t
(
mmcment       number(5)      ,/* 企業編號 */
mmcm001       varchar2(30)      ,/* 活動規則編號 */
mmcm002       varchar2(10)      ,/* 卡種編號 */
mmcm003       number(10,0)      ,/* 換贈組別 */
mmcm004       varchar2(10)      ,/* 換贈資料類型 */
mmcm005       varchar2(40)      ,/* 資料編號 */
mmcm006       varchar2(10)      ,/* 單位 */
mmcm007       number(20,6)      ,/* 贈送數量 */
mmcm008       varchar2(10)      ,/* 附屬條件 */
mmcm009       number(20,6)      ,/* 換贈加價/加積點 */
mmcm010       number(20,6)      ,/* 換贈會員加價/加積點 */
mmcm011       number(10,0)      ,/* 上限名額 */
mmcm012       varchar2(10)      ,/* 上限統計時間範圍 */
mmcmstus       varchar2(1)      ,/* 有效 */
mmcmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcm_t add constraint mmcm_pk primary key (mmcment,mmcm001,mmcm003,mmcm004,mmcm005) enable validate;

create unique index mmcm_pk on mmcm_t (mmcment,mmcm001,mmcm003,mmcm004,mmcm005);

grant select on mmcm_t to tiptop;
grant update on mmcm_t to tiptop;
grant delete on mmcm_t to tiptop;
grant insert on mmcm_t to tiptop;

exit;
