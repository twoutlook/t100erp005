/* 
================================================================================
檔案代號:mrdb_t
檔案名稱:資源保校記錄明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mrdb_t
(
mrdbent       number(5)      ,/* 企業編號 */
mrdbsite       varchar2(10)      ,/* 營運據點 */
mrdbdocno       varchar2(20)      ,/* 保校單號 */
mrdbseq       number(10,0)      ,/* 項次 */
mrdb001       varchar2(10)      ,/* 保修項目 */
mrdb002       varchar2(10)      ,/* 保修部位 */
mrdb003       varchar2(500)      ,/* 保修內容 */
mrdb004       varchar2(1)      ,/* 完成否 */
mrdb005       varchar2(10)      ,/* 儀錶編號 */
mrdb006       varchar2(80)      ,/* 儀錶值(校正前) */
mrdb007       varchar2(80)      ,/* 儀錶值(校正後) */
mrdb012       varchar2(10)      ,/* 缺失原因 */
mrdb013       varchar2(255)      ,/* 備註 */
mrdb014       varchar2(80)      ,/* 儀錶標準值 */
mrdb015       varchar2(8)      ,/* 花費時間 */
mrdb016       varchar2(10)      ,/* 時間單位 */
mrdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrdb_t add constraint mrdb_pk primary key (mrdbent,mrdbdocno,mrdbseq) enable validate;

create unique index mrdb_pk on mrdb_t (mrdbent,mrdbdocno,mrdbseq);

grant select on mrdb_t to tiptop;
grant update on mrdb_t to tiptop;
grant delete on mrdb_t to tiptop;
grant insert on mrdb_t to tiptop;

exit;
