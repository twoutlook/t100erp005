/* 
================================================================================
檔案代號:xmef_t
檔案名稱:訂單變更多帳期預收款檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmef_t
(
xmefent       number(5)      ,/* 企業編號 */
xmefsite       varchar2(10)      ,/* 營運據點 */
xmefdocno       varchar2(20)      ,/* 採購單號 */
xmef001       number(5,0)      ,/* 期別 */
xmef002       varchar2(10)      ,/* 收款條件 */
xmef003       date      ,/* 預計應收款日 */
xmef004       date      ,/* 預計票據到期日 */
xmef005       number(20,6)      ,/* 未稅金額 */
xmef006       number(20,6)      ,/* 含稅金額 */
xmef007       varchar2(20)      ,/* 應收帳款單號 */
xmef008       number(20,6)      ,/* 主帳套已收未稅金額 */
xmef009       number(20,6)      ,/* 主帳套已收含稅金額 */
xmef010       number(20,6)      ,/* 帳套二已收未稅金額 */
xmef011       number(20,6)      ,/* 帳套二已收含稅金額 */
xmef014       number(20,6)      ,/* 帳套三已收未稅金額 */
xmef015       number(20,6)      ,/* 帳套三已收含稅金額 */
xmef900       number(10,0)      ,/* 變更序 */
xmef901       varchar2(1)      ,/* 變更類型 */
xmef902       varchar2(10)      ,/* 變更理由 */
xmef903       varchar2(255)      ,/* 變更備註 */
xmefud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmefud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmefud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmefud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmefud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmefud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmefud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmefud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmefud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmefud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmefud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmefud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmefud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmefud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmefud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmefud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmefud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmefud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmefud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmefud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmefud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmefud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmefud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmefud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmefud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmefud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmefud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmefud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmefud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmefud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmef016       varchar2(10)      ,/* 帳款類型 */
xmef017       varchar2(10)      /* 帳款影響出貨模式 */
);
alter table xmef_t add constraint xmef_pk primary key (xmefent,xmefdocno,xmef001,xmef900) enable validate;

create unique index xmef_pk on xmef_t (xmefent,xmefdocno,xmef001,xmef900);

grant select on xmef_t to tiptop;
grant update on xmef_t to tiptop;
grant delete on xmef_t to tiptop;
grant insert on xmef_t to tiptop;

exit;
