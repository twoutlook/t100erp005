/* 
================================================================================
檔案代號:pmec_t
檔案名稱:採購合約變更單累計定價明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmec_t
(
pmecent       number(5)      ,/* 企業編號 */
pmecsite       varchar2(10)      ,/* 營運據點 */
pmecdocno       varchar2(20)      ,/* 合約單號 */
pmec900       number(10,0)      ,/* 變更序 */
pmecseq       number(10,0)      ,/* 項次 */
pmecseq1       number(10,0)      ,/* 項序 */
pmec001       number(20,6)      ,/* 到達數量 */
pmec002       number(20,6)      ,/* 單價 */
pmec003       number(20,6)      ,/* 折扣率 */
pmec004       date      ,/* 數量到達日期 */
pmec005       varchar2(20)      ,/* 數量到達參考單號 */
pmec901       varchar2(10)      ,/* 變更類型 */
pmec902       varchar2(10)      ,/* 變更理由 */
pmec903       varchar2(255)      ,/* 變更備註 */
pmecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmecud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmec_t add constraint pmec_pk primary key (pmecent,pmecdocno,pmec900,pmecseq,pmecseq1) enable validate;

create unique index pmec_pk on pmec_t (pmecent,pmecdocno,pmec900,pmecseq,pmecseq1);

grant select on pmec_t to tiptop;
grant update on pmec_t to tiptop;
grant delete on pmec_t to tiptop;
grant insert on pmec_t to tiptop;

exit;
