/* 
================================================================================
檔案代號:pmap_t
檔案名稱:供應商料件預設條件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmap_t
(
pmapent       number(5)      ,/* 企業編號 */
pmapsite       varchar2(10)      ,/* 營運據點 */
pmap001       varchar2(10)      ,/* 供應商編號 */
pmap002       varchar2(10)      ,/* 採購控制組 */
pmap003       varchar2(40)      ,/* 料件編號 */
pmap004       varchar2(256)      ,/* 產品特徵 */
pmap005       varchar2(40)      ,/* 包裝容器 */
pmap006       varchar2(10)      ,/* 採購單位 */
pmap007       varchar2(10)      ,/* 參考單位 */
pmap008       varchar2(10)      ,/* 計價單位 */
pmap009       varchar2(10)      ,/* 收貨營運據點 */
pmap010       varchar2(10)      ,/* 收貨庫位 */
pmap011       varchar2(10)      ,/* 收貨儲位 */
pmap012       varchar2(10)      ,/* 收貨地址 */
pmap013       number(5,0)      ,/* 提前收貨天數 */
pmap014       varchar2(10)      ,/* 交運方式 */
pmapownid       varchar2(20)      ,/* 資料所有者 */
pmapowndp       varchar2(10)      ,/* 資料所屬部門 */
pmapcrtid       varchar2(20)      ,/* 資料建立者 */
pmapcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmapcrtdt       timestamp(0)      ,/* 資料創建日 */
pmapmodid       varchar2(20)      ,/* 資料修改者 */
pmapmoddt       timestamp(0)      ,/* 最近修改日 */
pmapstus       varchar2(10)      ,/* 狀態碼 */
pmapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmap_t add constraint pmap_pk primary key (pmapent,pmapsite,pmap001,pmap002,pmap003,pmap004) enable validate;

create unique index pmap_pk on pmap_t (pmapent,pmapsite,pmap001,pmap002,pmap003,pmap004);

grant select on pmap_t to tiptop;
grant update on pmap_t to tiptop;
grant delete on pmap_t to tiptop;
grant insert on pmap_t to tiptop;

exit;
