/* 
================================================================================
檔案代號:pmbd_t
檔案名稱:交易對象申請-允許收/付款條件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbd_t
(
pmbdent       number(5)      ,/* 企業編號 */
pmbddocno       varchar2(20)      ,/* 申請單號 */
pmbd001       varchar2(10)      ,/* 交易對象編號 */
pmbd002       varchar2(10)      ,/* 交易條件編號 */
pmbd003       varchar2(10)      ,/* 交易類型 */
pmbd004       varchar2(1)      ,/* 主要否 */
pmbdstus       varchar2(10)      ,/* 狀態碼 */
pmbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbd_t add constraint pmbd_pk primary key (pmbdent,pmbddocno,pmbd002,pmbd003) enable validate;

create unique index pmbd_pk on pmbd_t (pmbdent,pmbddocno,pmbd002,pmbd003);

grant select on pmbd_t to tiptop;
grant update on pmbd_t to tiptop;
grant delete on pmbd_t to tiptop;
grant insert on pmbd_t to tiptop;

exit;
