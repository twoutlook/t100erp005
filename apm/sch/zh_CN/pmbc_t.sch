/* 
================================================================================
檔案代號:pmbc_t
檔案名稱:交易對象申請-夥伴檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbc_t
(
pmbcent       number(5)      ,/* 企業編號 */
pmbcdocno       varchar2(20)      ,/* 申請單號 */
pmbc001       varchar2(10)      ,/* 交易對象編號 */
pmbc002       varchar2(10)      ,/* 交易夥伴編號 */
pmbc003       varchar2(10)      ,/* 交易類型 */
pmbc004       varchar2(1)      ,/* 主要否 */
pmbcstus       varchar2(10)      ,/* 狀態碼 */
pmbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbc_t add constraint pmbc_pk primary key (pmbcent,pmbcdocno,pmbc002,pmbc003) enable validate;

create unique index pmbc_pk on pmbc_t (pmbcent,pmbcdocno,pmbc002,pmbc003);

grant select on pmbc_t to tiptop;
grant update on pmbc_t to tiptop;
grant delete on pmbc_t to tiptop;
grant insert on pmbc_t to tiptop;

exit;
