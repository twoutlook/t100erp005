/* 
================================================================================
檔案代號:prdq_t
檔案名稱:促銷規則款別限定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdq_t
(
prdqent       number(5)      ,/* 企業編號 */
prdqunit       varchar2(10)      ,/* 應用組織 */
prdqsite       varchar2(10)      ,/* 營運據點 */
prdq001       varchar2(20)      ,/* 規則編號 */
prdq002       number(10,0)      ,/* 組別 */
prdq003       varchar2(10)      ,/* 款別編號 */
prdq004       varchar2(10)      ,/* 款別子類型 */
prdqstus       varchar2(10)      ,/* 有效否 */
prdqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prdq_t add constraint prdq_pk primary key (prdqent,prdq001,prdq002) enable validate;

create unique index prdq_pk on prdq_t (prdqent,prdq001,prdq002);

grant select on prdq_t to tiptop;
grant update on prdq_t to tiptop;
grant delete on prdq_t to tiptop;
grant insert on prdq_t to tiptop;

exit;
