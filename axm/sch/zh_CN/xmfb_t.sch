/* 
================================================================================
檔案代號:xmfb_t
檔案名稱:銷售報價範本分類明細單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfb_t
(
xmfbent       number(5)      ,/* 企業編號 */
xmfbsite       varchar2(10)      ,/* 營運據點 */
xmfbdocno       varchar2(20)      ,/* 範本料號 */
xmfb001       number(5,0)      ,/* 版本 */
xmfb002       number(10,0)      ,/* 序號 */
xmfb003       varchar2(10)      ,/* 分類 */
xmfb004       varchar2(1)      ,/* 單選 */
xmfb005       number(20,6)      ,/* 數量下限 */
xmfb006       number(20,6)      ,/* 數量上限 */
xmfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfb_t add constraint xmfb_pk primary key (xmfbent,xmfbdocno,xmfb001,xmfb002) enable validate;

create unique index xmfb_pk on xmfb_t (xmfbent,xmfbdocno,xmfb001,xmfb002);

grant select on xmfb_t to tiptop;
grant update on xmfb_t to tiptop;
grant delete on xmfb_t to tiptop;
grant insert on xmfb_t to tiptop;

exit;
