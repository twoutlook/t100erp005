/* 
================================================================================
檔案代號:sflc_t
檔案名稱:工單挪料記錄套數單身檔（來源）
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sflc_t
(
sflcent       number(5)      ,/* 企業編號 */
sflcsite       varchar2(10)      ,/* 營運據點 */
sflcdocno       varchar2(20)      ,/* 挪料序號 */
sflcseq       number(10,0)      ,/* 項次 */
sflc001       varchar2(20)      ,/* 工單單號 */
sflc002       number(20,6)      ,/* 生產數量 */
sflc003       number(20,6)      ,/* 已發套數 */
sflc004       number(20,6)      ,/* 已入庫量 */
sflc005       number(20,6)      ,/* 撥出套數 */
sflcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sflcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sflcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sflcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sflcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sflcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sflcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sflcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sflcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sflcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sflcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sflcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sflcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sflcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sflcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sflcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sflcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sflcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sflcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sflcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sflcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sflcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sflcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sflcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sflcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sflcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sflcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sflcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sflcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sflcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sflc_t add constraint sflc_pk primary key (sflcent,sflcsite,sflcdocno,sflcseq) enable validate;

create unique index sflc_pk on sflc_t (sflcent,sflcsite,sflcdocno,sflcseq);

grant select on sflc_t to tiptop;
grant update on sflc_t to tiptop;
grant delete on sflc_t to tiptop;
grant insert on sflc_t to tiptop;

exit;
