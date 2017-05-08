/* 
================================================================================
檔案代號:dedb_t
檔案名稱:營業款調整單身
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table dedb_t
(
dedbent       number(5)      ,/* 企業編號 */
dedbsite       varchar2(10)      ,/* 營運據點 */
dedbunit       varchar2(10)      ,/* 應用組織 */
dedbdocno       varchar2(20)      ,/* 單據編號 */
dedbdocdt       date      ,/* 營業日期 */
dedbseq       number(10,0)      ,/* 項次 */
dedb001       varchar2(10)      ,/* 款別分類 */
dedb002       varchar2(10)      ,/* 款別編號 */
dedb003       varchar2(10)      ,/* 卡券種編號 */
dedb004       varchar2(10)      ,/* 幣別 */
dedb005       number(20,6)      ,/* 系統金額 */
dedb006       number(20,6)      ,/* 調整金額 */
dedb007       varchar2(10)      ,/* 調整原因代碼 */
dedbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dedbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dedbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dedbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dedbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dedbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dedbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dedbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dedbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dedbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dedbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dedbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dedbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dedbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dedbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dedbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dedbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dedbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dedbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dedbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dedbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dedbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dedbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dedbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dedbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dedbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dedbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dedbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dedbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dedbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dedb_t add constraint dedb_pk primary key (dedbent,dedbdocno,dedbseq) enable validate;

create unique index dedb_pk on dedb_t (dedbent,dedbdocno,dedbseq);

grant select on dedb_t to tiptop;
grant update on dedb_t to tiptop;
grant delete on dedb_t to tiptop;
grant insert on dedb_t to tiptop;

exit;
