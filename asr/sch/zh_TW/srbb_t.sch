/* 
================================================================================
檔案代號:srbb_t
檔案名稱:重複性生產期末盤點單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srbb_t
(
srbbent       number(5)      ,/* 企業編號 */
srbbsite       varchar2(10)      ,/* 營運據點 */
srbbdocno       varchar2(20)      ,/* 盤點單號 */
srbbseq       number(10,0)      ,/* 項次 */
srbb001       varchar2(40)      ,/* 料件編號 */
srbb002       varchar2(256)      ,/* 產品特徵 */
srbb003       varchar2(10)      ,/* 庫位 */
srbb004       varchar2(10)      ,/* 儲位 */
srbb005       varchar2(30)      ,/* 批號 */
srbb006       varchar2(256)      ,/* 庫存特徵 */
srbb007       varchar2(10)      ,/* 單位 */
srbb008       number(20,6)      ,/* 賬面數量 */
srbb009       number(20,6)      ,/* 盤點數量 */
srbb010       varchar2(10)      ,/* 參考單位 */
srbb011       number(20,6)      ,/* 參考賬面數量 */
srbb012       number(20,6)      ,/* 參考盤點數量 */
srbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srbb_t add constraint srbb_pk primary key (srbbent,srbbdocno,srbbseq) enable validate;

create unique index srbb_pk on srbb_t (srbbent,srbbdocno,srbbseq);

grant select on srbb_t to tiptop;
grant update on srbb_t to tiptop;
grant delete on srbb_t to tiptop;
grant insert on srbb_t to tiptop;

exit;
