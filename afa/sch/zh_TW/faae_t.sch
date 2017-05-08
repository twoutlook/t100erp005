/* 
================================================================================
檔案代號:faae_t
檔案名稱:部門折舊費用科目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faae_t
(
faaeent       number(5)      ,/* 企業編號 */
faaeld       varchar2(5)      ,/* 帳套別編碼 */
faae001       varchar2(10)      ,/* 部門編碼 */
faae002       varchar2(10)      ,/* 資產主要類型 */
faae003       varchar2(24)      ,/* 折舊費用科目編號 */
faaeownid       varchar2(20)      ,/* 資料所有者 */
faaeowndp       varchar2(10)      ,/* 資料所屬部門 */
faaecrtid       varchar2(20)      ,/* 資料建立者 */
faaecrtdp       varchar2(10)      ,/* 資料建立部門 */
faaecrtdt       timestamp(0)      ,/* 資料創建日 */
faaemodid       varchar2(20)      ,/* 資料修改者 */
faaemoddt       timestamp(0)      ,/* 最近修改日 */
faaestus       varchar2(10)      ,/* 狀態碼 */
faaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faae_t add constraint faae_pk primary key (faaeent,faaeld,faae001,faae002) enable validate;

create unique index faae_pk on faae_t (faaeent,faaeld,faae001,faae002);

grant select on faae_t to tiptop;
grant update on faae_t to tiptop;
grant delete on faae_t to tiptop;
grant insert on faae_t to tiptop;

exit;
