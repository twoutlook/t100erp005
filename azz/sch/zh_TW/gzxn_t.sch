/* 
================================================================================
檔案代號:gzxn_t
檔案名稱:查詢方案單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxn_t
(
gzxnent       number(5)      ,/* 企業編號 */
gzxn001       number(10,0)      ,/* QBE編號 */
gzxn002       varchar2(20)      ,/* 作業編號 */
gzxn003       varchar2(20)      ,/* 員工編號 */
gzxn004       number(10,0)      ,/* 條件序號 */
gzxn005       varchar2(20)      ,/* 欄位編號 */
gzxn006       varchar2(2)      ,/* 運運算元 */
gzxn007       varchar2(500)      ,/* 簡易條件值 */
gzxn008       varchar2(500)      ,/* 實際條件值 */
gzxn009       varchar2(10)      ,/* 條件類型 */
gzxnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxnud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzxn010       varchar2(15)      /* 檔案編號 */
);
alter table gzxn_t add constraint gzxn_pk primary key (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004) enable validate;

create unique index gzxn_pk on gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004);

grant select on gzxn_t to tiptop;
grant update on gzxn_t to tiptop;
grant delete on gzxn_t to tiptop;
grant insert on gzxn_t to tiptop;

exit;
