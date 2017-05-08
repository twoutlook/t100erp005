/* 
================================================================================
檔案代號:sfnb_t
檔案名稱:異常工時申報單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfnb_t
(
sfnbent       number(5)      ,/* 企業代碼 */
sfnbsite       varchar2(10)      ,/* 營運據點 */
sfnbdocno       varchar2(20)      ,/* 單號 */
sfnbseq       number(10,0)      ,/* 項次 */
sfnb000       varchar2(10)      ,/* 異常類別代號 */
sfnb001       varchar2(255)      ,/* 異常描述 */
sfnb002       number(10,0)      ,/* 轉稼人數 */
sfnb003       date      ,/* 開始日期 */
sfnb004       date      ,/* 結束日期 */
sfnb005       number(15,3)      ,/* 異常工時 */
sfnb006       varchar2(20)      ,/* 影響工單 */
sfnb007       varchar2(10)      ,/* 責任部門 */
sfnb008       varchar2(1)      ,/* 責任部門確認 */
sfnb009       number(15,3)      ,/* 確認轉稼工時 */
sfnb010       varchar2(1)      ,/* 是有有償 */
sfnb011       varchar2(1)      ,/* 是否有效工時 */
sfnb012       varchar2(8)      ,/* 開始時間 */
sfnb013       varchar2(8)      ,/* 結束時間 */
sfnb014       varchar2(10)      ,/* 影響工作站 */
sfnbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfnbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfnbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfnbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfnbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfnbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfnbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfnbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfnbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfnbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfnbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfnbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfnbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfnbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfnbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfnbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfnbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfnbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfnbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfnbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfnbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfnbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfnbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfnbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfnbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfnbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfnbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfnbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfnbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfnbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfnb_t add constraint sfnb_pk primary key (sfnbent,sfnbdocno,sfnbseq) enable validate;

create unique index sfnb_pk on sfnb_t (sfnbent,sfnbdocno,sfnbseq);

grant select on sfnb_t to tiptop;
grant update on sfnb_t to tiptop;
grant delete on sfnb_t to tiptop;
grant insert on sfnb_t to tiptop;

exit;
