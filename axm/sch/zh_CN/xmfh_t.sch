/* 
================================================================================
檔案代號:xmfh_t
檔案名稱:銷售報價費用資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmfh_t
(
xmfhent       number(5)      ,/* 企業編號 */
xmfhsite       varchar2(10)      ,/* 營運據點 */
xmfhdocno       varchar2(20)      ,/* 估價單號 */
xmfhseq       number(10,0)      ,/* 項次 */
xmfh001       varchar2(40)      ,/* 費用料號 */
xmfh002       varchar2(10)      ,/* 幣別 */
xmfh003       number(20,10)      ,/* 匯率 */
xmfh004       number(20,6)      ,/* 預估金額 */
xmfh005       varchar2(10)      ,/* 建議廠商 */
xmfh006       varchar2(255)      ,/* 備註 */
xmfhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfh_t add constraint xmfh_pk primary key (xmfhent,xmfhdocno,xmfhseq) enable validate;

create unique index xmfh_pk on xmfh_t (xmfhent,xmfhdocno,xmfhseq);

grant select on xmfh_t to tiptop;
grant update on xmfh_t to tiptop;
grant delete on xmfh_t to tiptop;
grant insert on xmfh_t to tiptop;

exit;
