/* 
================================================================================
檔案代號:crae_t
檔案名稱:潛在客戶等級明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table crae_t
(
craeent       number(5)      ,/* 企業編號 */
crae001       number(5)      ,/* 應用分類 */
crae002       varchar2(10)      ,/* 應用分類碼 */
crae003       varchar2(10)      ,/* 潛在客戶等級行銷方式 */
craeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
craeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
craeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
craeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
craeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
craeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
craeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
craeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
craeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
craeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
craeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
craeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
craeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
craeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
craeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
craeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
craeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
craeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
craeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
craeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
craeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
craeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
craeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
craeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
craeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
craeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
craeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
craeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
craeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
craeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crae_t add constraint crae_pk primary key (craeent,crae001,crae002,crae003) enable validate;

create unique index crae_pk on crae_t (craeent,crae001,crae002,crae003);

grant select on crae_t to tiptop;
grant update on crae_t to tiptop;
grant delete on crae_t to tiptop;
grant insert on crae_t to tiptop;

exit;
