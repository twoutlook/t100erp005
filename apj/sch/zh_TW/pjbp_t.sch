/* 
================================================================================
檔案代號:pjbp_t
檔案名稱:專案成員變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbp_t
(
pjbpent       number(5)      ,/* 企業編號 */
pjbp001       varchar2(20)      ,/* 專案編號 */
pjbp002       varchar2(10)      ,/* 專案角色 */
pjbp003       varchar2(20)      ,/* 員工編號 */
pjbp004       date      ,/* 生效日期 */
pjbp005       date      ,/* 失效日期 */
pjbp006       varchar2(255)      ,/* 備註 */
pjbp900       number(10,0)      ,/* 變更序 */
pjbp901       varchar2(1)      ,/* 變更類型 */
pjbp902       date      ,/* 變更日期 */
pjbp903       varchar2(10)      ,/* 變更理由 */
pjbp904       varchar2(255)      ,/* 變更備註 */
pjbpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjbp_t add constraint pjbp_pk primary key (pjbpent,pjbp001,pjbp002,pjbp003,pjbp900) enable validate;

create unique index pjbp_pk on pjbp_t (pjbpent,pjbp001,pjbp002,pjbp003,pjbp900);

grant select on pjbp_t to tiptop;
grant update on pjbp_t to tiptop;
grant delete on pjbp_t to tiptop;
grant insert on pjbp_t to tiptop;

exit;
