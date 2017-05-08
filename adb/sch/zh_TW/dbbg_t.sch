/* 
================================================================================
檔案代號:dbbg_t
檔案名稱:配送倉庫出貨範圍設置-商品範圍
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dbbg_t
(
dbbgent       number(5)      ,/* 企業代碼 */
dbbgsite       varchar2(10)      ,/* 營運據點 */
dbbg001       varchar2(10)      ,/* 庫位編號 */
dbbg002       varchar2(10)      ,/* 產品屬性類型 */
dbbg003       varchar2(40)      ,/* 屬性質編號 */
dbbgownid       varchar2(20)      ,/* 資料所有者 */
dbbgowndp       varchar2(10)      ,/* 資料所屬部門 */
dbbgcrtid       varchar2(20)      ,/* 資料建立者 */
dbbgcrtdp       varchar2(10)      ,/* 資料建立部門 */
dbbgcrtdt       timestamp(0)      ,/* 資料創建日 */
dbbgmodid       varchar2(20)      ,/* 資料修改者 */
dbbgmoddt       timestamp(0)      ,/* 最近修改日 */
dbbgstus       varchar2(10)      ,/* 狀態碼 */
dbbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbbg_t add constraint dbbg_pk primary key (dbbgent,dbbgsite,dbbg001,dbbg002,dbbg003) enable validate;

create unique index dbbg_pk on dbbg_t (dbbgent,dbbgsite,dbbg001,dbbg002,dbbg003);

grant select on dbbg_t to tiptop;
grant update on dbbg_t to tiptop;
grant delete on dbbg_t to tiptop;
grant insert on dbbg_t to tiptop;

exit;
