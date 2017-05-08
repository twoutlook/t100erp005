/* 
================================================================================
檔案代號:xmei_t
檔案名稱:訂單變更費用資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmei_t
(
xmeient       number(5)      ,/* 企業編號 */
xmeisite       varchar2(10)      ,/* 營運據點 */
xmeidocno       varchar2(20)      ,/* 估價單號 */
xmeiseq       number(10,0)      ,/* 項次 */
xmei001       varchar2(40)      ,/* 費用料號 */
xmei002       varchar2(10)      ,/* 幣別 */
xmei003       number(20,10)      ,/* 匯率 */
xmei004       number(20,6)      ,/* 預估金額 */
xmei005       varchar2(10)      ,/* 建議廠商 */
xmei006       varchar2(255)      ,/* 備註 */
xmei900       number(10,0)      ,/* 變更序 */
xmei901       varchar2(1)      ,/* 變更類型 */
xmei902       varchar2(10)      ,/* 變更理由 */
xmei903       varchar2(255)      ,/* 變更備註 */
xmeiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmeiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmeiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmeiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmeiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmeiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmeiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmeiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmeiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmeiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmeiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmeiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmeiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmeiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmeiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmeiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmeiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmeiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmeiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmeiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmeiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmeiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmeiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmeiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmeiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmeiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmeiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmeiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmeiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmeiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmei_t add constraint xmei_pk primary key (xmeient,xmeidocno,xmeiseq,xmei900) enable validate;

create unique index xmei_pk on xmei_t (xmeient,xmeidocno,xmeiseq,xmei900);

grant select on xmei_t to tiptop;
grant update on xmei_t to tiptop;
grant delete on xmei_t to tiptop;
grant insert on xmei_t to tiptop;

exit;
