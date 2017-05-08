/* 
================================================================================
檔案代號:gzae_t
檔案名稱:單據性質檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzae_t
(
gzaestus       varchar2(10)      ,/* 狀態碼 */
gzae001       varchar2(4)      ,/* 系統編號 */
gzae002       varchar2(10)      ,/* 單據性質 */
gzae003       varchar2(1)      ,/* 系統標準 */
gzaeownid       varchar2(20)      ,/* 資料所有者 */
gzaeowndp       varchar2(10)      ,/* 資料所屬部門 */
gzaecrtid       varchar2(20)      ,/* 資料建立者 */
gzaecrtdp       varchar2(10)      ,/* 資料建立部門 */
gzaecrtdt       timestamp(0)      ,/* 資料創建日 */
gzaemodid       varchar2(20)      ,/* 資料修改者 */
gzaemoddt       timestamp(0)      ,/* 最近修改日 */
gzaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzae_t add constraint gzae_pk primary key (gzae001,gzae002) enable validate;

create  index gzae_01 on gzae_t (gzae001);
create unique index gzae_pk on gzae_t (gzae001,gzae002);

grant select on gzae_t to tiptop;
grant update on gzae_t to tiptop;
grant delete on gzae_t to tiptop;
grant insert on gzae_t to tiptop;

exit;
