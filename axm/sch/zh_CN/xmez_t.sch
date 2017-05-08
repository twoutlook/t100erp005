/* 
================================================================================
檔案代號:xmez_t
檔案名稱:銷售估價範本費用資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmez_t
(
xmezent       number(5)      ,/* 企業編號 */
xmezsite       varchar2(10)      ,/* 營運據點 */
xmezdocno       varchar2(20)      ,/* 估價單號 */
xmez001       number(5,0)      ,/* 版次 */
xmezseq       number(10,0)      ,/* 項次 */
xmez002       varchar2(40)      ,/* 費用料號 */
xmez003       varchar2(10)      ,/* 幣別 */
xmez004       number(20,10)      ,/* 匯率 */
xmez005       number(20,6)      ,/* 預估金額 */
xmez006       varchar2(10)      ,/* 建議廠商 */
xmez007       varchar2(255)      ,/* 備註 */
xmezud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmezud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmezud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmezud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmezud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmezud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmezud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmezud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmezud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmezud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmezud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmezud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmezud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmezud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmezud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmezud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmezud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmezud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmezud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmezud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmezud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmezud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmezud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmezud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmezud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmezud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmezud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmezud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmezud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmezud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmez_t add constraint xmez_pk primary key (xmezent,xmezsite,xmezdocno,xmez001,xmezseq) enable validate;

create unique index xmez_pk on xmez_t (xmezent,xmezsite,xmezdocno,xmez001,xmezseq);

grant select on xmez_t to tiptop;
grant update on xmez_t to tiptop;
grant delete on xmez_t to tiptop;
grant insert on xmez_t to tiptop;

exit;
