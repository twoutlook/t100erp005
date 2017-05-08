/* 
================================================================================
檔案代號:pcae_t
檔案名稱:POS功能基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcae_t
(
pcaeent       number(5)      ,/* 企業編號 */
pcaeunit       varchar2(10)      ,/* 應用組織 */
pcae001       varchar2(40)      ,/* 功能編號 */
pcae002       varchar2(40)      ,/* 歸屬模塊 */
pcae003       varchar2(1)      ,/* 是否支付方式 */
pcae004       varchar2(10)      ,/* 功能類型 */
pcae005       varchar2(40)      ,/* 程序名稱 */
pcae006       varchar2(40)      ,/* 參數 */
pcae007       varchar2(1)      ,/* 是否打印 */
pcae008       varchar2(1)      ,/* 是否客顯 */
pcaestamp       timestamp(5)      ,/* 時間戳記 */
pcaestus       varchar2(10)      ,/* 狀態碼 */
pcaeownid       varchar2(20)      ,/* 資料所有者 */
pcaeowndp       varchar2(10)      ,/* 資料所屬部門 */
pcaecrtid       varchar2(20)      ,/* 資料建立者 */
pcaecrtdp       varchar2(10)      ,/* 資料建立部門 */
pcaecrtdt       timestamp(0)      ,/* 資料創建日 */
pcaemodid       varchar2(20)      ,/* 資料修改者 */
pcaemoddt       timestamp(0)      ,/* 最近修改日 */
pcaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcae_t add constraint pcae_pk primary key (pcaeent,pcae001) enable validate;

create unique index pcae_pk on pcae_t (pcaeent,pcae001);

grant select on pcae_t to tiptop;
grant update on pcae_t to tiptop;
grant delete on pcae_t to tiptop;
grant insert on pcae_t to tiptop;

exit;
