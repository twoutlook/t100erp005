/* 
================================================================================
檔案代號:xmem_t
檔案名稱:包裝單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmem_t
(
xmement       number(5)      ,/* 企業編號 */
xmemsite       varchar2(10)      ,/* 營運據點 */
xmemdocno       varchar2(20)      ,/* 包裝單號 */
xmemseq       number(10,0)      ,/* 項次 */
xmem001       varchar2(20)      ,/* 來源單號 */
xmem002       number(10,0)      ,/* 來源項次 */
xmem003       varchar2(40)      ,/* 料件編號 */
xmem004       number(10,0)      ,/* 包裝序 */
xmem005       varchar2(40)      ,/* 包裝方式 */
xmem006       number(10,0)      ,/* 每箱裝數 */
xmem007       number(20,6)      ,/* 箱數 */
xmem008       varchar2(10)      ,/* 字軌 */
xmem009       varchar2(10)      ,/* 棧板號 */
xmem010       number(10,0)      ,/* 起始包裝箱號 */
xmem011       number(10,0)      ,/* 截止包裝箱號 */
xmem012       number(20,6)      ,/* 數量 */
xmem013       varchar2(10)      ,/* 重量單位 */
xmem014       number(20,6)      ,/* 單位淨重 */
xmem015       number(20,6)      ,/* 總淨重 */
xmem016       number(20,6)      ,/* 單位毛重 */
xmem017       number(20,6)      ,/* 總毛重 */
xmem018       number(20,6)      ,/* 單位材積 */
xmem019       number(20,6)      ,/* 總材積 */
xmemud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmemud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmemud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmemud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmemud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmemud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmemud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmemud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmemud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmemud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmemud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmemud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmemud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmemud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmemud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmemud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmemud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmemud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmemud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmemud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmemud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmemud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmemud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmemud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmemud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmemud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmemud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmemud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmemud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmemud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmem_t add constraint xmem_pk primary key (xmement,xmemdocno,xmemseq) enable validate;

create unique index xmem_pk on xmem_t (xmement,xmemdocno,xmemseq);

grant select on xmem_t to tiptop;
grant update on xmem_t to tiptop;
grant delete on xmem_t to tiptop;
grant insert on xmem_t to tiptop;

exit;
