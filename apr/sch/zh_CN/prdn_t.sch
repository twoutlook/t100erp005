/* 
================================================================================
檔案代號:prdn_t
檔案名稱:促銷規則對象明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdn_t
(
prdnent       number(5)      ,/* 企業編號 */
prdnunit       varchar2(10)      ,/* 應用組織 */
prdnsite       varchar2(10)      ,/* 營運據點 */
prdn001       varchar2(20)      ,/* 規則編號 */
prdn002       number(10,0)      ,/* 組別 */
prdn003       varchar2(10)      ,/* 對象屬性 */
prdn004       varchar2(10)      ,/* 屬性代碼 */
prdnstus       varchar2(10)      ,/* 有效否 */
prdnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prdn_t add constraint prdn_pk primary key (prdnent,prdn001,prdn002,prdn003,prdn004) enable validate;

create unique index prdn_pk on prdn_t (prdnent,prdn001,prdn002,prdn003,prdn004);

grant select on prdn_t to tiptop;
grant update on prdn_t to tiptop;
grant delete on prdn_t to tiptop;
grant insert on prdn_t to tiptop;

exit;
