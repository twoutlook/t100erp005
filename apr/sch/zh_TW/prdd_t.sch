/* 
================================================================================
檔案代號:prdd_t
檔案名稱:促銷規則申請時間資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdd_t
(
prddent       number(5)      ,/* 企業編號 */
prddunit       varchar2(10)      ,/* 應用組織 */
prddsite       varchar2(10)      ,/* 營運據點 */
prdddocno       varchar2(20)      ,/* 促銷申請單號 */
prdd001       varchar2(20)      ,/* 規則編號 */
prdd002       number(10,0)      ,/* 組別 */
prdd003       date      ,/* 開始日期 */
prdd004       date      ,/* 結束日期 */
prdd005       varchar2(8)      ,/* 開始時間 */
prdd006       varchar2(8)      ,/* 結束時間 */
prdd007       varchar2(10)      ,/* 固定日期 */
prdd008       varchar2(1)      ,/* 固定星期 */
prddacti       varchar2(10)      ,/* 有效否 */
prddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prdd_t add constraint prdd_pk primary key (prddent,prdddocno,prdd002) enable validate;

create unique index prdd_pk on prdd_t (prddent,prdddocno,prdd002);

grant select on prdd_t to tiptop;
grant update on prdd_t to tiptop;
grant delete on prdd_t to tiptop;
grant insert on prdd_t to tiptop;

exit;
