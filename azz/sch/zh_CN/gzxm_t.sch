/* 
================================================================================
檔案代號:gzxm_t
檔案名稱:查詢方案單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxm_t
(
gzxmstus       varchar2(10)      ,/* 狀態碼 */
gzxment       number(5)      ,/* 企業編號 */
gzxm001       number(10,0)      ,/* QBE編號 */
gzxm002       varchar2(20)      ,/* 作業編號 */
gzxm003       varchar2(20)      ,/* 員工編號 */
gzxm004       varchar2(1)      ,/* 是否為預設 */
gzxm005       varchar2(1)      ,/* 首頁使用 */
gzxm006       number(10,0)      ,/* 查詢方案來源序號 */
gzxm007       varchar2(500)      ,/* 額外條件 */
gzxm008       number(10,0)      ,/* 分群編號 */
gzxmownid       varchar2(20)      ,/* 資料所有者 */
gzxmowndp       varchar2(10)      ,/* 資料所屬部門 */
gzxmcrtid       varchar2(20)      ,/* 資料建立者 */
gzxmcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzxmcrtdt       timestamp(0)      ,/* 資料創建日 */
gzxmmodid       varchar2(20)      ,/* 資料修改者 */
gzxmmoddt       timestamp(0)      ,/* 最近修改日 */
gzxm009       number(10,0)      ,/* 順序 */
gzxm010       varchar2(1)      ,/* 分享 */
gzxmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxm_t add constraint gzxm_pk primary key (gzxment,gzxm001,gzxm002,gzxm003) enable validate;

create unique index gzxm_pk on gzxm_t (gzxment,gzxm001,gzxm002,gzxm003);

grant select on gzxm_t to tiptop;
grant update on gzxm_t to tiptop;
grant delete on gzxm_t to tiptop;
grant insert on gzxm_t to tiptop;

exit;
