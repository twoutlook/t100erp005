/* 
================================================================================
檔案代號:xmec_t
檔案名稱:銷售合約變更累計定價明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmec_t
(
xmecent       number(5)      ,/* 企業編號 */
xmecsite       varchar2(10)      ,/* 營運據點 */
xmecdocno       varchar2(20)      ,/* 合約單號 */
xmec900       number(10,0)      ,/* 變更序 */
xmecseq       number(10,0)      ,/* 項次 */
xmecseq1       number(20,6)      ,/* 項序 */
xmec001       number(20,6)      ,/* 到達數量 */
xmec002       number(20,6)      ,/* 單價 */
xmec003       number(20,6)      ,/* 折扣率 */
xmec004       date      ,/* 數量到達日期 */
xmec005       varchar2(20)      ,/* 數量到達參考單號 */
xmec901       varchar2(1)      ,/* 變更類型 */
xmec902       varchar2(10)      ,/* 變更理由 */
xmec903       varchar2(255)      ,/* 變更備註 */
xmecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmecud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmec_t add constraint xmec_pk primary key (xmecent,xmecdocno,xmec900,xmecseq,xmecseq1) enable validate;

create unique index xmec_pk on xmec_t (xmecent,xmecdocno,xmec900,xmecseq,xmecseq1);

grant select on xmec_t to tiptop;
grant update on xmec_t to tiptop;
grant delete on xmec_t to tiptop;
grant insert on xmec_t to tiptop;

exit;
