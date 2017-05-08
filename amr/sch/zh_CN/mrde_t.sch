/* 
================================================================================
檔案代號:mrde_t
檔案名稱:資源保修零件更換明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mrde_t
(
mrdeent       number(5)      ,/* 企業編號 */
mrdesite       varchar2(10)      ,/* 營運據點 */
mrdedocno       varchar2(20)      ,/* 保校單號 */
mrdeseq       number(10,0)      ,/* 保校項次 */
mrdeseq1       number(10,0)      ,/* 保校零件項次 */
mrde001       varchar2(40)      ,/* 零件品號 */
mrde002       number(20,6)      ,/* 數量 */
mrde003       varchar2(10)      ,/* 單位 */
mrde004       varchar2(255)      ,/* 零件備註 */
mrde005       varchar2(10)      ,/* 舊零件處理方式 */
mrdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrde_t add constraint mrde_pk primary key (mrdeent,mrdedocno,mrdeseq,mrdeseq1) enable validate;

create unique index mrde_pk on mrde_t (mrdeent,mrdedocno,mrdeseq,mrdeseq1);

grant select on mrde_t to tiptop;
grant update on mrde_t to tiptop;
grant delete on mrde_t to tiptop;
grant insert on mrde_t to tiptop;

exit;
