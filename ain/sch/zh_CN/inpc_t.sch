/* 
================================================================================
檔案代號:inpc_t
檔案名稱:盤點限定庫位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inpc_t
(
inpcent       number(5)      ,/* 企業編號 */
inpcsite       varchar2(10)      ,/* 營運據點 */
inpcdocno       varchar2(20)      ,/* 計劃單號 */
inpcseq       number(10,0)      ,/* 項次 */
inpc001       varchar2(10)      ,/* 庫位 */
inpc002       varchar2(255)      ,/* 備註 */
inpcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpc_t add constraint inpc_pk primary key (inpcent,inpcdocno,inpcseq) enable validate;

create unique index inpc_pk on inpc_t (inpcent,inpcdocno,inpcseq);

grant select on inpc_t to tiptop;
grant update on inpc_t to tiptop;
grant delete on inpc_t to tiptop;
grant insert on inpc_t to tiptop;

exit;
