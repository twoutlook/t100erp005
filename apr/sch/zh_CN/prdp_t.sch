/* 
================================================================================
檔案代號:prdp_t
檔案名稱:促銷規則生效組織資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdp_t
(
prdpent       number(5)      ,/* 企業編號 */
prdpunit       varchar2(10)      ,/* 應用組織 */
prdpsite       varchar2(10)      ,/* 營運據點 */
prdp001       varchar2(20)      ,/* 規則編號 */
prdp002       number(10,0)      ,/* 組別 */
prdp003       varchar2(10)      ,/* 類型 */
prdp004       varchar2(10)      ,/* 店群/門店 */
prdpstus       varchar2(10)      ,/* 有效否 */
prdpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prdp_t add constraint prdp_pk primary key (prdpent,prdp001,prdp002) enable validate;

create unique index prdp_pk on prdp_t (prdpent,prdp001,prdp002);

grant select on prdp_t to tiptop;
grant update on prdp_t to tiptop;
grant delete on prdp_t to tiptop;
grant insert on prdp_t to tiptop;

exit;
