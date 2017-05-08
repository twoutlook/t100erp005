/* 
================================================================================
檔案代號:bmib_t
檔案名稱:料件承認申請承認內容檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmib_t
(
bmibent       number(5)      ,/* 企業編號 */
bmibsite       varchar2(10)      ,/* 營運據點 */
bmibdocno       varchar2(20)      ,/* 料件承認申請單號 */
bmibseq       number(10,0)      ,/* 項次 */
bmib001       varchar2(10)      ,/* 分類代碼 */
bmibseq1       number(10,0)      ,/* 項次 */
bmib002       varchar2(80)      ,/* 承認內容 */
bmib003       varchar2(10)      ,/* 責任部門 */
bmib004       varchar2(1)      ,/* 須回覆否 */
bmib005       varchar2(1)      ,/* 通過否 */
bmib006       varchar2(255)      ,/* 其它說明 */
bmib007       varchar2(20)      ,/* 回覆人員 */
bmib008       varchar2(10)      ,/* 回覆部門 */
bmib009       timestamp(0)      ,/* 回覆時間 */
bmibud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmibud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmibud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmibud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmibud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmibud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmibud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmibud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmibud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmibud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmibud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmibud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmibud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmibud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmibud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmibud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmibud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmibud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmibud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmibud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmibud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmibud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmibud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmibud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmibud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmibud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmibud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmibud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmibud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmibud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmib_t add constraint bmib_pk primary key (bmibent,bmibdocno,bmibseq,bmibseq1) enable validate;

create unique index bmib_pk on bmib_t (bmibent,bmibdocno,bmibseq,bmibseq1);

grant select on bmib_t to tiptop;
grant update on bmib_t to tiptop;
grant delete on bmib_t to tiptop;
grant insert on bmib_t to tiptop;

exit;
