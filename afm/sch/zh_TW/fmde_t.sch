/* 
================================================================================
檔案代號:fmde_t
檔案名稱:解除抵押質押單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmde_t
(
fmdeent       number(5)      ,/* 企業編號 */
fmdedocno       varchar2(20)      ,/* 解除質押單號 */
fmdeseq       number(10,0)      ,/* 項次 */
fmde001       varchar2(20)      ,/* 融資合同同號 */
fmde002       number(10,0)      ,/* 合同項次 */
fmde003       number(10,0)      ,/* 抵押質押項次 */
fmde004       varchar2(20)      ,/* 庫存解除留置單號 */
fmdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmdeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmde_t add constraint fmde_pk primary key (fmdeent,fmdedocno,fmdeseq) enable validate;

create unique index fmde_pk on fmde_t (fmdeent,fmdedocno,fmdeseq);

grant select on fmde_t to tiptop;
grant update on fmde_t to tiptop;
grant delete on fmde_t to tiptop;
grant insert on fmde_t to tiptop;

exit;
