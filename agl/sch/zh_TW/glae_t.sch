/* 
================================================================================
檔案代號:glae_t
檔案名稱:核算項類型資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glae_t
(
glaeent       number(5)      ,/* 企業編號 */
glaeownid       varchar2(20)      ,/* 資料所有者 */
glaeowndp       varchar2(10)      ,/* 資料所屬部門 */
glaecrtid       varchar2(20)      ,/* 資料建立者 */
glaecrtdp       varchar2(10)      ,/* 資料建立部門 */
glaecrtdt       timestamp(0)      ,/* 資料創建日 */
glaemodid       varchar2(20)      ,/* 資料修改者 */
glaemoddt       timestamp(0)      ,/* 最近修改日 */
glaestus       varchar2(10)      ,/* 狀態碼 */
glae001       varchar2(10)      ,/* 核算項類型編號 */
glae002       varchar2(1)      ,/* 資料來源 */
glae003       varchar2(15)      ,/* 來源檔案 */
glae004       varchar2(20)      ,/* 來源編號欄位 */
glae005       varchar2(15)      ,/* 來源說明檔案 */
glae006       varchar2(20)      ,/* 來源說明欄位 */
glae007       number(5,0)      ,/* 資料截取起始位數 */
glae008       number(5,0)      ,/* 資料截取截止位數 */
glae009       varchar2(20)      ,/* 開窗查詢代號 */
glaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glae_t add constraint glae_pk primary key (glaeent,glae001) enable validate;

create unique index glae_pk on glae_t (glaeent,glae001);

grant select on glae_t to tiptop;
grant update on glae_t to tiptop;
grant delete on glae_t to tiptop;
grant insert on glae_t to tiptop;

exit;
