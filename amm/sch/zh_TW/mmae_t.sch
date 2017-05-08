/* 
================================================================================
檔案代號:mmae_t
檔案名稱:會員基本資料申請檔-訊息通知方式
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmae_t
(
mmaeent       number(5)      ,/* 企業編號 */
mmaedocno       varchar2(20)      ,/* 單據編號 */
mmae001       varchar2(30)      ,/* 會員編號 */
mmae002       varchar2(10)      ,/* 訊息通知方式代碼 */
mmaeacti       varchar2(10)      ,/* 資料有效碼 */
mmaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmae_t add constraint mmae_pk primary key (mmaeent,mmaedocno,mmae002) enable validate;

create unique index mmae_pk on mmae_t (mmaeent,mmaedocno,mmae002);

grant select on mmae_t to tiptop;
grant update on mmae_t to tiptop;
grant delete on mmae_t to tiptop;
grant insert on mmae_t to tiptop;

exit;
