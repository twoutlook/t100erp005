/* 
================================================================================
檔案代號:ecbg_t
檔案名稱:料件製程資源項目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ecbg_t
(
ecbgent       number(5)      ,/* 企業編號 */
ecbgsite       varchar2(10)      ,/* 營運據點 */
ecbg001       varchar2(40)      ,/* 製程料號 */
ecbg002       varchar2(10)      ,/* 製程編號 */
ecbg003       number(10,0)      ,/* 項次 */
ecbgseq       number(10,0)      ,/* 項序 */
ecbg004       varchar2(10)      ,/* 資源類型 */
ecbg005       varchar2(10)      ,/* 資源項目 */
ecbg006       number(15,3)      ,/* 固定標準工時 */
ecbg007       number(15,3)      ,/* 變動標準工時 */
ecbg008       number(20,6)      ,/* 變動標準工時批量 */
ecbg009       number(20,6)      ,/* 效率 */
ecbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecbg_t add constraint ecbg_pk primary key (ecbgent,ecbgsite,ecbg001,ecbg002,ecbg003,ecbgseq) enable validate;

create unique index ecbg_pk on ecbg_t (ecbgent,ecbgsite,ecbg001,ecbg002,ecbg003,ecbgseq);

grant select on ecbg_t to tiptop;
grant update on ecbg_t to tiptop;
grant delete on ecbg_t to tiptop;
grant insert on ecbg_t to tiptop;

exit;
