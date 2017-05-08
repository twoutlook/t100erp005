/* 
================================================================================
檔案代號:gzou_t
檔案名稱:企業編號設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzou_t
(
gzoustus       varchar2(10)      ,/* 狀態碼 */
gzou001       number(5)      ,/* 企業編號 */
gzou002       varchar2(80)      ,/* 企業編號說明 */
gzou003       varchar2(20)      ,/* 本號主資料庫 */
gzou004       varchar2(1)      ,/* 採用分散式部署 */
gzou005       varchar2(80)      ,/* 預設年月日表現方式 */
gzou006       varchar2(20)      ,/* 本號分散部署資料庫 */
gzouownid       varchar2(20)      ,/* 資料所有者 */
gzouowndp       varchar2(10)      ,/* 資料所屬部門 */
gzoucrtid       varchar2(20)      ,/* 資料建立者 */
gzoucrtdp       varchar2(10)      ,/* 資料建立部門 */
gzoucrtdt       timestamp(0)      ,/* 資料創建日 */
gzoumodid       varchar2(20)      ,/* 資料修改者 */
gzoumoddt       timestamp(0)      ,/* 最近修改日 */
gzouud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzouud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzouud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzouud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzouud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzouud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzouud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzouud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzouud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzouud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzouud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzouud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzouud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzouud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzouud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzouud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzouud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzouud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzouud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzouud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzouud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzouud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzouud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzouud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzouud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzouud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzouud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzouud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzouud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzouud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzou_t add constraint gzou_pk primary key (gzou001) enable validate;

create unique index gzou_pk on gzou_t (gzou001);

grant select on gzou_t to tiptop;
grant update on gzou_t to tiptop;
grant delete on gzou_t to tiptop;
grant insert on gzou_t to tiptop;

exit;
