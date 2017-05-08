/* 
================================================================================
檔案代號:mmdd_t
檔案名稱:卡付款規則申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmdd_t
(
mmddent       number(5)      ,/* 企業編號 */
mmddsite       varchar2(10)      ,/* 營運據點 */
mmddunit       varchar2(10)      ,/* 應用組織 */
mmdddocno       varchar2(30)      ,/* 單據編號 */
mmdd001       varchar2(30)      ,/* 活動規則編號 */
mmdd002       varchar2(10)      ,/* 卡種編號 */
mmdd003       varchar2(10)      ,/* 規則類型 */
mmdd004       varchar2(40)      ,/* 規則編碼 */
mmddacti       varchar2(1)      ,/* 資料有效 */
mmddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmdd_t add constraint mmdd_pk primary key (mmddent,mmdddocno,mmdd001,mmdd003,mmdd004) enable validate;

create unique index mmdd_pk on mmdd_t (mmddent,mmdddocno,mmdd001,mmdd003,mmdd004);

grant select on mmdd_t to tiptop;
grant update on mmdd_t to tiptop;
grant delete on mmdd_t to tiptop;
grant insert on mmdd_t to tiptop;

exit;
