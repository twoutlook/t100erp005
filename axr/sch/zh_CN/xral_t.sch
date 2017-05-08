/* 
================================================================================
檔案代號:xral_t
檔案名稱:遞延認列各期明細設定主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xral_t
(
xralent       number(5)      ,/* 企業代碼 */
xralld       varchar2(5)      ,/* 帳套 */
xral001       varchar2(10)      ,/* 遞延認列類型 */
xralseq       number(5,0)      ,/* 主項次 */
xralseq1       number(5,0)      ,/* 攤銷期別 */
xral002       number(20,6)      ,/* 攤銷比例 */
xralud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xralud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xralud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xralud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xralud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xralud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xralud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xralud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xralud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xralud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xralud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xralud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xralud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xralud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xralud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xralud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xralud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xralud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xralud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xralud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xralud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xralud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xralud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xralud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xralud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xralud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xralud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xralud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xralud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xralud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xral_t add constraint xral_pk primary key (xralent,xralld,xral001,xralseq,xralseq1) enable validate;

create unique index xral_pk on xral_t (xralent,xralld,xral001,xralseq,xralseq1);

grant select on xral_t to tiptop;
grant update on xral_t to tiptop;
grant delete on xral_t to tiptop;
grant insert on xral_t to tiptop;

exit;
